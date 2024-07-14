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

.section .vectors, "ax"
.option norvc
.align 4
vector_table:
	j _exc_handler      //User software interrupt / Exception entry handler
	j _no_irq_handler   //Supervisor software interrupt
	j _no_irq_handler   //Reserved for future use
	j _no_irq_handler   //Machine software interrupt
	j _no_irq_handler   //User timer interrupt
	j _no_irq_handler   //Supervisor timer interrupt
	j _no_irq_handler   //Reserved for future use
	j _no_irq_handler   //Machine timer interrupt
	j _no_irq_handler   //User external interrupt
	j _no_irq_handler   //Supervisor external interrupt
	j _no_irq_handler   //Reserved for future use
	j _no_irq_handler   //Machine external interrupt
	j _no_irq_handler   //Reserved for future standard use
	j _no_irq_handler   //Reserved for future standard use
	j _no_irq_handler   //Reserved for future standard use
	j _no_irq_handler   //Reserved for future standard use
	j _no_irq_handler   //Uncorrectable error in the register file - early indication
    j _fcer_irq_handler //Fetch correctable error
    j _lcer_irq_handler //Load correctable error
    j _no_irq_handler   //NMI - Fetch uncorrectable error
    j _no_irq_handler   //NMI - Load uncorrectable error
    j _no_irq_handler   //NMI - Register-file uncorrectable error during execution

_no_irq_handler:
    tail abort

_exc_handler:
    tail abort

_fcer_irq_handler:
    csrw mscratch, a0   //save context of a0
    csrw mcause, a1     //save context of a1 - mcause value is not required
    csrr a0,0xfc0       //read address at which the correctable error resides
    /* It is not detectable whether the error is on lower or upper 16-bits of unaligned RVI
       For the sake of simplicity, we always correct also the following aligned address */
    lw a1, 0x4(a0)      //load value with correctable error - the error is corrected during loading
    sw a1, 0x4(a0)      //store corrected value
    j _cer_irq_finish   //finish the correction

_lcer_irq_handler:
    csrw mscratch, a0   //save context of a0
    csrw mcause, a1     //save context of a1 - mcause value is not required
    csrr a0,0xfc0       //read address at which the correctable error resides
_cer_irq_finish:
    lw a1, 0x0(a0)      //load value with correctable error - the error is corrected during loading
    sw a1, 0x0(a0)      //store corrected value
    /* Since the maddrerr CSR holds the address value for both, fetch and load, it is required to clear 
       both interrupt sources. The maddrerr is not rewritten if one of the interrupt is already pending. */
    li a0, 3            
	slli a0, a0, 13
    csrc mip, a0        //clear interrupts
    csrr a0, mscratch   //restore context of a0
    csrr a1, mcause     //restore context of a1
    mret                //return to execute the corrected instruction 
