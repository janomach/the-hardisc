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

`include "settings.sv"
import p_hardisc::*;

module ras
(
    input logic s_clk_i,                //clock signal
    input logic s_resetn_i,             //reset signal
    input logic s_flush_i,              //flush signal
    input logic s_enable_i,             //enable prediction
    input logic s_invalidate_i,         //invalidate all entries
    input logic s_valid_i,              //fetched data valid in the next clock cycle
    input logic s_ualign_i,             //fetched data are unaligned
    input logic[31:0] s_data_i,         //fetched data
    input logic[29:0] s_fetch_addr_i,   //address of the fetched data in the next clock cycle

    output logic[1:0] s_poped_o,        //[0]([1]) - predicted TOC from aligned (unaligned) part of the fetched data
    output logic[30:0] s_pop_addr_o     //predicted target address
);
    /*
        The Return Address Stack (RAS) predicts next fetch address from the data fetched previously. 
        It performs simply decoding, while is looking for JAL and JALR instruction. These instructions
        can push/pop addresses into the stack. During push, incremented address is saved into the circular
        buffer. On the other hand, during pop, the newest buffer entry (top of the stack) is used to
        predict the next fetch address. 

        The core tries to minimize I2R paths from the fetch interface, with sacrificing prediction speed,
        so the instruction decoding is not performed on data coming directly from the interface, but the RAS 
        takes the last pushed data into the IFB. Since the address information is not saved in the IFB it is 
        temporaly copied into the internal register for timing purposes.
    */

    logic[15:0] s_winstr[1], s_rinstr[1];
    logic[29:0] s_waddress[1], s_raddress[1];
    logic s_wutd[1], s_rutd[1], s_wurvi[1], s_rurvi[1];
    
    //Indicates that first part of unaligned RVI is saved
    seu_regs #(.LABEL("RAS_URVI"),.GROUP(5),.W(1),.N(1),.NC(1)) m_seu_urvi(.s_c_i({s_clk_i}),.s_d_i(s_wurvi),.s_d_o(s_rurvi));
    //First part of unaligned RVI
    seu_regs #(.LABEL("RAS_INSTR"),.GROUP(5),.W(16),.N(1),.NC(1)) m_seu_instr(.s_c_i({s_clk_i}),.s_d_i(s_winstr),.s_d_o(s_rinstr));
    //Up-to-date indicator of saved address and incomming fetched data
    seu_regs #(.LABEL("RAS_UTD"),.GROUP(5),.W(1),.N(1),.NC(1)) m_seu_utd(.s_c_i({s_clk_i}),.s_d_i(s_wutd),.s_d_o(s_rutd));
    //Saved address
    seu_regs #(.LABEL("RAS_ADDRESS"),.GROUP(5),.W(30),.N(1),.NC(1)) m_seu_address(.s_c_i({s_clk_i}),.s_d_i(s_waddress),.s_d_o(s_raddress));

    logic s_ipop, s_ipush, s_jal, s_jalr, s_rs1, s_rs5, s_rd1, s_rd5, s_rseqrd, s_pop, s_push, s_empty, s_cvalid[2], s_ivalid;
    logic[1:0] s_cpush, s_cpop, s_cjal, s_cjr, s_cjalr, s_poped; 
    logic[30:0] s_pop_addr, s_save_addr;
    logic[31:0] s_instruction_0;
    logic s_urvi_valid;

    see_wires #(.LABEL("RAS_OUT_ADD"),.GROUP(9),.W(31)) see_pred_add(.s_c_i(s_clk_i),.s_d_i(s_pop_addr),.s_d_o(s_pop_addr_o));
    see_wires #(.LABEL("RAS_OUT_POP"),.GROUP(9),.W(2))  see_pred_pop(.s_c_i(s_clk_i),.s_d_i(s_poped),.s_d_o(s_poped_o));

    assign s_poped[0]   = (s_ipop | s_cpop[0]) & s_rutd[0] & !s_empty & s_enable_i;
    assign s_poped[1]   = (s_cpop[1]) & !s_empty & s_rutd[0] & ~s_poped[0] & s_enable_i;

    //Fetch address and valid information for the next clock cycle
    always_comb begin
        if(~s_resetn_i | s_flush_i)begin
            s_wutd[0]       = 1'b0; 
            s_waddress[0]   = 30'b0;
        end else begin
            s_wutd[0]       = s_valid_i;
            s_waddress[0]   = s_fetch_addr_i;
        end
    end

    //Indicates that the first part of unaligned instruction is saved
    assign s_urvi_valid = s_rurvi[0] & ~s_ualign_i; 

    //Check of incoming data and decision whether half of the instruction should be saved 
    always_comb begin
        if(~s_resetn_i | s_flush_i)begin
            s_winstr[0] = 16'b0;
            s_wurvi[0]  = 1'b0;
        end else if(s_rutd[0]) begin
            if(s_urvi_valid)begin
                //check and save of the next unaligned RVI
                s_winstr[0] = s_data_i[31:16];
                s_wurvi[0]  = (s_data_i[17:16] == 2'b11);
            end else begin
                if(s_ualign_i & (s_data_i[1:0] == 2'b11)) begin
                    //unaligned RVI is comming
                    s_winstr[0] = s_data_i[15:0];
                    s_wurvi[0]  = 1'b1;
                end else if(~s_ualign_i & (s_data_i[1:0] != 2'b11) & (s_data_i[17:16] == 2'b11))begin 
                    //aligned RVC instruction followed by unaligned RVI
                    s_winstr[0] = s_data_i[31:16];
                    s_wurvi[0]  = 1'b1;
                end else begin
                    s_winstr[0] = 16'b0;
                    s_wurvi[0]  = 1'b0;
                end
            end
        end else begin
            s_winstr[0] = s_rinstr[0];
            s_wurvi[0]  = s_rurvi[0];
        end
    end

    //Instruction aligning
    assign s_instruction_0 = (s_urvi_valid) ? {s_data_i[15:0],s_rinstr[0]} : s_data_i[31:0];

    //Decoding and evaluation of RVI instruction
    assign s_rs1    = s_instruction_0[19:15] == 5'd1;
    assign s_rs5    = s_instruction_0[19:15] == 5'd5;
    assign s_rd1    = s_instruction_0[11:7] == 5'd1;
    assign s_rd5    = s_instruction_0[11:7] == 5'd5;
    assign s_rseqrd = s_instruction_0[11:7] == s_instruction_0[19:15];
    assign s_ivalid = ((~s_rurvi[0] & ~s_ualign_i & (s_data_i[1:0] == 2'b11) & ~s_ualign_i)  | s_urvi_valid);
    assign s_jal    = (s_instruction_0[6:2] == OPC_JAL) & s_ivalid;
    assign s_jalr   = (s_instruction_0[6:2] == OPC_JALR) & s_ivalid;
    assign s_ipush  = (s_jal & (s_rd1 | s_rd5)) | (s_jalr & (s_rd1 | s_rd5));
    assign s_ipop   = (s_jalr & !(s_rd1 | s_rd5) & (s_rs1 | s_rs5)) |
                      (s_jalr & (s_rd1 | s_rd5) & (s_rs1 | s_rs5) & !s_rseqrd);
    //Decoding and evaluation of aligned RVC instruction
    assign s_cvalid[0] = ~s_rurvi[0] & ~s_ualign_i;
    assign s_cjal[0]   = (s_data_i[15:13] == 3'b001) & (s_data_i[1:0] == 2'b01) & s_cvalid[0]; 
    assign s_cjr[0]    = (s_data_i[15:12] == 4'b1000) & (s_data_i[6:0] == 7'b10) & s_cvalid[0];
    assign s_cjalr[0]  = (s_data_i[15:12] == 4'b1001) & (s_data_i[6:0] == 7'b10) & s_cvalid[0];
    assign s_cpush[0]  = s_cjal[0] | s_cjalr[0];
    assign s_cpop[0]   = (s_cjr[0] & ((s_data_i[11:7] == 5'd1) | (s_data_i[11:7] == 5'd5))) | 
                         (s_cjalr[0] & (s_data_i[11:7] == 5'd5));
    //Decoding and evaluation of unaligned RVC instruction
    assign s_cvalid[1] = s_urvi_valid | (~s_ualign_i & (s_data_i[1:0] != 2'b11));
    assign s_cjal[1]   = (s_data_i[31:29] == 3'b001) & (s_data_i[17:16] == 2'b01) & s_cvalid[1]; 
    assign s_cjr[1]    = (s_data_i[31:28] == 4'b1000) & (s_data_i[22:16] == 7'b10) & s_cvalid[1];
    assign s_cjalr[1]  = (s_data_i[31:28] == 4'b1001) & (s_data_i[22:16] == 7'b10) & s_cvalid[1];  
    assign s_cpush[1]  = s_cjal[1] | s_cjalr[1];
    assign s_cpop[1]   = (s_cjr[1] & ((s_data_i[27:23] == 5'd1) | (s_data_i[27:23] == 5'd5))) | 
                         (s_cjalr[1] & (s_data_i[27:23] == 5'd5));

    //Final evaluation of RAS pop/push conditions
    assign s_pop    = (s_ipop | (s_cpop != 2'b0)) & s_rutd[0] & ~s_flush_i & s_enable_i;
    assign s_push   = (s_ipush | (s_cpush != 2'b0)) & s_rutd[0] & ~s_flush_i;

    assign s_save_addr = ((s_urvi_valid & s_ipush) | s_cpush[0]) ? ({s_raddress[0],1'b1}) : ({s_raddress[0] + 30'd1,1'b0});                       

    //Return Address Stack Buffer
    circular_buffer #(.LABEL("RAS"),.GROUP(5),.SIZE(`OPTION_RAS_SIZE),.WIDTH(31)) buffer
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i & ~s_invalidate_i),

        .s_push_i(s_push),
        .s_pop_i(s_pop),
        .s_data_i(s_save_addr),
        .s_empty_o(s_empty),
        .s_data_o(s_pop_addr)
    );
    
endmodule
