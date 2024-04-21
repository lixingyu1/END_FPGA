module pwm_adc (
    input               clk,
    input               rstn,
    input    [18:0]     freq,

    output   reg        pwm
);

reg [22:0]  cnt_max;
reg [22:0]cnt;

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        cnt_max <= 0;
    else 
        cnt_max <= 781250 /  freq ; 
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        cnt <= 0;
    else if(cnt >= cnt_max - 1)
        cnt <= 0;
    else
        cnt <= cnt + 1;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        pwm <= 0;
    else if(cnt >= cnt_max - 1)
        pwm <= ~pwm;
    else
        pwm <= pwm;
end




endmodule //pwm_adc