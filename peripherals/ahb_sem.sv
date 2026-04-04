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

import edac::*;

/* AHB3-Lite peripheral wrapping the Xilinx Soft Error Mitigation (SEM) controller.
   The sem_0_sem_example module is instantiated inside this peripheral.

   Register map (word-addressed from base):
     0x00  STATUS        [7:0]   RO  SEM status signals packed into bits [7:0]:
                                       [0] heartbeat
                                       [1] initialization
                                       [2] observation
                                       [3] correction
                                       [4] classification
                                       [5] injection
                                       [6] essential
                                       [7] uncorrectable
     0x04  INJECT_STROBE [0]    WO  Write 1 to issue a single-cycle inject_strobe pulse;
                                    auto-clears after one clock.
                                    Afte the error injection command (r_inject_addr_hi == 8'hC0)
                                    is finished, the controller is automatically issued with
                                    command for transition to observation state.
     0x08  INJECT_ADDR_LO[31:0] RW  inject_address[31:0]
     0x0C  INJECT_ADDR_HI[7:0]  RW  inject_address[39:32]

   Monitor UART signals (monitor_tx / monitor_rx) are routed directly to ports. */

module ahb_sem #(
    parameter IFP = 0
)(
    input  logic        s_clk_i,
    input  logic        s_resetn_i,

    // AHB3-Lite slave
    input  logic [31:0] s_haddr_i,
    input  logic [31:0] s_hwdata_i,
    input  logic [2:0]  s_hburst_i,
    input  logic        s_hmastlock_i,
    input  logic [3:0]  s_hprot_i,
    input  logic [2:0]  s_hsize_i,
    input  logic [1:0]  s_htrans_i,
    input  logic        s_hwrite_i,
    input  logic        s_hsel_i,

    input  logic [5:0]  s_hparity_i,
    input  logic [6:0]  s_hwchecksum_i,
    output logic [6:0]  s_hrchecksum_o,

    output logic [31:0] s_hrdata_o,
    output logic        s_hready_o,
    output logic        s_hresp_o,

    // SEM monitor UART pass-through
    output logic        s_monitor_tx_o,
    input  logic        s_monitor_rx_i
);
    localparam MEM_SIZE = 32'd16;
    localparam MSB      = $clog2(MEM_SIZE) - 32'h1;

    // AHB controller API signals
    logic        s_ap_detected, s_dp_accepted, s_dp_write;
    logic [31:0] s_dp_address;
    logic [1:0]  s_dp_size;

    logic [31:0] s_read_data;
    logic        s_we;

    // Internal registers
    logic        r_inject_strobe;
    logic [31:0] r_inject_addr_lo;
    logic [7:0]  r_inject_addr_hi;

    // SEM status wires
    logic s_status_heartbeat;
    logic s_status_initialization;
    logic s_status_observation;
    logic s_status_correction;
    logic s_status_classification;
    logic s_status_injection;
    logic s_status_essential;
    logic s_status_uncorrectable;

    // Registered status signals
    logic r_status_heartbeat;
    logic r_status_initialization;
    logic r_status_observation;
    logic r_status_correction;
    logic r_status_classification;
    logic r_status_injection;
    logic r_status_essential;
    logic r_status_uncorrectable;

    assign s_we = s_dp_accepted & s_dp_write;

    // Capture status signals in registers
    always_ff @(posedge s_clk_i) begin
        r_status_heartbeat      <= s_status_heartbeat;
        r_status_initialization <= s_status_initialization;
        r_status_observation    <= s_status_observation;
        r_status_correction     <= s_status_correction;
        r_status_classification <= s_status_classification;
        r_status_injection      <= s_status_injection;
        r_status_essential      <= s_status_essential;
        r_status_uncorrectable  <= s_status_uncorrectable;
    end

    // INJECT_STROBE: auto-clearing register — set on write, cleared next cycle
    always_ff @(posedge s_clk_i or negedge s_resetn_i) begin
        if (~s_resetn_i)
            r_inject_strobe <= 1'b0;
        else if (r_status_injection & ~s_status_injection & (r_inject_addr_hi == 8'hC0))
            r_inject_strobe <= 1'b1;
        else if (s_we & (s_dp_address[MSB:2] == 2'd1))
            r_inject_strobe <= s_hwdata_i[0];
        else
            r_inject_strobe <= 1'b0;
    end

    // INJECT_ADDR_LO: inject_address[31:0]
    always_ff @(posedge s_clk_i or negedge s_resetn_i) begin
        if (~s_resetn_i)
            r_inject_addr_lo <= 32'b0;
        else if (s_we & (s_dp_address[MSB:2] == 2'd2))
            r_inject_addr_lo <= s_hwdata_i;
    end

    // INJECT_ADDR_HI: inject_address[39:32]
    always_ff @(posedge s_clk_i or negedge s_resetn_i) begin
        if (~s_resetn_i)
            r_inject_addr_hi <= 8'b0;
        else if (r_status_injection & ~s_status_injection & (r_inject_addr_hi == 8'hC0))
            r_inject_addr_hi <= 8'hA0;
        else if (s_we & (s_dp_address[MSB:2] == 2'd3))
            r_inject_addr_hi <= s_hwdata_i[7:0];
    end

    // Read data mux — combinational in the data phase
    always_comb begin : sem_read
        case (s_dp_address[MSB:2])
            2'd0:    s_read_data = {24'b0,
                                    r_status_uncorrectable,
                                    r_status_essential,
                                    r_status_injection,
                                    r_status_classification,
                                    r_status_correction,
                                    r_status_observation,
                                    r_status_initialization,
                                    r_status_heartbeat};
            2'd1:    s_read_data = {31'b0, r_inject_strobe};
            2'd2:    s_read_data = r_inject_addr_lo;
            default: s_read_data = {24'b0, r_inject_addr_hi};
        endcase
    end

    assign s_hrdata_o = s_read_data;

    generate
        if (IFP == 1)
            assign s_hrchecksum_o = edac_checksum(s_read_data);
        else
            assign s_hrchecksum_o = 7'b0;
    endgenerate

    // SEM controller instance
    sem_0_sem_example sem_inst (
        .clk                    (s_clk_i),
        .status_heartbeat       (s_status_heartbeat),
        .status_initialization  (s_status_initialization),
        .status_observation     (s_status_observation),
        .status_correction      (s_status_correction),
        .status_classification  (s_status_classification),
        .status_injection       (s_status_injection),
        .status_essential       (s_status_essential),
        .status_uncorrectable   (s_status_uncorrectable),
        .inject_strobe          (r_inject_strobe),
        .inject_address         ({r_inject_addr_hi, r_inject_addr_lo}),
        .monitor_tx             (s_monitor_tx_o),
        .monitor_rx             (s_monitor_rx_i)
    );

    ahb_controller_m #(.IFP(IFP)) ahb_ctrl
    (
        .s_clk_i        (s_clk_i),
        .s_resetn_i     (s_resetn_i),

        .s_haddr_i      (s_haddr_i),
        .s_hburst_i     (s_hburst_i),
        .s_hmastlock_i  (s_hmastlock_i),
        .s_hprot_i      (s_hprot_i),
        .s_hsize_i      (s_hsize_i),
        .s_htrans_i     (s_htrans_i),
        .s_hwrite_i     (s_hwrite_i),
        .s_hsel_i       (s_hsel_i),

        .s_hparity_i    (s_hparity_i),

        .s_hready_o     (s_hready_o),
        .s_hresp_o      (s_hresp_o),

        .s_ap_error_i   (1'b0),
        .s_dp_delay_i   (1'b0),

        .s_ap_detected_o(s_ap_detected),
        .s_dp_accepted_o(s_dp_accepted),
        .s_dp_address_o (s_dp_address),
        .s_dp_write_o   (s_dp_write),
        .s_dp_size_o    (s_dp_size)
    );

endmodule
