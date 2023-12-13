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

module acm
(
	input logic s_clk_i[3],             //clock signal
    input logic s_resetn_i[3],          //reset signal

    input logic[31:0] s_mawb_val_i[3],  //instruction result from WB stage
    input rf_add s_mawb_add_i[3],       //destination register address from WB stage
    input ictrl s_mawb_ictrl_i[3],      //instruction control indicator from WB stage
    input rf_add s_exma_add_i[3],       //destination register address from MA stage
    input ictrl s_exma_ictrl_i[3],      //instruction control indicator from MA stage
    input rf_add s_opex_add_i[2],       //destination register address from EX stage
    input ictrl s_opex_ictrl_i[2],      //instruction control indicator from EX stage

    input rf_add s_r_p1_add_i[2],       //read port 1 address
    input rf_add s_r_p2_add_i[2],       //read port 2 address
    input logic[31:0] s_r_p1_val_i,     //value read through port 1
    input logic[31:0] s_r_p2_val_i,     //value read through port 1

    output rp_info s_uce_o[2],          //uncorrectable error
    output rp_info s_ce_o[2],           //correctable error

    output logic[31:0] s_val_o,         //write value
    output rf_add s_add_o,              //write address
    output logic s_we_o                 //write request
);

    logic s_write[1];
    logic[6:0] s_r1_checksum, s_r2_checksum, s_w_checksum[1], s_w1_checksum[3], 
                s_r1_achecksum[2], s_r2_achecksum[2], s_r1_syndrome[2], s_r2_syndrome[2];
    logic s_r1_ce[2], s_r1_uce[2], s_r2_ce[2], s_r2_uce[2];
    logic[31:0] s_r1_dec[2], s_r2_dec[2], s_wacm_val[2], s_racm_val[2], s_repair_val[2], s_file_w_val[3], s_w_data[1];
    logic s_file_we[3], s_mawb_we[3];
    rf_add s_file_w_add[3], s_w_address[1], s_wacm_add[2], s_racm_add[2], s_repair_add[2];
    rp_info s_rp1_info[2], s_rp2_info[2];
    logic s_rs1_repreq[2], s_rs2_repreq[2], s_rs2_repair[2], s_rs1_repair[2];
    logic[1:0] s_fwd[2], s_valid_err[2];
    logic s_acm_neq[2], s_repair[2], s_fix_ce[3];
    logic s_clk_prw[2], s_resetn_prw[2];
    logic s_wacm_rep[2],s_racm_rep[2];

    seu_regs #(.LABEL("ACM_REP"),.W(1),.N(2))   m_acm_rep (.s_c_i(s_clk_prw),.s_d_i(s_wacm_rep),.s_d_o(s_racm_rep));
    seu_regs #(.LABEL("ACM_ADD"),.W(5),.N(2))   m_acm_add (.s_c_i(s_clk_prw),.s_d_i(s_wacm_add),.s_d_o(s_racm_add));
    seu_regs #(.LABEL("ACM_VAL"),.N(2))         m_acm_val (.s_c_i(s_clk_prw),.s_d_i(s_wacm_val),.s_d_o(s_racm_val));

    //checksum register file
    logic[6:0]r_checksum_file[0:31] = '{default:0};

    //read port 1
    assign s_r1_checksum     = r_checksum_file[s_r_p1_add_i[0]];
    //read port 2
    assign s_r2_checksum     = r_checksum_file[s_r_p2_add_i[0]];

    assign s_val_o  = s_w_data[0];
    assign s_add_o  = s_w_address[0];
    assign s_we_o   = s_write[0];
    
    genvar i;
    generate
        /* Automatic Ccorrection Mechanism*/
        for (i = 0; i<2 ; i++ ) begin : acm_replicator
            assign s_clk_prw[i]     = s_clk_i[i];
            assign s_resetn_prw[i]  = s_resetn_i[i];
            //uncorrectable error at read ports
            assign s_uce_o[i]       = {s_rp2_info[i][1],s_rp1_info[i][1]};
            //correctable error at read ports
            assign s_ce_o[i]        = {s_rs2_repreq[i],s_rs1_repreq[i]};
            //value directly from register x0 is never used, so fault in it is ignored
            assign s_valid_err[i][0]= s_r_p1_add_i[i] != 5'b0;
            assign s_valid_err[i][1]= s_r_p2_add_i[i] != 5'b0;
            //error information signals, info from x0 is ignored
            assign s_rp1_info[i]    = {s_r1_uce[i] & s_valid_err[i][0], s_r1_ce[i] & s_valid_err[i][0]};
            assign s_rp2_info[i]    = {s_r2_uce[i] & s_valid_err[i][1], s_r2_ce[i] & s_valid_err[i][1]};
            //check whether value for read port 1 can be forwarded
            assign s_fwd[i][0]      = (s_mawb_add_i[i] == s_r_p1_add_i[i] & s_mawb_ictrl_i[i][ICTRL_REG_DEST]) || 
                                      (s_exma_add_i[i] == s_r_p1_add_i[i] & s_exma_ictrl_i[i][ICTRL_REG_DEST]) || 
                                      (s_opex_add_i[i] == s_r_p1_add_i[i] & s_opex_ictrl_i[i][ICTRL_REG_DEST]);
            //check whether value for read port 2 can be forwarded
            assign s_fwd[i][1]      = (s_mawb_add_i[i] == s_r_p2_add_i[i] & s_mawb_ictrl_i[i][ICTRL_REG_DEST]) || 
                                      (s_exma_add_i[i] == s_r_p2_add_i[i] & s_exma_ictrl_i[i][ICTRL_REG_DEST]) || 
                                      (s_opex_add_i[i] == s_r_p2_add_i[i] & s_opex_ictrl_i[i][ICTRL_REG_DEST]);
            //repair request - correctable errors, which cannot be forwarded   
            assign s_rs1_repreq[i]  =  (~s_fwd[i][0] & s_rp1_info[i][0]);  
            assign s_rs2_repreq[i]  =  (~s_fwd[i][1] & s_rp2_info[i][0]);                                  
            //repair request is valid, if no write to the faulty register is ongoing
            assign s_rs1_repair[i]  = (s_rs1_repreq[i] & (~s_file_we[i] | (s_file_w_add[i] != s_r_p1_add_i[i])));
            assign s_rs2_repair[i]  = (s_rs2_repreq[i] & (~s_file_we[i] | (s_file_w_add[i] != s_r_p2_add_i[i])));

            //if replicas of repair-request registers have discrepancies, invalidate the request
            assign s_acm_neq[i] = (s_racm_add[0] != s_racm_add[1]) | (s_racm_val[0] != s_racm_val[1]) | (s_racm_rep[0] != s_racm_rep[1]);
            //request to repair value at read port 2 has a higher priority
            assign s_repair_add[i]  = (s_rs2_repair[i]) ? s_r_p2_add_i[i] : s_r_p1_add_i[i];
            //takes corrected value
            assign s_repair_val[i]  = (s_rs2_repair[i]) ? s_r2_dec[i] : s_r1_dec[i];
            //prepare write to register file in the next clock cycle
            assign s_repair[i]      = (s_rs2_repair[i] | s_rs1_repair[i]);

            always_comb begin : acm_block_rs2
                if(~s_resetn_i[i])begin
                    s_wacm_rep[i]  = 1'b0;
                    s_wacm_add[i]  = 5'b0;
                    s_wacm_val[i]  = 32'b0;
                end else if(s_racm_rep[i] & s_mawb_ictrl_i[i][ICTRL_REG_DEST])begin
                    //delay repair by one clock cycle, if WB stage performs write
                    //invalidate repair request, if WB stage is writing to the  register waiting to repair
                    s_wacm_rep[i]  = (s_mawb_add_i[i] != s_racm_add[i]);
                    s_wacm_add[i]  = s_racm_add[i];
                    s_wacm_val[i]  = s_racm_val[i]; 
                end else begin
                    //new repair request
                    s_wacm_rep[i]  = s_repair[i];
                    s_wacm_add[i]  = s_repair_add[i];
                    s_wacm_val[i]  = s_repair_val[i];
                end
            end
        end

        for (i =0 ; i<3 ;i++ ) begin : acm_replicator_1
            //write enable from WB stage
            assign s_mawb_we[i]     = s_mawb_ictrl_i[i][ICTRL_REG_DEST];
            //write request by ACM
            assign s_fix_ce[i]      = s_racm_rep[i%2] & ~s_acm_neq[0] & ~s_acm_neq[1];
            //write enable signal for the register file
            assign s_file_we[i]     = s_mawb_we[i] | s_fix_ce[i];
            //value to be written to the register file
            assign s_file_w_val[i]  = (s_mawb_we[i]) ? s_mawb_val_i[i] : s_racm_val[i%2];
            //address for the write port of the register file
            assign s_file_w_add[i]  = (s_mawb_we[i]) ? s_mawb_add_i[i] : s_racm_add[i%2];       
        end

        for (i = 0; i<2 ;i++ ) begin : codeword_analyzer
            secded_encode m_p1_encode   (.s_data_i(s_r_p1_val_i),.s_checksum_o(s_r1_achecksum[i]));
            secded_analyze m_p1_analyze (.s_syndrome_i(s_r1_syndrome[i]),.s_ce_o(s_r1_ce[i]),.s_uce_o(s_r1_uce[i]));
            secded_decode m_p1_decode   (.s_data_i(s_r_p1_val_i),.s_syndrome_i(s_r1_syndrome[i]),.s_data_o(s_r1_dec[i]));
            assign s_r1_syndrome[i]     = s_r1_achecksum[i] ^ s_r1_checksum;

            secded_encode m_p2_encode   (.s_data_i(s_r_p2_val_i),.s_checksum_o(s_r2_achecksum[i]));
            secded_analyze m_p2_analyze (.s_syndrome_i(s_r2_syndrome[i]),.s_ce_o(s_r2_ce[i]),.s_uce_o(s_r2_uce[i]));
            secded_decode m_p2_decode   (.s_data_i(s_r_p2_val_i),.s_syndrome_i(s_r2_syndrome[i]),.s_data_o(s_r2_dec[i]));
            assign s_r2_syndrome[i]     = s_r2_achecksum[i] ^ s_r2_checksum;
        end
        for (i =0 ;i<3 ;i++ ) begin : codeword_encoder
            secded_encode m_w1_encode
            (
                .s_data_i(s_file_w_val[i]),
                .s_checksum_o(s_w1_checksum[i])
            );
        end
    endgenerate

    //Tripple modula redundancy - final write, WARNING: potential single point of failure
    tmr_comb #(.W(1),.OUT_REPS(1)) m_tmr_write (.s_d_i(s_file_we),.s_d_o(s_write));
    tmr_comb #(.W(5),.OUT_REPS(1)) m_tmr_address (.s_d_i(s_file_w_add),.s_d_o(s_w_address));
    tmr_comb #(.W(7),.OUT_REPS(1)) m_tmr_checksum (.s_d_i(s_w1_checksum),.s_d_o(s_w_checksum));
    tmr_comb #(.W(32),.OUT_REPS(1)) m_tmr_data (.s_d_i(s_file_w_val),.s_d_o(s_w_data));

`ifdef SEE_TESTING
    int j;
    logic[6:0] s_upset[32];
    see_insert #(.W(7),.N(32),.GROUP(SEEGR_REG_FILE),.LABEL("ACMRF")) see (.s_clk_i(s_clk_i[2]),.s_upset_o(s_upset));
`endif

    always_ff @( posedge s_clk_i[2] ) begin : rf_writer
        if(s_write[0])begin
            r_checksum_file[s_w_address[0]] <= s_w_checksum[0]
`ifdef SEE_TESTING            
            ^ s_upset[s_w_address[0]]
`endif 
            ;
        end
`ifdef SEE_TESTING  
        for (j=1;j<32;j++) begin
            if(!(s_write[0] & (s_w_address[0] == j)))
                r_checksum_file[j] <= r_checksum_file[j] ^ s_upset[j];
        end
`endif
    end

endmodule