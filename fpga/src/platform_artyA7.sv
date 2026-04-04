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

import p_hardisc::*;
import edac::*;

//`timescale 1ps/1ps

//`define USE_BOOTLOADER
`define CLK_FREQUENCY 32'd75000000

`ifdef PROT_INTF
    `define MEMORY_IFP 1
    `define INTF_REPS  3 
    `define SYSTEM system_hardisc //available systems: system_hardisc, system_dcls
`else
    `define MEMORY_IFP 0
    `define INTF_REPS  1
    `define SYSTEM system_core 
`endif

module platform_artyA7(
    input s_clk_i,
    input sw[2],

    output led[4],

    input uart_txd_in,
    output uart_rxd_out
);

`ifdef USE_BOOTLOADER
localparam BOOTADD  = 32'h00000000;
localparam INIT_RAM = 0;
`else
localparam BOOTADD  = 32'h10000000;
localparam INIT_RAM = 1;
`endif

localparam SUBORDINATES = 5;
localparam MEM_SIZE = 32'h20000;
localparam MEM_MASK = 32'hFFFFFFFF - MEM_SIZE + 32'h1;

localparam pma_cfg_t PMA_CONFIG[SUBORDINATES] = '{
    '{base  : 32'h00000000, mask  : 32'hFFFFFF00, read_only  : 1'b1, executable: 1'b1, idempotent : 1'b1},
    '{base  : 32'h10000000, mask  : MEM_MASK, read_only  : 1'b0, executable: 1'b1, idempotent : 1'b1},
    '{base  : 32'h80000000, mask  : 32'hFFFFF400, read_only  : 1'b0, executable: 1'b1, idempotent : 1'b1},
    '{base  : 32'h80001000, mask  : 32'hFFFFF400, read_only  : 1'b0, executable: 1'b1, idempotent : 1'b1},
    '{base  : 32'h80002000, mask  : 32'hFFFFF400, read_only  : 1'b0, executable: 1'b1, idempotent : 1'b1}
};

logic[5:0] s_i_hparity[1];
logic[6:0] s_i_hrchecksum[1], s_i_hwchecksum[1];
logic[31:0] s_i_hrdata[1], s_i_haddr[1], s_i_hwdata[1];
logic s_i_hwrite[1], s_i_hmastlock[1],s_i_hready[`INTF_REPS],s_i_hresp[`INTF_REPS];
logic[1:0] s_i_htrans[1];
logic[2:0] s_i_hsize[1],s_i_hburst[1];
logic[3:0] s_i_hprot[1];

logic[5:0] s_d_hparity[1];
logic[6:0] s_d_hrchecksum[1], s_d_hwchecksum[1];
logic[31:0] s_d_hrdata[1], s_d_haddr[1], s_d_hwdata[1];
logic s_d_hwrite[1], s_d_hmastlock[1],s_d_hready[`INTF_REPS],s_d_hresp[`INTF_REPS];
logic[1:0] s_d_htrans[1];
logic[2:0] s_d_hsize[1],s_d_hburst[1];
logic[3:0] s_d_hprot[1];

logic[6:0] s_shrchecksum[SUBORDINATES-1];
logic[31:0] s_shrdata[SUBORDINATES-1];
logic s_shready[SUBORDINATES-1], s_shresp[SUBORDINATES-1], s_shsel[SUBORDINATES-1];
logic[31:0] s_ahb_sbase[SUBORDINATES-1], s_ahb_smask[SUBORDINATES-1];

logic[6:0] s_chrchecksum[2];
logic[31:0] s_chrdata[2];
logic s_chready[2], s_chresp[2], s_chsel[2];
logic[31:0] s_ahb_cbase[2], s_ahb_cmask[2];
logic[31:0] r_uerr_cntr;
logic r_uerr_halt;

logic s_sys_clk, s_sys_rstn, s_resetn_deb, s_int_meip, s_int_mtip, s_unrec_err[2], s_locked, s_uart_sel_deb;
logic s_dut_clk[3], s_dut_rstn[3];

debounce m_deb_resetn
(
    .s_clk_i(s_sys_clk),
    .s_btn_i(sw[0]),
    .s_btn_o(s_resetn_deb)
);

debounce m_deb_uart_sel
(
    .s_clk_i(s_sys_clk),
    .s_btn_i(sw[1]),
    .s_btn_o(s_uart_sel_deb)
);

logic r_uart_txd_in;
logic s_uart_tx_sem, s_uart_rx_sem, s_uart_tx_dut, s_uart_rx_dut;

always_ff @(posedge s_sys_clk) r_uart_txd_in <= uart_txd_in;

assign uart_rxd_out = s_uart_sel_deb ? s_uart_tx_sem : s_uart_tx_dut;

// Select which devide is connected to UART bus
always_comb begin
    if(s_uart_sel_deb)begin
        s_uart_rx_sem = r_uart_txd_in;
        s_uart_rx_dut = 1'b1;
    end else begin
        s_uart_rx_dut = r_uart_txd_in;
        s_uart_rx_sem = 1'b1;    
    end
end

// Observe unrecoverable error signalization
always_ff @(posedge s_sys_clk or negedge s_sys_rstn) begin
    if(!s_sys_rstn) begin
        r_uerr_cntr <= 32'b0;
    end else if(s_unrec_err[0] || s_unrec_err[1]) begin
        r_uerr_cntr <= r_uerr_cntr + 32'b1;
    end else begin
        r_uerr_cntr <= 32'b0;
    end
    if(!s_sys_rstn) begin
        r_uerr_halt <= 1'b0;
    end else if(!r_uerr_halt) begin
        // Give the SEM time to fix the error and DUT to recover
        r_uerr_halt <= r_uerr_cntr > `CLK_FREQUENCY;
    end
end

clk_wiz_0 
(
  .clk_out1(s_sys_clk),
  .resetn(sw[0]),
  .locked(s_locked),
  .clk_in1(s_clk_i)
);

//assign s_sys_clk    = s_clk_i;
assign s_sys_rstn   = s_resetn_deb & s_locked;

assign led[0]   = s_chsel[0]; //rom
assign led[1]   = s_chsel[1]; //ram
assign led[2]   = m_sem.r_status_essential;
assign led[3]   = r_uerr_halt;

assign s_int_meip   = s_uart_interrupt;

assign s_dut_clk[0] = s_sys_clk;
assign s_dut_clk[1] = s_sys_clk;
assign s_dut_clk[2] = s_sys_clk;

assign s_dut_rstn[0] = s_sys_rstn;
assign s_dut_rstn[1] = s_sys_rstn;
assign s_dut_rstn[2] = s_sys_rstn;

(* dont_touch = "yes" *) `SYSTEM #(.PMA_REGIONS(SUBORDINATES),.PMA_CFG(PMA_CONFIG)) dut
(
    .s_clk_i(s_dut_clk),
    .s_resetn_i(s_dut_rstn),
    .s_int_meip_i(s_int_meip),
    .s_int_mtip_i(s_int_mtip),
    .s_boot_add_i(BOOTADD),
    
    .s_i_hrdata_i(s_i_hrdata[0]),
    .s_i_hready_i(s_i_hready),
    .s_i_hresp_i(s_i_hresp),
    .s_i_haddr_o(s_i_haddr[0]),
    .s_i_hwdata_o(s_i_hwdata[0]),
    .s_i_hburst_o(s_i_hburst[0]),
    .s_i_hmastlock_o(s_i_hmastlock[0]),
    .s_i_hprot_o(s_i_hprot[0]),
    .s_i_hsize_o(s_i_hsize[0]),
    .s_i_htrans_o(s_i_htrans[0]),
    .s_i_hwrite_o(s_i_hwrite[0]),

    .s_i_hrchecksum_i(s_i_hrchecksum[0]),
    .s_i_hwchecksum_o(s_i_hwchecksum[0]),
    .s_i_hparity_o(s_i_hparity[0]),

    .s_d_hrdata_i(s_d_hrdata[0]),
    .s_d_hready_i(s_d_hready),
    .s_d_hresp_i(s_d_hresp),
    .s_d_haddr_o(s_d_haddr[0]),
    .s_d_hwdata_o(s_d_hwdata[0]),
    .s_d_hburst_o(s_d_hburst[0]),
    .s_d_hmastlock_o(s_d_hmastlock[0]),
    .s_d_hprot_o(s_d_hprot[0]),
    .s_d_hsize_o(s_d_hsize[0]),
    .s_d_htrans_o(s_d_htrans[0]),
    .s_d_hwrite_o(s_d_hwrite[0]),

    .s_d_hrchecksum_i(s_d_hrchecksum[0]),
    .s_d_hwchecksum_o(s_d_hwchecksum[0]),
    .s_d_hparity_o(s_d_hparity[0]),

    .s_unrec_err_o(s_unrec_err)
);

`ifdef PROT_INTF
//replication is at the ouput of the interconnects
assign s_d_hready[1]    = s_d_hready[0];
assign s_d_hready[2]    = s_d_hready[0];
assign s_d_hresp[1]     = s_d_hresp[0];
assign s_d_hresp[2]     = s_d_hresp[0];
assign s_i_hready[1]    = s_i_hready[0];
assign s_i_hready[2]    = s_i_hready[0];
assign s_i_hresp[1]     = s_i_hresp[0];
assign s_i_hresp[2]     = s_i_hresp[0];
`endif

ahb_interconnect #(.SLAVES(2)) instr_interconnect
(
    .s_clk_i(s_sys_clk),
    .s_resetn_i(s_sys_rstn),

    .s_mhaddr_i(s_i_haddr[0]),
    .s_mhtrans_i(s_i_htrans[0]),

    .s_sbase_i(s_ahb_cbase),
    .s_smask_i(s_ahb_cmask),

    .s_shrdata_i(s_chrdata),
    .s_shready_i(s_chready),
    .s_shresp_i(s_chresp),
    .s_hsel_o(s_chsel),

    .s_shrchecksum_i(s_chrchecksum),
    .s_shrchecksum_o(s_i_hrchecksum[0]),
    
    .s_shrdata_o(s_i_hrdata[0]),
    .s_shready_o(s_i_hready[0]),
    .s_shresp_o(s_i_hresp[0])
);

ahb_interconnect #(.SLAVES(4)) data_interconnect
(
    .s_clk_i(s_sys_clk),
    .s_resetn_i(s_sys_rstn),

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

ahb_to_uart_controller #(.PERIOD(32'd130),.IFP(`MEMORY_IFP),.SIMULATION(0)) ahb_uart
(
    .s_clk_i(s_sys_clk),
    .s_resetn_i(s_sys_rstn),
    
    //AHB3-Lite
    .s_haddr_i(s_d_haddr[0]),
    .s_hwdata_i(s_d_hwdata[0]),
    .s_hready_i(s_d_hready[0]),
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
    .s_hresp_o(s_shresp[1]),
    
    .s_data_ready_o(s_uart_interrupt),

    .s_rxd_i(s_uart_rx_dut),
    .s_txd_o(s_uart_tx_dut)
);

ahb_timer #(.IFP(`MEMORY_IFP)) m_mtimer
(
    .s_clk_i(s_sys_clk),
    .s_resetn_i(s_sys_rstn),
    
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

ahb_ram #(.MEM_SIZE(32'h100),.MEM_INIT(1),.MEM_FILE("bootloader.mem"),.SAVE_CHECKSUM(0),.SIMULATION(0),.LABEL("BOOT"),.IFP(`MEMORY_IFP),.GROUP(SEEGR_MEMORY),.MPROB(0)) m_boot
(
    .s_clk_i(s_sys_clk),
    .s_resetn_i(s_sys_rstn),
    
    //AHB3-Lite
    .s_haddr_i(s_i_haddr[0]),
    .s_hwdata_i(s_i_hwdata[0]),
    .s_hburst_i(s_i_hburst[0]),
    .s_hmastlock_i(s_i_hmastlock[0]),
    .s_hprot_i(s_i_hprot[0]),
    .s_hsize_i(s_i_hsize[0]),
    .s_htrans_i(s_i_htrans[0]),
    .s_hwrite_i(s_i_hwrite[0]),
    .s_hsel_i(s_chsel[0]),

    .s_hparity_i(s_i_hparity[0]),
    .s_hwchecksum_i(s_i_hwchecksum[0]),
    .s_hrchecksum_o(s_chrchecksum[0]),
    
    .s_hrdata_o(s_chrdata[0]),
    .s_hready_o(s_chready[0]),
    .s_hresp_o(s_chresp[0])
);

logic s_m_hmastlock[2], s_m_hwrite[2], s_m_hsel[2], s_m_hready[2], s_m_hresp[2];
logic[1:0] s_m_htrans[2];
logic[2:0] s_m_hburst[2],s_m_hsize[2];
logic[3:0] s_m_hprot[2];
logic[31:0] s_m_haddr[2];
logic[31:0] s_m_hwdata[2], s_m_hrdata[2];
logic[6:0] s_m_hwchecksum[2], s_m_hrchecksum[2];
logic[5:0] s_m_hparity[2];

assign s_m_hmastlock   = {s_d_hmastlock[0], s_i_hmastlock[0]};
assign s_m_hwrite      = {s_d_hwrite[0], s_i_hwrite[0]};
assign s_m_hsel        = {s_shsel[0], s_chsel[1]};
assign s_m_htrans      = {s_d_htrans[0], s_i_htrans[0]};
assign s_m_hburst      = {s_d_hburst[0], s_i_hburst[0]};
assign s_m_hsize       = {s_d_hsize[0], s_i_hsize[0]};
assign s_m_hprot       = {s_d_hprot[0], s_i_hprot[0]};
assign s_m_haddr       = {s_d_haddr[0], s_i_haddr[0]};
assign s_m_hwdata      = {s_d_hwdata[0], s_i_hwdata[0]};
assign s_m_hwchecksum  = {s_d_hwchecksum[0], s_i_hwchecksum[0]};
assign s_m_hparity     = {s_d_hparity[0], s_i_hparity[0]};

assign s_chready[1]     = s_m_hready[1];
assign s_chresp[1]      = s_m_hresp[1];
assign s_chrdata[1]     = s_m_hrdata[1];
assign s_chrchecksum[1] = s_m_hrchecksum[1];

assign s_shready[0]     = s_m_hready[0];
assign s_shresp[0]      = s_m_hresp[0];
assign s_shrdata[0]     = s_m_hrdata[0];
assign s_shrchecksum[0] = s_m_hrchecksum[0];

dahb_ram #(.MEM_SIZE(MEM_SIZE),.SIMULATION(0),.ENABLE_LOG(0),.SAVE_CHECKSUM(!INIT_RAM),.MEM_INIT(INIT_RAM),.MEM_FILE("matrix.mem"),.LABEL("MEMORY"),.IFP(`MEMORY_IFP),.GROUP(SEEGR_MEMORY)) m_memory
(
    .s_clk_i(s_sys_clk),
    .s_resetn_i(s_sys_rstn),
    
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
    .s_hready_o(s_m_hready),
    .s_hresp_o(s_m_hresp)
);

(* dont_touch = "yes" *) ahb_sem #(.IFP(`MEMORY_IFP)) m_sem
(
    .s_clk_i(s_sys_clk),
    .s_resetn_i(s_sys_rstn),

    .s_haddr_i(s_d_haddr[0]),
    .s_hwdata_i(s_d_hwdata[0]),
    .s_hburst_i(s_d_hburst[0]),
    .s_hmastlock_i(s_d_hmastlock[0]),
    .s_hprot_i(s_d_hprot[0]),
    .s_hsize_i(s_d_hsize[0]),
    .s_htrans_i(s_d_htrans[0]),
    .s_hwrite_i(s_d_hwrite[0]),
    .s_hsel_i(s_shsel[3]),

    .s_hparity_i(s_d_hparity[0]),
    .s_hwchecksum_i(s_d_hwchecksum[0]),
    .s_hrchecksum_o(s_shrchecksum[3]),

    .s_hrdata_o(s_shrdata[3]),
    .s_hready_o(s_shready[3]),
    .s_hresp_o(s_shresp[3]),

    .s_monitor_tx_o(s_uart_tx_sem),
    .s_monitor_rx_i(s_uart_rx_sem)
);

genvar s;
generate
    for(s=1;s<SUBORDINATES;s++)begin
        assign s_ahb_sbase[s-1]   = PMA_CONFIG[s].base;
        assign s_ahb_smask[s-1]   = PMA_CONFIG[s].mask;
    end
    for(s=0;s<2;s++)begin
        assign s_ahb_cbase[s]   = PMA_CONFIG[s].base;
        assign s_ahb_cmask[s]   = PMA_CONFIG[s].mask;
    end
endgenerate

/*ila_0 ila
(
    .clk(s_clk_i),
    .probe0(s_unrec_err[0]),
    .probe1(dut.rep[0].core.m_pipe_5_ma.m_csru.s_livelock[0]),
    .probe2(m_sem.r_status_heartbeat),
    .probe3(dut.rep[0].core.m_pipe_5_ma.m_csru.s_execute[0]),
    .probe4(dut.rep[0].core.m_pipe_5_ma.m_csru.s_rstpp_i[0]),
    .probe5(dut.rep[0].core.m_pipe_5_ma.m_csru.s_mcause[0]),
    .probe6(dut.rep[0].core.m_pipe_5_ma.m_csru.s_mhrdctrl0[0]),
    .probe7(dut.rep[0].core.m_pipe_5_ma.m_csru.s_pc_i[0]),
    .probe8(dut.rep[0].core.s_i_hready_i[0]),
    .probe9(dut.rep[0].core.s_d_hready_i[0]),
    .probe10(dut.rep[0].core.s_i_hresp_i[0]),
    .probe11(dut.rep[0].core.s_d_hresp_i[0])
);*/

endmodule
