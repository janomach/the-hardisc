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

//This example is inspired by https://www.geeksforgeeks.org/implementation-falling-matrix/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define STDOUT_REG 0x80000000
#define FREQUENCY 75000000u

#define GETMYTIME(_t) \
  uint32_t tmp1, tmp2, tmp3;\
  do {\
    __asm__ volatile ("csrr %0, mcycleh\n\tcsrr %1, mcycle\n\tcsrr %2, mcycleh" :  "=r"(tmp1), "=r"(tmp2), "=r"(tmp3) : );\
  } while (tmp1 != tmp3);\
  *_t = (uint64_t)tmp1 << 32 | (uint64_t)tmp2;

const char ch[58] = "1234567890qwertyuiopasdfghjklzxcvbnm,./';[]!@#$%^&*()-=_+";
static uint8_t switches[30];

// Direct store to STDOUT_REG (instead of printf) is used to speed-up the simulation
inline void direct_char_print (char c)
{
 *(volatile int *)STDOUT_REG = c;
}

void delay(uint64_t cycles)
{
  uint64_t cycles_now;
  GETMYTIME(&cycles_now);
  cycles += cycles_now;
  do {
    GETMYTIME(&cycles_now);
  } while(cycles_now < cycles);
}


void matrix()
{
	uint8_t i=0, x=0;

  for (i=0; i!=2; ++i)
  {
    x = rand() % 30;
    switches[x] = !switches[x];
  }

  // Loop over the width
  direct_char_print('|');
  direct_char_print(' ');
  for (i=0;i<30;i+=1)
  {
    if (switches[i])
      direct_char_print(ch[rand() % 57]);
    else
      direct_char_print(' ');
    direct_char_print(' ');
  }
  direct_char_print('|');
  direct_char_print('\n');
}

int main(void)
{
	printf("The Matrix HAS you!\n");

	while(1)
	{
		matrix();
    delay(FREQUENCY/10);
	}

	return 0;
}

