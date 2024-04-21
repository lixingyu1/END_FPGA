module ferq (
    input                   clk ,
    input                   test,
    input  wire             rstn,

    output reg   [18:0]     freq          
);



parameter CLK_FREQ = 25_000_000;


reg       test_1;
reg       delay_test;
reg       rising_edge; //上升沿标志
reg       falling_edge;//下降沿标志
reg   [60:0]    cnt;
reg             flag;
//打一拍
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        test_1 <= 0;
    else
        test_1 <= test;
end



always @(posedge clk or negedge rstn) begin
    if(!rstn)
        delay_test <= 0;
    else
        delay_test <= test_1;
end

//检测上升沿
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        rising_edge <= 0;
    else if(delay_test == 0 && test_1 == 1)
        rising_edge <= 1;
    else
        rising_edge <= 0;
end

//检测下降沿
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        falling_edge <= 0;
    else if(delay_test == 1 && test_1 == 0)
        falling_edge <= 1;
    else
        falling_edge <= 0;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        flag <= 0;
    else if(rising_edge == 1)
        flag = 1;
    else if(falling_edge == 1)
        flag = 0;
    else
        flag = flag;
end

always @(posedge clk or negedge rstn) begin
    if(!rstn)
        cnt <= 0;
    else if(flag == 1)
        cnt <= cnt + 1;
    else if(flag == 0)
        cnt <= 0;
end



always @(posedge clk or negedge rstn) begin
    if(!rstn)
        freq <= 0;
    else if(falling_edge == 1)
        freq <= CLK_FREQ / (cnt + 1);
    else if( cnt > 200000000)
        freq <= 1;
    else
        freq <= freq;
end



endmodule //ferq        