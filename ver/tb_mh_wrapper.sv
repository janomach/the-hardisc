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
import edac::*;

`ifdef PROT_INTF
    `define MEMORY_IFP 1
    `define INTF_REPS  3 
    `define SYSTEM system_hardisc //available systems: system_hardisc, system_dcls
`else
    `define MEMORY_IFP 0
    `define INTF_REPS  1
    `define SYSTEM system_core 
`endif

`timescale 1ns/1ns

module tb_mh_wrapper();

localparam SUBORDINATES = 3;
localparam MEM_SIZE = 32'h100000;
localparam MEM_MSB  = $clog2(MEM_SIZE) - 32'h1;
localparam BOOTADD  = 32'h10000000;
localparam pma_cfg_t PMA_CONFIG[SUBORDINATES] = '{
    '{base  : BOOTADD,      mask  : 32'hFFF00000, read_only  : 1'b0, executable: 1'b1, idempotent : 1'b1},
    '{base  : 32'h80000000, mask  : 32'hFFFFF400, read_only  : 1'b0, executable: 1'b1, idempotent : 1'b1},
    '{base  : 32'h80001000, mask  : 32'hFFFFF400, read_only  : 1'b0, executable: 1'b1, idempotent : 1'b1}
};

logic[5:0] s_i_hparity[1], s_i_hparity_see[1];
logic[6:0] s_i_hrchecksum[1], s_i_hwchecksum[1], s_i_hrchecksum_see[1], s_i_hwchecksum_see[1];
logic[31:0] s_i_hrdata[1], s_i_haddr[1], s_i_hwdata[1], s_i_hrdata_see[1], s_i_haddr_see[1], s_i_hwdata_see[1];
logic s_i_hwrite[1], s_i_hmastlock[1],s_i_hready[`INTF_REPS],s_i_hresp[`INTF_REPS], 
        s_i_hwrite_see[1], s_i_hmastlock_see[1],s_i_hready_see[`INTF_REPS],s_i_hresp_see[`INTF_REPS];
logic[1:0] s_i_htrans[1], s_i_htrans_see[1];
logic[2:0] s_i_hsize[1],s_i_hburst[1], s_i_hsize_see[1],s_i_hburst_see[1];
logic[3:0] s_i_hprot[1], s_i_hprot_see[1];

logic[5:0] s_d_hparity[1], s_d_hparity_see[1];
logic[6:0] s_d_hrchecksum[1], s_d_hwchecksum[1], s_d_hrchecksum_see[1], s_d_hwchecksum_see[1];
logic[31:0] s_d_hrdata[1], s_d_haddr[1], s_d_hwdata[1], s_d_hrdata_see[1], s_d_haddr_see[1], s_d_hwdata_see[1];
logic s_d_hwrite[1], s_d_hmastlock[1],s_d_hready[`INTF_REPS],s_d_hresp[`INTF_REPS], 
        s_d_hwrite_see[1], s_d_hmastlock_see[1],s_d_hready_see[`INTF_REPS],s_d_hresp_see[`INTF_REPS];
logic[1:0] s_d_htrans[1], s_d_htrans_see[1];
logic[2:0] s_d_hsize[1],s_d_hburst[1],s_d_hsize_see[1],s_d_hburst_see[1];
logic[3:0] s_d_hprot[1],s_d_hprot_see[1];

logic[6:0] s_shrchecksum[SUBORDINATES];
logic[31:0] s_ahb_sbase[SUBORDINATES], s_ahb_smask[SUBORDINATES], s_shrdata[SUBORDINATES];
logic s_shready[SUBORDINATES], s_shresp[SUBORDINATES], s_shsel[SUBORDINATES];

logic s_int_meip, s_int_mtip, s_unrec_err[2];
logic[31:0] r_timeout;

logic s_halt, s_sim_timeout;

string binfile;
int fd,i;
bit [7:0] r8;
bit [31:0] value, addr, r_clk_time;

logic r_ver_clk, r_ver_rstn, r_err_clk, s_clk_see[3], s_resetn_see[3], 
      s_clk_dut[3], s_resetn_dut[3], s_upset_clk[3], s_upset_resetn[3];

initial begin
    r_timeout   = 32'd150000;
    r_clk_time  = 32'd10;
    r_ver_clk   = 1'b1;
    r_err_clk   = 1'b1;
    r_ver_rstn  = 1'b0;
    addr        = 32'b0;
    s_sim_timeout = 1'b0;
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
`ifdef PROT_INTF
            m_memory.ahb_dmem.r_cmemory[addr[31:2]] = edac_checksum(value);
`endif
            addr = addr + 1;
       end
       $display ("End address: %h",addr);
       $fclose(fd);
    end else begin
        $display ("Cannot open binary file");
    end

    r_clk_time = r_clk_time / 2;
    #((r_clk_time * 20) + 1);  
    r_ver_rstn  = 1'b1;
    #(r_clk_time * 2 * r_timeout);
    s_sim_timeout = 1'b1;
    $display ("Timeout!");
end

always #(r_clk_time) r_ver_clk = ~r_ver_clk;

// WB PC extraction
logic[31:0] s_wb_pc, r_last_rp;
ictrl s_mawb_ctrl[1];
`ifdef PROT_PIPE
tmr_comb #(.W($size(ictrl)),.OUT_REPS(1)) m_tmr_ictrl (.s_d_i(dut.rep[0].core.s_mawb_ictrl),.s_d_o(s_mawb_ctrl));
`else
assign s_mawb_ctrl[0] = dut.rep[0].core.s_mawb_ictrl[0];
`endif

assign s_wb_pc = ((|s_mawb_ctrl[0][4:0])) ? r_last_rp : 32'd0;
always_ff @(posedge r_ver_clk) r_last_rp <= dut.rep[0].core.m_pipe_5_ma.s_pc[0];
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
        if(s_wb_pc[1] & ~s_mawb_ctrl[0][ICTRL_RVC])begin
            s_wb_instr[31:16] = m_memory.ahb_dmem.r_memory[s_mem_pc + 1][15:0];
        end else begin
            s_wb_instr[31:16] = (s_wb_pc[1] | s_mawb_ctrl[0][ICTRL_RVC]) ? 16'b0 : m_memory.ahb_dmem.r_memory[s_mem_pc][31:16]; 
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
    .s_wb_rd_i(dut.rep[0].core.s_mawb_rd[0]),
    .s_wb_val_i(dut.rep[0].core.s_mawb_val[0]),
    .s_dec_instr_i(dut.rep[0].core.m_pipe_2_id.s_aligner_instr[0]),
    .s_dut_mcycle_i(dut.rep[0].core.m_pipe_5_ma.m_csru.s_mcycle[0]),
    .s_dut_minstret_i(dut.rep[0].core.m_pipe_5_ma.m_csru.s_minstret[0]),
    .s_dut_fe0_add_i(dut.rep[0].core.m_pipe_1_fe.s_rfe0_add[0]),
    .s_dut_fe0_utd_i(dut.rep[0].core.m_pipe_1_fe.s_rfe0_utd[0]),
    .s_dut_fe1_add_i(dut.rep[0].core.m_pipe_1_fe.s_rfe1_add[0]),
    .s_dut_fe1_utd_i(dut.rep[0].core.m_pipe_1_fe.s_rfe1_utd[0]),
    .s_dut_id_ictrl_i(dut.rep[0].core.m_pipe_2_id.s_instr_ctrl[0]),
    .s_dut_aligner_nop_i(dut.rep[0].core.m_pipe_2_id.s_aligner_nop[0]),
    .s_dut_op_ictrl_i(dut.rep[0].core.m_pipe_3_op.s_idop_ictrl_i[0]),
    .s_dut_ex_ictrl_i(dut.rep[0].core.m_pipe_4_ex.s_opex_ictrl_i[0]),
    .s_dut_ma_ictrl_i(dut.rep[0].core.m_pipe_5_ma.s_exma_ictrl_i[0]),
    .s_dut_wb_ictrl_i(s_mawb_ctrl[0]),
    .s_dut_rfc_we_i(dut.rep[0].core.m_rfc.s_rf_we[0]),
    .s_dut_rfc_wval_i(dut.rep[0].core.m_rfc.s_rf_w_val[0]),
    .s_dut_rfc_wadd_i(dut.rep[0].core.m_rfc.s_rf_w_add[0])
);

assign s_int_meip = 1'b0;

`SYSTEM #(.PMA_REGIONS(SUBORDINATES),.PMA_CFG(PMA_CONFIG)) dut
(
    .s_clk_i(s_clk_dut),
    .s_resetn_i(s_resetn_dut),
    .s_int_meip_i(s_int_meip),
    .s_int_mtip_i(s_int_mtip),
    .s_boot_add_i(BOOTADD),
    
    .s_i_hrdata_i(s_i_hrdata_see[0]),
    .s_i_hready_i(s_i_hready_see),
    .s_i_hresp_i(s_i_hresp_see),
    .s_i_haddr_o(s_i_haddr[0]),
    .s_i_hwdata_o(s_i_hwdata[0]),
    .s_i_hburst_o(s_i_hburst[0]),
    .s_i_hmastlock_o(s_i_hmastlock[0]),
    .s_i_hprot_o(s_i_hprot[0]),
    .s_i_hsize_o(s_i_hsize[0]),
    .s_i_htrans_o(s_i_htrans[0]),
    .s_i_hwrite_o(s_i_hwrite[0]),

    .s_i_hrchecksum_i(s_i_hrchecksum_see[0]),
    .s_i_hwchecksum_o(s_i_hwchecksum[0]),
    .s_i_hparity_o(s_i_hparity[0]),

    .s_d_hrdata_i(s_d_hrdata_see[0]),
    .s_d_hready_i(s_d_hready_see),
    .s_d_hresp_i(s_d_hresp_see),
    .s_d_haddr_o(s_d_haddr[0]),
    .s_d_hwdata_o(s_d_hwdata[0]),
    .s_d_hburst_o(s_d_hburst[0]),
    .s_d_hmastlock_o(s_d_hmastlock[0]),
    .s_d_hprot_o(s_d_hprot[0]),
    .s_d_hsize_o(s_d_hsize[0]),
    .s_d_htrans_o(s_d_htrans[0]),
    .s_d_hwrite_o(s_d_hwrite[0]),

    .s_d_hrchecksum_i(s_d_hrchecksum_see[0]),
    .s_d_hwchecksum_o(s_d_hwchecksum[0]),
    .s_d_hparity_o(s_d_hparity[0]),

    .s_unrec_err_o(s_unrec_err)
);

ahb_interconnect #(.SLAVES(SUBORDINATES)) data_interconnect
(
    .s_clk_i(r_ver_clk),
    .s_resetn_i(r_ver_rstn),

    .s_mhaddr_i(s_d_haddr[0]),
    .s_mhtrans_i(s_d_htrans[0]),

    .s_sbase_i(s_ahb_sbase),
    .s_smask_i(s_ahb_smask),

    .s_shrdata_i(s_shrdata),
    .s_shready_i(s_shready),
    .s_shresp_i(s_shresp),
    .s_hsel_o(s_shsel),

    .s_shrchecksum_i(s_shrchecksum),
    .s_shrchecksum_o(s_d_hrchecksum[0]),
    
    .s_shrdata_o(s_d_hrdata[0]),
    .s_shready_o(s_d_hready[0]),
    .s_shresp_o(s_d_hresp[0])
);

assign s_halt = r_ver_rstn & ((m_control.s_we & (m_control.r_address[2:0] == 3'd4)) | s_unrec_err[0] | s_unrec_err[1] | s_sim_timeout/*| dut.rep[0].core.m_pipe_5_ma.m_csru.s_rmcause[0] == EXC_ECALL_M_VAL*/);
always_ff @( posedge s_halt ) begin : halt_execution
    $finish;
end

ahb_ram #(.MEM_SIZE(32'h8),.SIMULATION(1),.LABEL("CONTROL"),.IFP(`MEMORY_IFP),.GROUP(SEEGR_MEMORY),.MPROB(0)) m_control
(
    .s_clk_i(r_ver_clk),
    .s_resetn_i(r_ver_rstn),
    
    //AHB3-Lite
    .s_haddr_i(s_d_haddr[0]),
    .s_hwdata_i(s_d_hwdata[0]),
    .s_hburst_i(s_d_hburst[0]),
    .s_hmastlock_i(s_d_hmastlock[0]),
    .s_hprot_i(s_d_hprot[0]),
    .s_hsize_i(s_d_hsize[0]),
    .s_htrans_i(s_d_htrans[0]),
    .s_hwrite_i(s_d_hwrite[0]),
    .s_hsel_i(s_shsel[1]),

    .s_hparity_i(s_d_hparity[0]),
    .s_hwchecksum_i(s_d_hwchecksum[0]),
    .s_hrchecksum_o(s_shrchecksum[1]),
    
    .s_hrdata_o(s_shrdata[1]),
    .s_hready_o(s_shready[1]),
    .s_hresp_o(s_shresp[1])
);

ahb_timer #(.IFP(`MEMORY_IFP)) m_mtimer
(
    .s_clk_i(r_ver_clk),
    .s_resetn_i(r_ver_rstn),
    
    //AHB3-Lite
    .s_haddr_i(s_d_haddr[0]),
    .s_hwdata_i(s_d_hwdata[0]),
    .s_hburst_i(s_d_hburst[0]),
    .s_hmastlock_i(s_d_hmastlock[0]),
    .s_hprot_i(s_d_hprot[0]),
    .s_hsize_i(s_d_hsize[0]),
    .s_htrans_i(s_d_htrans[0]),
    .s_hwrite_i(s_d_hwrite[0]),
    .s_hsel_i(s_shsel[2]),

    .s_hparity_i(s_d_hparity[0]),
    .s_hwchecksum_i(s_d_hwchecksum[0]),
    .s_hrchecksum_o(s_shrchecksum[2]),
    
    .s_hrdata_o(s_shrdata[2]),
    .s_hready_o(s_shready[2]),
    .s_hresp_o(s_shresp[2]),

    .s_timeout_o(s_int_mtip)
);

logic s_m_hmastlock[2], s_m_hwrite[2], s_m_hsel[2], s_m_shready[2], s_m_hresp[2];
logic[1:0] s_m_htrans[2];
logic[2:0] s_m_hburst[2],s_m_hsize[2];
logic[3:0] s_m_hprot[2];
logic[31:0] s_m_haddr[2];
logic[31:0] s_m_hwdata[2], s_m_hrdata[2];
logic[6:0] s_m_hwchecksum[2], s_m_hrchecksum[2];
logic[5:0] s_m_hparity[2];

assign s_m_hmastlock   = {s_d_hmastlock[0], s_i_hmastlock[0]};
assign s_m_hwrite      = {s_d_hwrite_see[0], s_i_hwrite_see[0]};
assign s_m_hsel        = {s_shsel[0], 1'b1};
assign s_m_htrans      = {s_d_htrans_see[0], s_i_htrans_see[0]};
assign s_m_hburst      = {s_d_hburst[0], s_i_hburst[0]};
assign s_m_hsize       = {s_d_hsize_see[0], s_i_hsize_see[0]};
assign s_m_hprot       = {s_d_hprot[0], s_i_hprot[0]};
assign s_m_haddr       = {s_d_haddr_see[0], s_i_haddr_see[0]};
assign s_m_hwdata      = {s_d_hwdata_see[0], s_i_hwdata[0]};
assign s_m_hwchecksum  = {s_d_hwchecksum_see[0], s_i_hwchecksum[0]};
assign s_m_hparity     = {s_d_hparity_see[0], s_i_hparity_see[0]};

assign s_i_hready[0]    = s_m_shready[1];
assign s_i_hresp[0]     = s_m_hresp[1];
assign s_i_hrdata[0]    = s_m_hrdata[1];
assign s_i_hrchecksum[0]= s_m_hrchecksum[1];

assign s_shready[0]     = s_m_shready[0];
assign s_shresp[0]      = s_m_hresp[0];
assign s_shrdata[0]     = s_m_hrdata[0];
assign s_shrchecksum[0] = s_m_hrchecksum[0];

dahb_ram #(.MEM_SIZE(MEM_SIZE),.SIMULATION(0),.ENABLE_LOG(0),.LABEL("MEMORY"),.IFP(`MEMORY_IFP),.GROUP(SEEGR_MEMORY)) m_memory
(
    .s_clk_i(r_ver_clk),
    .s_resetn_i(r_ver_rstn),
    
    //AHB3-Lite
    .s_haddr_i(s_m_haddr),
    .s_hwdata_i(s_m_hwdata),
    .s_hburst_i(s_m_hburst),
    .s_hmastlock_i(s_m_hmastlock),
    .s_hprot_i(s_m_hprot),
    .s_hsize_i(s_m_hsize),
    .s_htrans_i(s_m_htrans),
    .s_hwrite_i(s_m_hwrite),
    .s_hsel_i(s_m_hsel),

    .s_hparity_i(s_m_hparity),
    .s_hwchecksum_i(s_m_hwchecksum),
    .s_hrchecksum_o(s_m_hrchecksum),
    
    .s_hrdata_o(s_m_hrdata),
    .s_hready_o(s_m_shready),
    .s_hresp_o(s_m_hresp)
);

/* Emulation of Single Event Transient faults at bus signals 
   - faults are emulated at the inputs of the memory and the hardisc core
   - protection of bus interconnect is yet to integrate
   - some signal bundles are not leveraged by the core, so the emulation of faults is omitted for them
*/
// Instruction bus signals
see_wires #(.LABEL("IHADDR"),.GROUP(SEEGR_BUS_WIRE),.W(32))     see_ihaddr(.s_c_i(r_ver_clk),.s_d_i(s_i_haddr),.s_d_o(s_i_haddr_see));
see_wires #(.LABEL("IHSIZE"),.GROUP(SEEGR_BUS_WIRE),.W(3))      see_ihsize(.s_c_i(r_ver_clk),.s_d_i(s_i_hsize),.s_d_o(s_i_hsize_see));
see_wires #(.LABEL("IHTRANS"),.GROUP(SEEGR_BUS_WIRE),.W(2))     see_ihtrans(.s_c_i(r_ver_clk),.s_d_i(s_i_htrans),.s_d_o(s_i_htrans_see));
see_wires #(.LABEL("IHWRITE"),.GROUP(SEEGR_BUS_WIRE),.W(1))     see_ihwrite(.s_c_i(r_ver_clk),.s_d_i(s_i_hwrite),.s_d_o(s_i_hwrite_see));
see_wires #(.LABEL("IHPARITY"),.GROUP(SEEGR_BUS_WIRE),.W(6))    see_ihparity(.s_c_i(r_ver_clk),.s_d_i(s_i_hparity),.s_d_o(s_i_hparity_see));
see_wires #(.LABEL("IHRDATA"),.GROUP(SEEGR_BUS_WIRE),.W(32),.N(1))          see_ihrdata(.s_c_i(r_ver_clk),.s_d_i(s_i_hrdata),.s_d_o(s_i_hrdata_see));
see_wires #(.LABEL("IHRCHECKSUM"),.GROUP(SEEGR_BUS_WIRE),.W(7),.N(1))       see_ihrchecksum(.s_c_i(r_ver_clk),.s_d_i(s_i_hrchecksum),.s_d_o(s_i_hrchecksum_see));
see_wires #(.LABEL("IHREADY"),.GROUP(SEEGR_BUS_WIRE),.W(1),.N(`INTF_REPS))   see_ihready(.s_c_i(r_ver_clk),.s_d_i(s_i_hready),.s_d_o(s_i_hready_see));
see_wires #(.LABEL("IHRESP"),.GROUP(SEEGR_BUS_WIRE),.W(1),.N(`INTF_REPS))    see_ihresp(.s_c_i(r_ver_clk),.s_d_i(s_i_hresp),.s_d_o(s_i_hresp_see));
//see_wires #(.LABEL("IHWDATA"),.GROUP(SEEGR_BUS_WIRE),.W(32))    see_ihwdata(.s_c_i(r_ver_clk),.s_d_i(s_i_hwdata),.s_d_o(s_i_hwdata_see));
//see_wires #(.LABEL("IHWCHECKSUM"),.GROUP(SEEGR_BUS_WIRE),.W(7)) see_ihwchecksum(.s_c_i(r_ver_clk),.s_d_i(s_i_hwchecksum),.s_d_o(s_i_hwchecksum_see));
//see_wires #(.LABEL("IHBURST"),.GROUP(SEEGR_BUS_WIRE),.W(3))     see_ihburst(.s_c_i(r_ver_clk),.s_d_i(s_i_hburst),.s_d_o(s_i_hburst_see));
//see_wires #(.LABEL("IHMASTLOCK"),.GROUP(SEEGR_BUS_WIRE),.W(1))  see_ihmastlock(.s_c_i(r_ver_clk),.s_d_i(s_i_hmastlock),.s_d_o(s_i_hmastlock_see));
//see_wires #(.LABEL("IHPROT"),.GROUP(SEEGR_BUS_WIRE),.W(4))      see_ihprot(.s_c_i(r_ver_clk),.s_d_i(s_i_hprot),.s_d_o(s_i_hprot_see));

// Data bus signals
see_wires #(.LABEL("DHADDR"),.GROUP(SEEGR_BUS_WIRE),.W(32))     see_dhaddr(.s_c_i(r_ver_clk),.s_d_i(s_d_haddr),.s_d_o(s_d_haddr_see));
see_wires #(.LABEL("DHWDATA"),.GROUP(SEEGR_BUS_WIRE),.W(32))    see_dhwdata(.s_c_i(r_ver_clk),.s_d_i(s_d_hwdata),.s_d_o(s_d_hwdata_see));
see_wires #(.LABEL("DHWCHECKSUM"),.GROUP(SEEGR_BUS_WIRE),.W(7)) see_dhwchecksum(.s_c_i(r_ver_clk),.s_d_i(s_d_hwchecksum),.s_d_o(s_d_hwchecksum_see));
see_wires #(.LABEL("DHSIZE"),.GROUP(SEEGR_BUS_WIRE),.W(3))      see_dhsize(.s_c_i(r_ver_clk),.s_d_i(s_d_hsize),.s_d_o(s_d_hsize_see));
see_wires #(.LABEL("DHTRANS"),.GROUP(SEEGR_BUS_WIRE),.W(2))     see_dhtrans(.s_c_i(r_ver_clk),.s_d_i(s_d_htrans),.s_d_o(s_d_htrans_see));
see_wires #(.LABEL("DHWRITE"),.GROUP(SEEGR_BUS_WIRE),.W(1))     see_dhwrite(.s_c_i(r_ver_clk),.s_d_i(s_d_hwrite),.s_d_o(s_d_hwrite_see));
see_wires #(.LABEL("DHPARITY"),.GROUP(SEEGR_BUS_WIRE),.W(6))    see_dhparity(.s_c_i(r_ver_clk),.s_d_i(s_d_hparity),.s_d_o(s_d_hparity_see));
see_wires #(.LABEL("DHRDATA"),.GROUP(SEEGR_BUS_WIRE),.W(32),.N(1))          see_dhrdata(.s_c_i(r_ver_clk),.s_d_i(s_d_hrdata),.s_d_o(s_d_hrdata_see));
see_wires #(.LABEL("DHRCHECKSUM"),.GROUP(SEEGR_BUS_WIRE),.W(7),.N(1))       see_dhrchecksum(.s_c_i(r_ver_clk),.s_d_i(s_d_hrchecksum),.s_d_o(s_d_hrchecksum_see));
see_wires #(.LABEL("DHREADY"),.GROUP(SEEGR_BUS_WIRE),.W(1),.N(`INTF_REPS))   see_dhready(.s_c_i(r_ver_clk),.s_d_i(s_d_hready),.s_d_o(s_d_hready_see));
see_wires #(.LABEL("DHRESP"),.GROUP(SEEGR_BUS_WIRE),.W(1),.N(`INTF_REPS))    see_dhresp(.s_c_i(r_ver_clk),.s_d_i(s_d_hresp),.s_d_o(s_d_hresp_see));
//see_wires #(.LABEL("DHBURST"),.GROUP(SEEGR_BUS_WIRE),.W(3))     see_dhburst(.s_c_i(r_ver_clk),.s_d_i(s_d_hburst),.s_d_o(s_d_hburst_see));
//see_wires #(.LABEL("DHMASTLOCK"),.GROUP(SEEGR_BUS_WIRE),.W(1))  see_dhmastlock(.s_c_i(r_ver_clk),.s_d_i(s_d_hmastlock),.s_d_o(s_d_hmastlock_see));
//see_wires #(.LABEL("DHPROT"),.GROUP(SEEGR_BUS_WIRE),.W(4))      see_dhprot(.s_c_i(r_ver_clk),.s_d_i(s_d_hprot),.s_d_o(s_d_hprot_see));

`ifdef PROT_INTF
//replication is at the ouput of the interconnect
assign s_d_hready[1]    = s_d_hready[0];
assign s_d_hready[2]    = s_d_hready[0];
assign s_d_hresp[1]     = s_d_hresp[0];
assign s_d_hresp[2]     = s_d_hresp[0];
assign s_i_hready[1]    = s_i_hready[0];
assign s_i_hready[2]    = s_i_hready[0];
assign s_i_hresp[1]     = s_i_hresp[0];
assign s_i_hresp[2]     = s_i_hresp[0];
`endif

/* Emulation of Single Event Transient faults at clock and reset signals 
   - faults are emulated only for a DUT
   - each fault creates a new rising and falling edge during the second half of the source clock period 
*/
`ifdef SEE_TESTING
see_insert #(.W(1),.N(3),.GROUP(SEEGR_CORE_WIRE),.ELOG("T"),.LABEL("CLK"),.MPROB(0)) see_clk(.s_clk_i(r_ver_clk),.s_upset_o(s_upset_clk));
see_insert #(.W(1),.N(3),.GROUP(SEEGR_CORE_WIRE),.ELOG("T"),.LABEL("RSTN"),.MPROB(0)) see_rst(.s_clk_i(r_ver_clk),.s_upset_o(s_upset_resetn));

always #(r_clk_time + {1'b0,r_clk_time[31:1]}) r_err_clk = ~r_err_clk;
`endif

genvar s;
generate
    for(s=0;s<3;s++)begin
`ifdef SEE_TESTING
        assign s_clk_see[s]     = (~s_upset_clk[s] | r_ver_clk) ? r_ver_clk : r_err_clk;
        assign s_resetn_see[s]  = (r_ver_rstn ^ s_upset_resetn[s]);
        assign s_clk_dut[s]     = ~r_ver_rstn ? r_ver_clk : s_clk_see[s];
        assign s_resetn_dut[s]  = ~r_ver_rstn ? 1'b0 : s_resetn_see[s];
`else
        assign s_clk_dut[s]     = r_ver_clk;
        assign s_resetn_dut[s]  = r_ver_rstn;
`endif
    end
    for(s=0;s<SUBORDINATES;s++)begin
        assign s_ahb_sbase[s]   = PMA_CONFIG[s].base;
        assign s_ahb_smask[s]   = PMA_CONFIG[s].mask;
    end
endgenerate
endmodule
