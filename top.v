module top (
    input               clk,
    input               rstn,
    input               ADC_START,
    input   [12:0]      ADC_IN,
    input               ADC_RD,
    input   [9:0]       addr,
    input               adc_fre,
    input               AD_9226_CLK,
    input               test,

    output              wr_end,
    output   [11:0]       ADC_OUT ,
    output wire         clk_driver,
    output              clk_driver_1,
    output              tx
);
wire ADC_OTR;
wire [11:0]volt;
wire areset;
wire locked;
reg clk_9226;
wire clk_freq;
reg AD_9226_CLK_1;
wire    [18:0]  freq;


assign led = wr_end;

assign clk_driver_1 = clk_driver;


always @(posedge clk_freq or negedge rstn) begin
    if(!rstn)
        AD_9226_CLK_1 <= 0;
    else
        AD_9226_CLK_1 <= AD_9226_CLK;
end




//RAM存储ADC数据
ram_crtrl u_ram_crtrl(
    .clk     ( clk     ),
    .rstn    ( rstn    ),
    .clk_wr  ( AD_9226_CLK  ),
    .rd_addr ( addr ),
    .wr_adc  ( ADC_START  ),
    .rd_en   ( ADC_RD   ),
    .indata  ( volt  ),
    .wr_end  ( wr_end  ),
    .data    (  ADC_OUT   )
);

//AD9226
AD9226 u_AD9226(
    .clk        ( AD_9226_CLK_1),
    .rstn       ( rstn       ),
    .clk_driver ( clk_driver ),
    .IO_data    ( ADC_IN    ),

    .ADC_Data   ( {ADC_OTR, volt}  )
);


//频率计时钟
pll	pll_adc_inst (
	.areset ( ~rstn ),
	.inclk0 ( clk ),
	.c0 ( clk_freq ),
	.locked ( locked )
	);


//频率计
ferq u_ferq(
    .clk  ( clk  ),
    .test ( test ),
    .rstn ( rstn ),
    .freq  (  freq )
);



pwm_adc u_pwm_adc(
    .clk  ( clk_freq  ),
    .rstn ( rstn ),
    .freq ( freq ),
    .pwm  ( pwm  )
);


endmodule //top