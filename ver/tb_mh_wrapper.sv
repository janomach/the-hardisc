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

`include "../rtl/settings.sv"
import p_hardisc::*;

`timescale 1ps/1ps

module tb_mh_wrapper();

localparam MEM_SIZE = 32'h100000;
localparam MEM_MSB  = $clog2(MEM_SIZE) - 32'h1;

logic[31:0] s_i_hrdata[1], s_i_haddr[1], s_i_hwdata[1];
logic s_i_hwrite[1], s_i_hmastlock[1],s_i_hready[1],s_i_hresp[1];
logic[1:0] s_i_htrans[1];
logic[2:0] s_i_hsize[1],s_i_hburst[1];
logic[3:0] s_i_hprot[1];

logic[31:0] s_d_hrdata[1], s_d_haddr[1], s_d_hwdata[1];
logic s_d_hwrite[1], s_d_hmastlock[1],s_d_hready[1],s_d_hresp[1];
logic[1:0] s_d_htrans[1];
logic[2:0] s_d_hsize[1],s_d_hburst[1];
logic[3:0] s_d_hprot[1];

logic[31:0] s_sbase[2], s_smask[2], s_shrdata[2];
logic s_shready[2], s_shresp[2], s_shsel[2];

logic s_end, s_hrdmax_rst;
logic s_int_meip, s_int_mtip;
logic[31:0] r_timeout;

logic s_halt;

string binfile;
int fd,i;
bit [7:0] r8;
bit [31:0] value, addr, r_boot_add, r_clk_time;

logic r_ver_clk, r_ver_rstn, r_err_clk;
`ifdef PROTECTED
logic s_clk[3], s_resetn[3];
`else
logic s_clk[1], s_resetn[1];
`endif

initial begin
    r_boot_add  = 32'h0;
    r_timeout   = 32'd150000;
    r_clk_time  = 32'd1000;
    r_ver_clk   = 1'b1;
    r_err_clk   = 1'b1;
    r_ver_rstn  = 1'b0;
    addr        = 32'b0;
    if ($value$plusargs ("BOOTADD=%h", r_boot_add))
        $display ("Boot address: 0x%h", r_boot_add);
    if ($value$plusargs ("CLKPERIOD=%d", r_clk_time))
        $display ("Clock period: 0x%h", r_clk_time);
    if ($value$plusargs ("BIN=%s", binfile))
        $display ("Binary file:%s", binfile);
    if ($value$plusargs ("TIMEOUT=%d", r_timeout))
        $display ("Timeout: %d", r_timeout);
    fd = $fopen(binfile,"rb");

    if(fd) begin
        $display ("Reading binary file");
        while ($fread(r8,fd)) begin
            value = m_memory.ahb_dmem.r_memory[addr[31:2]] | (r8<<(addr[1:0]*8));
            m_memory.ahb_dmem.r_memory[addr[31:2]] = value;
            addr = addr + 1;
       end
       $display ("End address: %h",addr);
       $fclose(fd);
    end else begin
        $display ("Cannot open binary file");
    end

    r_clk_time = r_clk_time / 2;
    #(r_clk_time * 20);  
    r_ver_rstn  = 1'b1;
    #(r_clk_time * 2 * r_timeout);

    $display ("Timeout!");
    $finish;
end

always #(r_clk_time) r_ver_clk = ~r_ver_clk;
always #(r_clk_time + {1'b0,r_clk_time[31:1]}) r_err_clk = ~r_err_clk;

`ifdef PROTECTED
logic s_upset_clk[3], s_upset_resetn[3];
see_insert #(.W(1),.N(3),.LABEL("CLK"),.MPROB(100)) see_clk(.s_clk_i(r_ver_clk),.s_upset_o(s_upset_clk));
see_insert #(.W(1),.N(3),.LABEL("RSTN"),.MPROB(100)) see_rst(.s_clk_i(r_ver_clk),.s_upset_o(s_upset_resetn));

genvar s;
generate
    for(s=0;s<3;s++)begin
        assign s_clk[s]     = ~r_ver_rstn ? r_ver_clk : (~s_upset_clk[s] | r_ver_clk) ? r_ver_clk : r_err_clk;
        assign s_resetn[s]  = ~r_ver_rstn ? 1'b0 : (r_ver_rstn ^ s_upset_resetn[s]);
    end
endgenerate
`else
assign s_clk[0] = r_ver_clk;
assign s_resetn[0] = r_ver_rstn;
`endif

// WB PC extraction
logic[31:0] s_wb_pc, r_last_rp;

assign s_wb_pc = ((|dut.s_mawb_ictrl[0][3:0])) ? r_last_rp : 32'd0;
always_ff @(posedge r_ver_clk) r_last_rp <= dut.s_rst_point[0];
/////////////////////

//GET INSTRUCTION OUT OF MEMORY
logic[31:0] s_wb_instr, s_mem_pc;

always_comb begin : wb_instr_find
    s_mem_pc[31:MEM_MSB-1] = 0;
    s_mem_pc[MEM_MSB-2:0]  = s_wb_pc[MEM_MSB:2];
    if(~s_wb_pc[0])begin
        if(s_wb_pc[1])begin
            s_wb_instr[15:0] = m_memory.ahb_dmem.r_memory[s_mem_pc][31:16];
        end else begin
            s_wb_instr[15:0] = m_memory.ahb_dmem.r_memory[s_mem_pc][15:0];
        end
        if(s_wb_pc[1] & ~dut.s_mawb_ictrl[0][ICTRL_RVC])begin
            s_wb_instr[31:16] = m_memory.ahb_dmem.r_memory[s_mem_pc + 1][15:0];
        end else begin
            s_wb_instr[31:16] = (s_wb_pc[1] | dut.s_mawb_ictrl[0][ICTRL_RVC]) ? 16'b0 : m_memory.ahb_dmem.r_memory[s_mem_pc][31:16]; 
        end
    end else begin
        s_wb_instr = 32'b0;
    end
end
///////////////////////////////////

tracer m_tracer(
    .s_clk_i(r_ver_clk),
    .s_resetn_i(r_ver_rstn),
    .s_wb_pc_i(s_wb_pc),
    .s_wb_instr_i(s_wb_instr),
    .s_wb_rd_i(dut.s_mawb_rd[0]),
    .s_wb_val_i(dut.s_mawb_val[0]),
    .s_dec_instr_i(dut.m_pipe_2_id.s_aligner_instr[0]),
    .s_dut_mcycle_i(dut.m_pipe_5_ma.m_csru.s_mcycle[0]),
    .s_dut_minstret_i(dut.m_pipe_5_ma.m_csru.s_minstret[0]),
    .s_dut_fe0_add_i(dut.m_pipe_1_fe.s_rfe0_add[0]),
    .s_dut_fe0_utd_i(dut.m_pipe_1_fe.s_rfe0_utd[0]),
    .s_dut_fe1_add_i(dut.m_pipe_1_fe.s_rfe1_add[0]),
    .s_dut_fe1_utd_i(dut.m_pipe_1_fe.s_rfe1_utd[0]),
    .s_dut_id_ictrl_i(dut.m_pipe_2_id.s_instr_ctrl[0]),
    .s_dut_aligner_nop_i(dut.m_pipe_2_id.s_aligner_nop[0]),
    .s_dut_op_ictrl_i(dut.m_pipe_3_op.s_idop_ictrl_i[0]),
    .s_dut_ex_ictrl_i(dut.m_pipe_4_ex.s_opex_ictrl_i[0]),
    .s_dut_ma_ictrl_i(dut.m_pipe_5_ma.s_exma_ictrl_i[0]),
    .s_dut_wb_ictrl_i(dut.s_mawb_ictrl[0]),
    .s_dut_rfc_we_i(dut.m_rfc.s_rf_we),
    .s_dut_rfc_wval_i(dut.m_rfc.s_rf_w_val),
    .s_dut_rfc_wadd_i(dut.m_rfc.s_rf_w_add)
);

hardisc dut
(
    .s_clk_i(s_clk),
    .s_resetn_i(s_resetn),
    .s_int_meip_i(s_int_meip),
    .s_int_mtip_i(s_int_mtip),
    .s_boot_add_i(r_boot_add),
    
    .s_i_hrdata_i(s_i_hrdata[0]),
    .s_i_hready_i(s_i_hready[0]),
    .s_i_hresp_i(s_i_hresp[0]),
    .s_i_haddr_o(s_i_haddr[0]),
    .s_i_hwdata_o(s_i_hwdata[0]),
    .s_i_hburst_o(s_i_hburst[0]),
    .s_i_hmastlock_o(s_i_hmastlock[0]),
    .s_i_hprot_o(s_i_hprot[0]),
    .s_i_hsize_o(s_i_hsize[0]),
    .s_i_htrans_o(s_i_htrans[0]),
    .s_i_hwrite_o(s_i_hwrite[0]),

    .s_hrdmax_rst_o(s_hrdmax_rst),

    .s_d_hrdata_i(s_d_hrdata[0]),
    .s_d_hready_i(s_d_hready[0]),
    .s_d_hresp_i(s_d_hresp[0]),
    .s_d_haddr_o(s_d_haddr[0]),
    .s_d_hwdata_o(s_d_hwdata[0]),
    .s_d_hburst_o(s_d_hburst[0]),
    .s_d_hmastlock_o(s_d_hmastlock[0]),
    .s_d_hprot_o(s_d_hprot[0]),
    .s_d_hsize_o(s_d_hsize[0]),
    .s_d_htrans_o(s_d_htrans[0]),
    .s_d_hwrite_o(s_d_hwrite[0])
);

assign s_sbase  = {32'h80000000, r_boot_add};
assign s_smask  = {32'hFFFFFFF8, 32'hFFF00000};

ahb_interconnect #(.SLAVES(32'h2)) data_interconnect
(
    .s_clk_i(r_ver_clk),
    .s_resetn_i(r_ver_rstn),

    .s_mhaddr_i(s_d_haddr[0]),
    .s_mhtrans_i(s_d_htrans[0]),

    .s_sbase_i(s_sbase),
    .s_smask_i(s_smask),

    .s_shrdata_i(s_shrdata),
    .s_shready_i(s_shready),
    .s_shresp_i(s_shresp),
    .s_hsel_o(s_shsel),
    
    .s_shrdata_o(s_d_hrdata[0]),
    .s_shready_o(s_d_hready[0]),
    .s_shresp_o(s_d_hresp[0])
);

assign s_halt = r_ver_rstn & m_control.s_we & (m_control.r_address[2:0] == 3'd4);
always_ff @( posedge s_halt ) begin : halt_execution
    $finish;
end

ahb_ram #(.MEM_SIZE(32'h8),.SIMULATION(1),.LABEL("CONTROL")) m_control
(
    .s_clk_i(r_ver_clk),
    .s_resetn_i(r_ver_rstn),
    
    //AHB3-Lite
    .s_haddr_i(s_d_haddr[0][2:0]),
    .s_hwdata_i(s_d_hwdata[0]),
    .s_hburst_i(s_d_hburst[0]),
    .s_hmastlock_i(s_d_hmastlock[0]),
    .s_hprot_i(s_d_hprot[0]),
    .s_hsize_i(s_d_hsize[0]),
    .s_htrans_i(s_d_htrans[0]),
    .s_hwrite_i(s_d_hwrite[0]),
    .s_hsel_i(s_shsel[0]),
    
    .s_hrdata_o(s_shrdata[0]),
    .s_hready_o(s_shready[0]),
    .s_hresp_o(s_shresp[0])
);

logic s_i_dhmastlock[2], s_i_dhwrite[2], s_i_dhsel[2], s_i_dshready[2], s_i_dhresp[2];
logic[1:0] s_i_dhtrans[2];
logic[2:0] s_i_dhburst[2],s_i_dhsize[2];
logic[3:0] s_i_dhprot[2];
logic[MEM_MSB:0] s_i_dhaddr[2];
logic[31:0] s_i_dhwdata[2], s_i_dhrdata[2];

assign s_i_dhmastlock   = {s_d_hmastlock[0], s_i_hmastlock[0]};
assign s_i_dhwrite      = {s_d_hwrite[0], s_i_hwrite[0]};
assign s_i_dhsel        = {s_shsel[1], 1'b1};
assign s_i_dhtrans      = {s_d_htrans[0], s_i_htrans[0]};
assign s_i_dhburst      = {s_d_hburst[0], s_i_hburst[0]};
assign s_i_dhsize       = {s_d_hsize[0], s_i_hsize[0]};
assign s_i_dhprot       = {s_d_hprot[0], s_i_hprot[0]};
assign s_i_dhaddr       = {s_d_haddr[0][MEM_MSB:0], s_i_haddr[0][MEM_MSB:0]};
assign s_i_dhwdata      = {s_d_hwdata[0], s_i_hwdata[0]};

assign s_i_hready[0]    = s_i_dshready[1];
assign s_i_hresp[0]     = s_i_dhresp[1];
assign s_i_hrdata[0]    = s_i_dhrdata[1];

assign s_shready[1]     = s_i_dshready[0];
assign s_shresp[1]      = s_i_dhresp[0];
assign s_shrdata[1]     = s_i_dhrdata[0];

dahb_ram #(.MEM_SIZE(MEM_SIZE),.SIMULATION(1),.ENABLE_LOG(0),.LABEL("MEMORY")) m_memory
(
    .s_clk_i(r_ver_clk),
    .s_resetn_i(r_ver_rstn),
    
    //AHB3-Lite
    .s_haddr_i(s_i_dhaddr),
    .s_hwdata_i(s_i_dhwdata),
    .s_hburst_i(s_i_dhburst),
    .s_hmastlock_i(s_i_dhmastlock),
    .s_hprot_i(s_i_dhprot),
    .s_hsize_i(s_i_dhsize),
    .s_htrans_i(s_i_dhtrans),
    .s_hwrite_i(s_i_dhwrite),
    .s_hsel_i(s_i_dhsel),
    
    .s_hrdata_o(s_i_dhrdata),
    .s_hready_o(s_i_dshready),
    .s_hresp_o(s_i_dhresp)
);

endmodule
