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

import seed_instance::*;

module ahb_ram#(
    parameter MEM_SIZE = 32'h00001000,
    parameter SIMULATION = 0,
    parameter ENABLE_LOG = 1,
    parameter GROUP = 1,
    parameter MPROB = 1,
    parameter IFP = 0,
    parameter MEM_INIT = 0,
    parameter MEM_FILE = "SPECIFY",
    parameter LABEL = "MEMORY"
)
(
    input logic s_clk_i,
    input logic s_resetn_i,
    
    //AHB3-Lite
    input logic[31:0] s_haddr_i,
    input logic[31:0] s_hwdata_i,
    input logic[2:0] s_hburst_i,
    input logic s_hmastlock_i,
    input logic[3:0] s_hprot_i,
    input logic[2:0] s_hsize_i,
    input logic[1:0] s_htrans_i,
    input logic s_hwrite_i,
    input logic s_hsel_i,

    input logic[5:0] s_hparity_i,
    input logic[6:0] s_hwchecksum_i,
    output logic[6:0] s_hrchecksum_o,
    
    output logic[31:0] s_hrdata_o,
    output logic s_hready_o,
    output logic s_hresp_o
);
    /* Simple dual-port RAM with AMBA 3 AHB-Lite interface */
    localparam MSB = $clog2(MEM_SIZE) - 32'h1;
    localparam[31:0] GROUP_MASK = (32'b1 << GROUP);

    logic[31:0] s_read_data, s_write_data;
    logic[MSB:0] r_address, r_paddress, s_ra;
    logic[1:0] r_size;
    logic r_write, r_trans, r_hresp;
    logic[31:0] r_memory[MEM_SIZE[31:2]] = '{default:0};
    logic[31:0] r_data, r_wtor_data;
    logic s_byte[4];
    logic s_we, r_wtor, s_cclock, s_parity_error;
    logic s_wrong_comb, s_transfer;

    logic[5:0] s_parity;
    logic[6:0] s_read_checksum;
    logic[6:0] r_cmemory[MEM_SIZE[31:2]] = '{default:0};
    logic[31:0] r_checksum, r_wtor_checksum;

    logic l_clock;
    logic[1:0] r_delay;

generate
    initial begin
        if(MEM_INIT == 1)begin
            $readmemh(MEM_FILE,r_memory);
        end
    end
    if(SIMULATION == 1)begin
        int logging, see_prob, see_group;
        logic latency;
        logic[31:0] seed, randomval;

        initial begin
            latency = 0;
            logging = 0;
            seed_instance::srandom($sformatf("%m"));
            if($value$plusargs ("SEE_PROB=%d", see_prob));
            if($value$plusargs ("SEE_GROUP=%d", see_group));
            if($value$plusargs ("LOGGING=%d", logging));
            if($value$plusargs ("LAT=%d", latency));
            seed = $urandom;
            see_prob = see_prob * MPROB;
            if(latency != 0)
                $write("MEMORY SEED: %d\n",seed);
        end

        if(ENABLE_LOG == 1)begin
            always_ff @( posedge s_clk_i ) begin : trace
                if(s_we)begin
                    if(logging == 0)begin
                        $write("%c",s_write_data);
                    end else if(logging > 1)begin
                        $write("Storing of %x to %s[%x]\n",s_write_data,LABEL,r_address);
                    end
                end
            end
        end

        //Latency generation
        always_ff @(posedge s_clk_i or negedge s_resetn_i) begin : delay_control
            if(~s_resetn_i | ~latency)begin
                r_delay   <= 2'b0;
                randomval <= 32'b0; 
            end else if(r_delay != 2'b0)begin
                r_delay   <= r_delay - 2'b1;
                randomval <= randomval;
            end else if(s_hsel_i & s_transfer & s_hready_o)begin
                r_delay   <= s_parity_error ? 2'b0 : randomval[1:0];
                randomval <= $urandom(seed+randomval);
            end else begin
                r_delay   <= 2'b0;
                randomval <= randomval;
            end
        end

        //Error generation
        if(IFP == 1)begin
            logic[31:0] r_seu_randomval, s_filtered;
            logic[MSB:0] s_error_addr;
            logic[7:0] s_error_bit;

            assign s_error_addr = r_seu_randomval[31:31-MSB+2];
            assign s_error_bit  = r_seu_randomval[7:0]; //error probability 39/256

            always_ff @( posedge s_clk_i ) begin
                if((see_prob != 0) & ((GROUP_MASK & see_group) != 0))begin
                    r_seu_randomval <= $urandom(seed + r_seu_randomval);
                    if(s_error_bit < 8'd39)begin
                        r_memory[s_error_addr] <= r_memory[s_error_addr] ^ (1 << s_error_bit);
                        if(s_error_bit > 8'd31)
                            r_cmemory[s_error_addr] <= r_cmemory[s_error_addr] ^ (1 << s_error_bit);
                        if(logging > 2)
                            $write("SEU in %s[%08h][%02h]\n",LABEL,{s_error_addr,2'b0},s_error_bit);    
                    end                        
                end                
            end
        end
        
        //Disable update of the internal registers if a response is being delayed
        always_latch begin : clockgating
            if(~s_clk_i)
                l_clock <= (r_delay == 2'b00);
        end
        
        assign s_cclock = s_clk_i & l_clock;

        assign s_we     = r_write & (r_delay == 2'b00);
        assign s_ra     = (r_delay == 2'b00) ? s_haddr_i[$clog2(MEM_SIZE)-1:0] : r_address;
    end else begin
        assign s_we     = r_write;
        assign s_ra     = s_haddr_i[$clog2(MEM_SIZE)-1:0];
        assign r_delay  = 2'b0;
        assign s_cclock = s_clk_i;
    end
    if(IFP == 1)begin
        assign s_parity_error   = s_parity != s_hparity_i;
        assign s_wrong_comb     = (^s_htrans_i) ^ s_hparity_i[5];
    end else begin
        assign s_parity_error   = 1'b0;
        assign s_wrong_comb     = 1'b0;
    end
endgenerate

genvar p;
generate
    for (p=0;p<4;p++) begin
        assign s_parity[p]  = s_haddr_i[0 + p] ^ s_haddr_i[4 + p] ^ s_haddr_i[8 + p] ^ s_haddr_i[12 + p] ^
                              s_haddr_i[16 + p] ^ s_haddr_i[20 + p] ^ s_haddr_i[24 + p] ^ s_haddr_i[28 + p];            
    end
endgenerate

    assign s_parity[4]  = (^s_hsize_i) ^ (^s_hburst_i) ^ (^s_hprot_i) ^ s_hwrite_i ^ s_hmastlock_i; //hsize, hwrite, hprot, hburst, hmastlock
    assign s_parity[5]  = (^s_htrans_i); //htrans

    assign s_transfer   = s_wrong_comb | (s_htrans_i == 2'd2);

    //Forward data if a write is followed by the read from the same address
    assign s_read_data          = (r_wtor & (r_address[MSB:2] == r_paddress[MSB:2])) ? r_wtor_data : r_data;
    assign s_write_data[7:0]    = (s_we && s_byte[0]) ? s_hwdata_i[7:0] : s_read_data[7:0];
    assign s_write_data[15:8]   = (s_we && s_byte[1]) ? s_hwdata_i[15:8] : s_read_data[15:8];
    assign s_write_data[23:16]  = (s_we && s_byte[2]) ? s_hwdata_i[23:16] : s_read_data[23:16];
    assign s_write_data[31:24]  = (s_we && s_byte[3]) ? s_hwdata_i[31:24] : s_read_data[31:24];

    //Selected bytes
    assign s_byte[0]    = (r_address[1:0] == 2'd0);
    assign s_byte[1]    = ((r_address[1:0] == 2'd0) && (r_size != 2'd0)) || (r_address[1:0] == 2'd1);
    assign s_byte[2]    = ((r_address[1:0] == 2'd0) && (r_size == 2'd2)) || (r_address[1:0] == 2'd2);
    assign s_byte[3]    = ((r_address[1:0] == 2'd0) && (r_size == 2'd2)) || ((r_address[1:0] == 2'd2) && (r_size == 2'd1)) || (r_address[1:0] == 2'd3);

    //Response
    assign s_hrdata_o[7:0]      = s_byte[0] ? s_read_data[7:0]   : 8'd0;
    assign s_hrdata_o[15:8]     = s_byte[1] ? s_read_data[15:8]  : 8'd0;
    assign s_hrdata_o[23:16]    = s_byte[2] ? s_read_data[23:16] : 8'd0;
    assign s_hrdata_o[31:24]    = s_byte[3] ? s_read_data[31:24] : 8'd0;
    assign s_hready_o   = !(r_hresp & r_trans) & (r_delay == 2'b00);
    assign s_hresp_o    = r_hresp;

    generate
    genvar i;
        for (i = 0; i < 4; i = i+1) begin: byte_write
            always @(posedge s_clk_i)
                if (s_we && s_byte[i])
                    r_memory[r_address[MSB:2]][(i+1)*8-1:i*8] <= s_hwdata_i[(i+1)*8-1:i*8];
        end
        if (IFP == 1) begin
            assign s_hrchecksum_o   = s_read_checksum;    
            assign s_read_checksum  = (r_wtor & (r_address[MSB:2] == r_paddress[MSB:2])) ? r_wtor_checksum : r_checksum;
            //Write checksum
            always @(posedge s_clk_i)begin
                if (s_we)
                    r_cmemory[r_address[MSB:2]] <= s_hwchecksum_i;  
            end          
            //Checksum is read in the address phase
            always_ff @(posedge s_clk_i) begin : memory_checksum_read
                r_checksum <= r_cmemory[s_ra[MSB:2]];
            end
            //Save transfer information
            always_ff @(posedge s_cclock or negedge s_resetn_i) begin : memory_control
                if(~s_resetn_i)begin
                    r_wtor_checksum <= 32'b0;
                end else if(s_hsel_i & s_transfer)begin
                    r_wtor_checksum <= s_we ? s_hwchecksum_i : s_read_checksum;
                end else begin
                    r_wtor_checksum <= r_wtor_checksum;
                end
            end
        end else begin
            assign s_hrchecksum_o = 7'b0;
        end
    endgenerate

    //Data are read in the address phase
    always_ff @(posedge s_clk_i) begin : memory_read
        r_data <= r_memory[s_ra[MSB:2]];
    end

    //Save transfer information
    always_ff @(posedge s_cclock or negedge s_resetn_i) begin : memory_control
        if(~s_resetn_i | (r_hresp & r_trans))begin
            r_trans <= 1'd0;
            r_write <= 1'd0;
            r_address <= '0;
            r_paddress <= '0;
            r_wtor_data <= '0;
            r_size <= 2'd2;
            r_wtor <= 1'b0;
            r_hresp <= (~s_resetn_i) ? 1'b0 : (r_hresp & r_trans);
        end else if(s_hsel_i & s_transfer)begin
            r_trans <= 1'd1;
            r_write <= !s_parity_error & s_hwrite_i;
            r_address <= s_haddr_i[$clog2(MEM_SIZE)-1:0];
            r_paddress <= r_address;
            r_wtor_data <= s_write_data;
            r_size <= s_hsize_i[1:0];
            r_wtor <= !s_parity_error & s_we;
            r_hresp <= s_parity_error;
        end else begin
            r_trans <= 1'd0;
            r_write <= 1'd0;
            r_address <= '0;
            r_paddress <= '0;
            r_wtor_data <= '0;
            r_size <= 2'd2;
            r_wtor <= 1'b0;
            r_hresp <= 1'b0;
        end
    end
endmodule
