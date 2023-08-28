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

#define GETMYTIME(_t) \
  uint32_t tmp1, tmp2, tmp3;\
  do {\
    __asm__ volatile ("csrr %0, mcycleh\n\tcsrr %1, mcycle\n\tcsrr %2, mcycleh" :  "=r"(tmp1), "=r"(tmp2), "=r"(tmp3) : );\
  } while (tmp1 != tmp3);\
  *_t = (uint64_t)tmp1 << 32 | (uint64_t)tmp2;

uint64_t cycles;

void get_cycles()
{
	GETMYTIME(&cycles);
}

int main(void)
{

	printf("Hello world!\n");
	while(1){
    get_cycles();
    printf("Clock cycles since boot: %d\n",(uint32_t)cycles);
  }

	return 0;
}

