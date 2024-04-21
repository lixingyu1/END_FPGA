module ram_crtrl (
    input                   clk,   
    input                   rstn, 
    input                   clk_wr,   
    input   [9:0]           rd_addr,
    input                   wr_adc,  
    input                   rd_en,
    input   [11:0]          indata,

    output  reg             wr_end,
    output  [11:0]          data
);

reg [9:0] addr;
reg [9:0] wr_addr;
reg wr_en;
wire clk_ram;

assign clk_ram = (wr_en) ? clk_wr : clk;

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        addr <= 0;
    else if(wr_en == 1)
        addr <= wr_addr;
    else if(rd_en)
        addr <= rd_addr;
    else 
        addr <= addr;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        wr_end <= 0;
    else if(wr_en == 0)
        wr_end <= 1;
    else if(wr_en == 1)
        wr_end <= 0;
    else
        wr_end <= wr_end;     
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        wr_en <= 0;
    else if(wr_adc == 1)
        wr_en <= 1;
    else if(wr_addr == 255)
        wr_en <= 0;
    else 
        wr_en <= wr_en;
end

always @(posedge clk_wr or negedge rstn) begin
    if(!rstn)
        wr_addr <= 0;
    else if(wr_en == 1)
        wr_addr <= wr_addr + 1;
    else if(wr_en == 0)
        wr_addr <= 0;
end

ram	ram_inst (
	.aclr ( ~rstn ),
	.address ( addr ),
	.clock ( clk_ram ),
	.data ( indata ),
	.rden ( rd_en ),
	.wren ( wr_en ),
	.q ( data )
	);

endmodule //ram_crtrl