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

    input rf_add s_r_p1_add_i[2],       //read port 1 address
    input rf_add s_r_p2_add_i[2],       //read port 2 address
    input logic[31:0] s_r_p1_val_i[2],  //value read through port 1
    input logic[31:0] s_r_p2_val_i[2],  //value read through port 1

    input logic[31:0] s_mhrdctrl0_i[3], //settings

    output logic[31:0] s_val_o[2],      //write value
    output rf_add s_add_o[2],           //write address
    output logic s_we_o[2]              //write request
);

    logic[6:0] s_w_checksum[2], s_acm_achecksum[2], s_acm_syndrome[2],
               s_rf0_checksum[1], s_rf1_checksum[1], s_rp_checksum[2];
    logic[1:0] s_racm_fsm[2], s_wacm_fsm[2];
    logic[31:0] s_acm_dec[2], s_wacm_val[2], s_racm_val[2], s_repair_val[2], s_file_w_val[2], s_w_data[2];
    logic s_file_we[2], s_mawb_we[3], s_acm_repair[2];
    rf_add s_file_w_add[2], s_w_address[2], s_wacm_add[2], s_racm_add[2], s_repair_add[2];
    logic s_rs1_repreq[2], s_rs2_repreq[2], s_rs2_repair[2], s_rs1_repair[2];
    logic s_acm_neq[2], s_repair[2], s_fix_ce[2], s_acm_val_neq[2], s_acm_chs_eq[2];
    logic s_clk_prw[2], s_resetn_prw[2], s_rf0_we, s_rf1_we;
    logic s_acm_we[2], s_corr[2], s_write[2], s_acm_ce[2], s_acm_error[2];
    logic s_ecc_enabled[2];

    seu_ff_we #(.LABEL("ACM_ADD"),.W(5),.N(2))   m_acm_add (.s_c_i(s_clk_prw),.s_we_i(s_acm_we),.s_d_i(s_wacm_add),.s_q_o(s_racm_add));
    seu_ff_we #(.LABEL("ACM_VAL"),.N(2))   m_acm_val (.s_c_i(s_clk_prw),.s_we_i(s_acm_we),.s_d_i(s_wacm_val),.s_q_o(s_racm_val));
    seu_ff_we_rst #(.LABEL("ACM_FSM"),.W(2),.N(2))   m_acm_fsm (.s_c_i(s_clk_prw),.s_r_i(s_resetn_prw),.s_we_i(s_acm_we),.s_d_i(s_wacm_fsm),.s_q_o(s_racm_fsm));

    assign s_val_o  = s_file_w_val;
    assign s_add_o  = s_file_w_add;
    assign s_we_o   = s_file_we;
    
    genvar i;
    generate
        /* Automatic Correction Module*/
        for (i = 0; i<2 ; i++ ) begin : acm_replicator
            assign s_clk_prw[i]     = s_clk_i[i];
            assign s_resetn_prw[i]  = s_resetn_i[i];
            
            //repair request - correctable errors, which cannot be forwarded   
            assign s_rs1_repreq[i]  = (s_r_p1_val_i[0] != s_r_p1_val_i[1]);  
            assign s_rs2_repreq[i]  = ((s_r_p2_val_i[0] != s_r_p2_val_i[1]) || s_mhrdctrl0_i[i][5]);

            //repair request is valid, if no write to the faulty register is ongoing
            assign s_rs1_repair[i]  = (s_r_p1_add_i[i] != 5'b0) && (s_rs1_repreq[i] & (~s_file_we[i] | (s_file_w_add[i] != s_r_p1_add_i[i])));
            assign s_rs2_repair[i]  = (s_r_p2_add_i[i] != 5'b0) && (s_rs2_repreq[i] & (~s_file_we[i] | (s_file_w_add[i] != s_r_p2_add_i[i])));

            //ecc settings
            assign s_ecc_enabled[i] = (s_mhrdctrl0_i[i][5:4] != 2'b00);
            //selects address - rs1 has priority
            assign s_repair_add[i]  = (s_rs1_repair[i]) ? s_r_p1_add_i[i] : s_r_p2_add_i[i];
            //selects value and checksum for the correction
            assign s_repair_val[i]  = (s_rs1_repair[i]) ? s_r_p1_val_i[i] : s_r_p2_val_i[i];
            //save repair flag
            assign s_repair[i]      = (s_rs1_repair[i] | s_rs2_repair[i]) && s_ecc_enabled[i];

            assign s_acm_we[i]      = (s_racm_fsm[i] != ACM_IDLE) | s_repair[i];

            always_comb begin : acm_ff_update
                s_wacm_fsm[i] = ACM_IDLE;
                s_wacm_add[i] = s_racm_add[i];
                s_wacm_val[i] = s_racm_val[i]; 
                if((s_racm_fsm[i] == ACM_CORRECT) && s_mawb_we[i] && (s_mawb_add_i[i] != s_racm_add[i]))begin
                    //delay repair by one clock cycle, if WB stage performs write
                    s_wacm_fsm[i]  = ACM_CORRECT;                   
                end else if((s_racm_fsm[i] == ACM_CHECK) && !(s_mawb_we[i] && (s_mawb_add_i[i] == s_racm_add[i])) && s_acm_repair[i])begin
                    //progress to correction phase
                    s_wacm_fsm[i]  = ACM_CORRECT;
                    s_wacm_val[i]  = s_acm_dec[i];
                end else if(s_repair[i]) begin
                    //new correction request
                    s_wacm_fsm[i]  = ACM_CHECK;
                    s_wacm_add[i]  = s_repair_add[i];
                    s_wacm_val[i]  = s_repair_val[i];           
                end
            end
        end

        for (i = 0; i<2 ;i++ ) begin : acm_double
            //analyze saved data
            secded_encode m_acm_encode    (.s_data_i(s_racm_val[i]),.s_checksum_o(s_acm_achecksum[i]));
            secded_analyze m_acm_analyze  (.s_syndrome_i(s_acm_syndrome[i]),.s_error_o(s_acm_error[i]),.s_ce_o(s_acm_ce[i]));
            secded_decode m_acm_decode    (.s_data_i(s_racm_val[i]),.s_syndrome_i(s_acm_syndrome[i]),.s_data_o(s_acm_dec[i]));
            assign s_acm_syndrome[i]    = s_acm_achecksum[i] ^ s_rp_checksum[i];
            assign s_acm_chs_eq[i]      = (s_rp_checksum[0] == s_rp_checksum[1]);
            assign s_corr[i]            = !((s_acm_error[0] & !s_acm_ce[0]) || (s_acm_error[1] & !s_acm_ce[1])) && (s_acm_dec[0] == s_acm_dec[1]);

            //if replicas of repair-request registers have discrepancies, invalidate the request
            assign s_acm_val_neq[i] = (s_racm_val[0] != s_racm_val[1]);
            assign s_acm_neq[i]     = (s_racm_add[0] != s_racm_add[1]) || (s_racm_fsm[0] != s_racm_fsm[1]);

            //determine correctability
            assign s_acm_repair[i] = s_corr[0] && s_corr[1] && (s_acm_val_neq[i] || !s_acm_chs_eq[i]);

            //write request by ACM
            assign s_fix_ce[i]     = (s_racm_fsm[i] == ACM_CORRECT) & ~s_acm_neq[i] & ~s_acm_val_neq[i];
            //write enable signal for the register file
            assign s_file_we[i]    = s_write[i] || s_fix_ce[i]; 
            //value to be written to the register file
            assign s_file_w_val[i] = s_write[i] ? s_w_data[i] : s_racm_val[i]; 
            //address for the write port of the register file
            assign s_file_w_add[i] = s_write[i] ? s_w_address[i] : s_racm_add[i]; 

            //generate checksum to be saved alongside the data
            secded_encode m_w1_encode (.s_data_i(s_file_w_val[i]), .s_checksum_o(s_w_checksum[i])); 
        end

        for (i =0 ; i<3 ;i++ ) begin : wb_triple
            //write enable from WB stage
            assign s_mawb_we[i] = s_mawb_ictrl_i[i][ICTRL_REG_DEST];     
        end
    endgenerate

    tmr_comb #(.W(1),.OUT_REPS(2)) m_tmr_write (.s_d_i(s_mawb_we),.s_d_o(s_write));
    tmr_comb #(.W(5),.OUT_REPS(2)) m_tmr_address (.s_d_i(s_mawb_add_i),.s_d_o(s_w_address));
    tmr_comb #(.W(32),.OUT_REPS(2)) m_tmr_data (.s_d_i(s_mawb_val_i),.s_d_o(s_w_data));

    assign s_rp_checksum[0] = s_rf0_checksum[0];
    assign s_rp_checksum[1] = s_rf1_checksum[0];

    assign s_rf0_we = s_file_we[0] && s_ecc_enabled[0];
    assign s_rf1_we = s_file_we[1] && s_ecc_enabled[1];

    seu_ff_file #(.LABEL("RFACM0"),.W(7),.N(32),.RP(1)) m_rf0_acm 
    (
        .s_c_i(s_clk_i[0]),
        .s_we_i(s_rf0_we),
        .s_wa_i(s_file_w_add[0]),
        .s_d_i(s_w_checksum[0]),
        .s_ra_i({s_racm_add[0]}),
        .s_q_o(s_rf0_checksum)
    );

    seu_ff_file #(.LABEL("RFACM1"),.W(7),.N(32),.RP(1)) m_rf1_acm 
    (
        .s_c_i(s_clk_i[1]),
        .s_we_i(s_rf1_we),
        .s_wa_i(s_file_w_add[1]),
        .s_d_i(s_w_checksum[1]),
        .s_ra_i({s_racm_add[1]}),
        .s_q_o(s_rf1_checksum)
    );

endmodule

