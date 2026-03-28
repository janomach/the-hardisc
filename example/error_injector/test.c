/*
   Copyright 2023 Ján Mach

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define SEM_ADDRESS 0x80002000
#define RAM_END 0x10020000
#define FREQUENCY 75000000u

#define GETMYTIME(_t) \
  uint32_t tmp1, tmp2, tmp3;\
  do {\
    __asm__ volatile ("csrr %0, mcycleh\n\tcsrr %1, mcycle\n\tcsrr %2, mcycleh" :  "=r"(tmp1), "=r"(tmp2), "=r"(tmp3) : );\
  } while (tmp1 != tmp3);\
  *_t = (uint64_t)tmp1 << 32 | (uint64_t)tmp2;

void delay(uint64_t cycles)
{
  uint64_t cycles_now;
  GETMYTIME(&cycles_now);
  cycles += cycles_now;
  do {
    GETMYTIME(&cycles_now);
  } while(cycles_now < cycles);
}

int main(void)
{
	printf("Checking SEM component...\n");

  uint32_t data, err_lfa, err_word, err_bit, err_count = 1, current_delay, total_delay = 0, max_delay = 0, lock_count = 0, livelocks = 0;
  uint64_t cycles_now, cycles_prev;

  do {
    data = *(volatile uint32_t *)SEM_ADDRESS;
  } while((data & 0x4) == 0);

  printf("Sending SEM to the IDLE state...\n");

  *(volatile int *)(SEM_ADDRESS + 0xC) = 0xE0;
  *(volatile int *)(SEM_ADDRESS + 0x4) = 1;
  delay(FREQUENCY/2);

  do {
    data = *(volatile uint32_t *)SEM_ADDRESS;
  } while((data & 0x4) != 0);

  printf("SEM is in IDLE state...\n");

  data = *(volatile uint32_t *)(RAM_END - 0x4);

  printf("Random seed: 0x%8x\n", data);

  srand(data);

  GETMYTIME(&cycles_prev);

	while(1){

    __asm__ volatile ("csrr %0, 0x7C0\n\t" :  "=r"(data));

    if((data & 0x4) != 0) {
      livelocks++;
      __asm__ volatile ("csrci 0x7C0, 0x4\n\t");
    }

    err_lfa  = (rand() & 0x1FFFF) % 0x11B6; //0x11B6 is a limit in 7A35T
    err_word = (rand() & 0x7F) % 0x65; //0x65 is a limit in 7 Series
    err_bit = rand() & 0x1F;

    printf("Fault injection %6d, livelocks %4d: \n\t-> Target LFA: 0x%05x, WORD: 0x%02x, BIT: 0x%02x\n", err_count, livelocks, err_lfa, err_word, err_bit);

    *(volatile int *)(SEM_ADDRESS + 0xC) = 0xC0;
    *(volatile int *)(SEM_ADDRESS + 0x8) = (err_lfa << 12) | (err_word << 5) | (err_bit);
    *(volatile int *)(SEM_ADDRESS + 0x4) = 1;

    GETMYTIME(&cycles_now);
    current_delay = (uint32_t)(cycles_now - cycles_prev);
    total_delay += current_delay;

    if(current_delay > max_delay)
      max_delay = current_delay;

    cycles_prev = cycles_now;

    printf("\t-> Delay CUR: %6d us, AVG: %6d us, MAX: %6d us\n", current_delay / (FREQUENCY / 1000000), 
                                                             (total_delay / err_count) / (FREQUENCY / 1000000), 
                                                             max_delay / (FREQUENCY / 1000000));

    do {
      data = *(volatile uint32_t *)SEM_ADDRESS;
    } while((data & 0x30) != 0); //wait until injection and classification is done

    if((data & 0x4) != 0) { //observation
      *(volatile int *)(SEM_ADDRESS + 0xC) = 0xE0;
      *(volatile int *)(SEM_ADDRESS + 0x4) = 1;
      do {
        data = *(volatile uint32_t *)SEM_ADDRESS;
      } while((data & 0x4) != 0);
    } else { //idle
      //printf("Uncorrectable error detected\n");
    }

    err_count++;
  }

	return 0;
}

