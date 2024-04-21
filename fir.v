module  fir_ctrl
#(
    //parameter   FIR_IN  = 16,
    parameter   FIR_IN  = 16,
    parameter   FIR_OUT = 16
)  
(
    input   wire                             sys_clk     ,
    input   wire                             sys_rst_n   ,  
    input   signed  [FIR_IN  - 1:0]          data_in     ,
    input   wire                             data_valid  ,
    
    output  signed  [FIR_OUT - 1:0]          fir_out     ,
    output  wire                             fir_out_valid
);
/* //定义权值（滤波器系数）
reg     signed  [9:0]   h0 ;
reg     signed  [9:0]   h1 ;
reg     signed  [9:0]   h2 ;
reg     signed  [9:0]   h3 ;
reg     signed  [9:0]   h4 ;
reg     signed  [9:0]   h5 ;
reg     signed  [9:0]   h6 ;
reg     signed  [9:0]   h7 ;
reg     signed  [9:0]   h8 ;
reg     signed  [9:0]   h9 ;
reg     signed  [9:0]   h10;
reg     signed  [9:0]   h11;
reg     signed  [9:0]   h12;
reg     signed  [9:0]   h13;
reg     signed  [9:0]   h14;
reg     signed  [9:0]   h15;
reg     signed  [9:0]   h16;
reg     signed  [9:0]   h17;
reg     signed  [9:0]   h18;
reg     signed  [9:0]   h19;
reg     signed  [9:0]   h20;
reg     signed  [9:0]   h21;
reg     signed  [9:0]   h22;
reg     signed  [9:0]   h23;
reg     signed  [9:0]   h24;
reg     signed  [9:0]   h25;
reg     signed  [9:0]   h26;
reg     signed  [9:0]   h27;
reg     signed  [9:0]   h28;
reg     signed  [9:0]   h29;
reg     signed  [9:0]   h30;
reg     signed  [9:0]   h31;

reg     signed  [23:0]   x0 ;
reg     signed  [23:0]   x1 ;
reg     signed  [23:0]   x2 ;
reg     signed  [23:0]   x3 ;
reg     signed  [23:0]   x4 ;
reg     signed  [23:0]   x5 ;
reg     signed  [23:0]   x6 ;
reg     signed  [23:0]   x7 ;
reg     signed  [23:0]   x8 ;
reg     signed  [23:0]   x9 ;
reg     signed  [23:0]   x10;
reg     signed  [23:0]   x11;
reg     signed  [23:0]   x12;
reg     signed  [23:0]   x13;
reg     signed  [23:0]   x14;
reg     signed  [23:0]   x15;
reg     signed  [23:0]   x16;
reg     signed  [23:0]   x17;
reg     signed  [23:0]   x18;
reg     signed  [23:0]   x19;
reg     signed  [23:0]   x20;
reg     signed  [23:0]   x21;
reg     signed  [23:0]   x22;
reg     signed  [23:0]   x23;
reg     signed  [23:0]   x24;
reg     signed  [23:0]   x25;
reg     signed  [23:0]   x26;
reg     signed  [23:0]   x27;
reg     signed  [23:0]   x28;
reg     signed  [23:0]   x29;
reg     signed  [23:0]   x30;
reg     signed  [23:0]   x31; */




reg     signed  [9:0]   h[0:31];   
integer i;      
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        begin
            for(i = 0;i < 32;i = i + 1)
                begin
                    h[i] <= 0;
/*                  h0  <= 10'd0;
                    h1  <= 10'd0;
                    h2  <= 10'd0;
                    h3  <= 10'd0;
                    h4  <= 10'd0;
                    h5  <= 10'd0;
                    h6  <= 10'd0;
                    h7  <= 10'd0;
                    h8  <= 10'd0;
                    h9  <= 10'd0;
                    h10 <= 10'd0;
                    h11 <= 10'd0;
                    h12 <= 10'd0;
                    h13 <= 10'd0;
                    h14 <= 10'd0;
                    h15 <= 10'd0;
                    h16 <= 10'd0;
                    h17 <= 10'd0;
                    h18 <= 10'd0;
                    h19 <= 10'd0;
                    h20 <= 10'd0;
                    h21 <= 10'd0;
                    h22 <= 10'd0;
                    h23 <= 10'd0;
                    h24 <= 10'd0;
                    h25 <= 10'd0; 
                    h26 <= 10'd0;
                    h27 <= 10'd0;
                    h28 <= 10'd0;
                    h29 <= 10'd0;
                    h30 <= 10'd0;
                    h31 <= 10'd0; */
                end
        end        
    else
        begin
            h[0 ] <= 10'd0;
            h[1 ] <= 10'd1;
            h[2 ] <= 10'd1;
            h[3 ] <= 10'd3;
            h[4 ] <= 10'd5;
            h[5 ] <= 10'd9;
            h[6 ] <= 10'd14;
            h[7 ] <= 10'd20;
            h[8 ] <= 10'd28;
            h[9 ] <= 10'd37;
            h[10] <= 10'd46;
            h[11] <= 10'd55;
            h[12] <= 10'd64;
            h[13] <= 10'd72;
            h[14] <= 10'd77;
            h[15] <= 10'd80;
            h[16] <= 10'd80;
            h[17] <= 10'd77;
            h[18] <= 10'd72;
            h[19] <= 10'd64;
            h[20] <= 10'd55;
            h[21] <= 10'd46;
            h[22] <= 10'd37;
            h[23] <= 10'd28;
            h[24] <= 10'd20;
            h[25] <= 10'd14;
            h[26] <= 10'd9;
            h[27] <= 10'd5;
            h[28] <= 10'd3;
            h[29] <= 10'd1;
            h[30] <= 10'd1;
            h[31] <= 10'd0; 
        end



/* always@(posedge sys_clk or negedge sys_rst_n)//数据分配
    if(sys_rst_n == 1'b0)
        begin
            x0  <= 24'b0;
            x1  <= 24'b0;
            x2  <= 24'b0;
            x3  <= 24'b0;
            x4  <= 24'b0;
            x5  <= 24'b0;
            x6  <= 24'b0;
            x7  <= 24'b0;
            x8  <= 24'b0;
            x9  <= 24'b0;
            x10 <= 24'b0;
            x11 <= 24'b0;
            x12 <= 24'b0;
            x13 <= 24'b0;
            x14 <= 24'b0;
            x15 <= 24'b0;
            x16 <= 24'b0;
            x17 <= 24'b0;
            x18 <= 24'b0;
            x19 <= 24'b0;
            x20 <= 24'b0;
            x21 <= 24'b0;
            x22 <= 24'b0;
            x23 <= 24'b0;
            x24 <= 24'b0;
            x25 <= 24'b0;
            x26 <= 24'b0;
            x27 <= 24'b0;
            x28 <= 24'b0;
            x29 <= 24'b0;
            x30 <= 24'b0;
            x31 <= 24'b0;
        end
    else if(data_valid == 1'b1)
        begin
            x0  <= data_in;
            x1  <= x0     ;
            x2  <= x1     ;
            x3  <= x2     ;
            x4  <= x3     ;
            x5  <= x4     ;
            x6  <= x5     ;
            x7  <= x6     ;
            x8  <= x7     ;
            x9  <= x8     ;
            x10 <= x9     ;
            x11 <= x10    ;
            x12 <= x11    ;
            x13 <= x12    ;
            x14 <= x13    ;
            x15 <= x14    ;
            x16 <= x15    ;
            x17 <= x16    ;
            x18 <= x17    ;
            x19 <= x18    ;
            x20 <= x19    ;
            x21 <= x20    ;
            x22 <= x21    ;
            x23 <= x22    ;
            x24 <= x23    ;
            x25 <= x24    ;
            x26 <= x25    ;
            x27 <= x26    ;
            x28 <= x27    ;
            x29 <= x28    ;
            x30 <= x29    ;
            x31 <= x30    ;
        end */

reg     signed  [FIR_IN  - 1:0]  x[0:31];
genvar  k;
generate
    always@(posedge sys_clk or negedge sys_rst_n)
        if(sys_rst_n == 1'b0)
            x[0] <= 0;
        else 
            x[0] <= data_in;
            
    for(k = 1;k <  32;k = k + 1)    
        begin
            always@(posedge sys_clk or negedge sys_rst_n)
                if(sys_rst_n == 1'b0)
                    x[k] <= 0;
                else 
                    x[k] <= x[k - 1];
        end    
endgenerate               
/* //相乘        
reg     signed  [33:0]   xh_mul0 ;
reg     signed  [33:0]   xh_mul1 ;
reg     signed  [33:0]   xh_mul2 ;
reg     signed  [33:0]   xh_mul3 ;
reg     signed  [33:0]   xh_mul4 ;
reg     signed  [33:0]   xh_mul5 ;
reg     signed  [33:0]   xh_mul6 ;
reg     signed  [33:0]   xh_mul7 ;
reg     signed  [33:0]   xh_mul8 ;
reg     signed  [33:0]   xh_mul9 ;
reg     signed  [33:0]   xh_mul10;
reg     signed  [33:0]   xh_mul11;
reg     signed  [33:0]   xh_mul12;
reg     signed  [33:0]   xh_mul13;
reg     signed  [33:0]   xh_mul14;
reg     signed  [33:0]   xh_mul15;
reg     signed  [33:0]   xh_mul16;
reg     signed  [33:0]   xh_mul17;
reg     signed  [33:0]   xh_mul18;
reg     signed  [33:0]   xh_mul19;
reg     signed  [33:0]   xh_mul20;
reg     signed  [33:0]   xh_mul21;
reg     signed  [33:0]   xh_mul22;
reg     signed  [33:0]   xh_mul23;
reg     signed  [33:0]   xh_mul24;
reg     signed  [33:0]   xh_mul25;
reg     signed  [33:0]   xh_mul26;
reg     signed  [33:0]   xh_mul27;
reg     signed  [33:0]   xh_mul28;
reg     signed  [33:0]   xh_mul29;
reg     signed  [33:0]   xh_mul30;
reg     signed  [33:0]   xh_mul31;

/* always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)      
        begin
            xh_mul0  <= 34'b0;
            xh_mul1  <= 34'b0;
            xh_mul2  <= 34'b0;
            xh_mul3  <= 34'b0;
            xh_mul4  <= 34'b0;
            xh_mul5  <= 34'b0;
            xh_mul6  <= 34'b0;
            xh_mul7  <= 34'b0;
            xh_mul8  <= 34'b0;
            xh_mul9  <= 34'b0;
            xh_mul10 <= 34'b0;
            xh_mul11 <= 34'b0;
            xh_mul12 <= 34'b0;
            xh_mul13 <= 34'b0;
            xh_mul14 <= 34'b0;
            xh_mul15 <= 34'b0;
            xh_mul16 <= 34'b0;
            xh_mul17 <= 34'b0;
            xh_mul18 <= 34'b0;
            xh_mul19 <= 34'b0;
            xh_mul20 <= 34'b0;
            xh_mul21 <= 34'b0;
            xh_mul22 <= 34'b0;
            xh_mul23 <= 34'b0;
            xh_mul24 <= 34'b0;
            xh_mul25 <= 34'b0;
            xh_mul26 <= 34'b0;
            xh_mul27 <= 34'b0;
            xh_mul28 <= 34'b0;        
            xh_mul29 <= 34'b0;
            xh_mul30 <= 34'b0;
            xh_mul31 <= 34'b0;
        end
    else if(data_valid == 1'b1)                 //霿要被优化
        begin
            xh_mul0  <= x0  * h0 ;
            xh_mul1  <= x1  * h1 ;
            xh_mul2  <= x2  * h2 ;
            xh_mul3  <= x3  * h3 ;
            xh_mul4  <= x4  * h4 ;
            xh_mul5  <= x5  * h5 ;
            xh_mul6  <= x6  * h6 ;
            xh_mul7  <= x7  * h7 ;
            xh_mul8  <= x8  * h8 ;
            xh_mul9  <= x9  * h9 ;
            xh_mul10 <= x10 * h10;
            xh_mul11 <= x11 * h11;
            xh_mul12 <= x12 * h12;
            xh_mul13 <= x13 * h13;
            xh_mul14 <= x14 * h14;
            xh_mul15 <= x15 * h15;
            xh_mul16 <= x16 * h16;
            xh_mul17 <= x17 * h17;
            xh_mul18 <= x18 * h18;
            xh_mul19 <= x19 * h19;
            xh_mul20 <= x20 * h20;
            xh_mul21 <= x21 * h21;
            xh_mul22 <= x22 * h22;
            xh_mul23 <= x23 * h23;
            xh_mul24 <= x24 * h24;
            xh_mul25 <= x25 * h25;
            xh_mul26 <= x26 * h26;
            xh_mul27 <= x27 * h27;
            xh_mul28 <= x28 * h28;
            xh_mul29 <= x29 * h29;
            xh_mul30 <= x30 * h30;
            xh_mul31 <= x31 * h31;
        end */ 

wire     signed      [25:0]      xh_mul  [0:31];
genvar  q;
generate
    for(q = 0;q<32;q = q + 1)
        begin
            mult_x8_h10_p18_dis3  mult_x8_h10_p18_dis3_inst
            (
                .CLK  (sys_clk  ),           //IN STD_LOGIC                        
                .A    (x[q]     ),           //data,IN STD_LOGIC_VECTOR(23 DOWNTO 0)
                .B    (h[q]     ),           //coe,IN STD_LOGIC_VECTOR(9 DOWNTO 0)
                .P    (xh_mul[q])           //OUT STD_LOGIC_VECTOR(33 DOWNTO 0)
            );
        end
endgenerate

//step1:32个数据，每四个数据相加，第一个clk之后，会得到八个结果，这样是为了避免加法器太多导致的寄存器跳动太大进而导致出锿
reg     signed    [26:0]    xh_add[0:7];    
integer     jk;
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        for(jk = 0;jk < 8;jk = jk + 1)
            xh_add[jk] <= 0;
    else if(data_valid == 1'b1) 
        begin
            xh_add[0] <=  xh_mul[0 ] + xh_mul[1 ] + xh_mul[2 ] + xh_mul[3 ];
            xh_add[1] <=  xh_mul[4 ] + xh_mul[5 ] + xh_mul[6 ] + xh_mul[7 ]; 
            xh_add[2] <=  xh_mul[8 ] + xh_mul[9 ] + xh_mul[10] + xh_mul[11];
            xh_add[3] <=  xh_mul[12] + xh_mul[13] + xh_mul[14] + xh_mul[15];
            xh_add[4] <=  xh_mul[16] + xh_mul[17] + xh_mul[18] + xh_mul[19];
            xh_add[5] <=  xh_mul[20] + xh_mul[21] + xh_mul[22] + xh_mul[23];
            xh_add[6] <=  xh_mul[24] + xh_mul[25] + xh_mul[26] + xh_mul[27];
            xh_add[7] <=  xh_mul[28] + xh_mul[29] + xh_mul[30] + xh_mul[31];
        end
/*         xh_add <= xh_mul0  + xh_mul1  + xh_mul2  + xh_mul3  + xh_mul4  + xh_mul5  + xh_mul6  + xh_mul7  + 
                  xh_mul8  + xh_mul9  + xh_mul10 + xh_mul11 + xh_mul12 + xh_mul13 + xh_mul14 + xh_mul15 + 
                  xh_mul16 + xh_mul17 + xh_mul18 + xh_mul19 + xh_mul20 + xh_mul21 + xh_mul22 + xh_mul23 + 
                  xh_mul24 + xh_mul25 + xh_mul26 + xh_mul27 + xh_mul28 + xh_mul29 + xh_mul30 + xh_mul31;  */ 

//step2＿8个数据，每四个数据相加，第二个clk之后，会得到两个结果，这样是为了避免加法器太多导致的寄存器跳动太大进而导致出锿
reg     signed    [26:0]    xh_add0123, xh_add4567;    
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        begin
            xh_add0123 <= 0;
            xh_add4567 <= 0;
        end
    else if(data_valid == 1'b1) 
        begin
            xh_add0123 <=  xh_add[0] + xh_add[1] + xh_add[2] + xh_add[3];
            xh_add4567 <=  xh_add[4] + xh_add[5] + xh_add[6] + xh_add[7]; 
        end

//step3＿2个数据相势,第三个clk之后会得到最终的结果
reg     signed    [26:0]    xh_sum;    
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        begin
            xh_sum <= 0;
        end
    else if(data_valid == 1'b1) 
            xh_sum <=  xh_add0123 + xh_add4567;





reg     signed        [FIR_OUT - 1:0]       fir_out_reg;          
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)                  
        fir_out_reg <= 0;
    else if(data_valid == 1'b1)              
        fir_out_reg <= xh_sum[26:11];    
                  
reg     out_valid_r1;       //第一个延时
reg     out_valid_r2;       //第二个延时          
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0) 
        begin
            out_valid_r1 <= 1'b0;
            out_valid_r2 <= 1'b0;  
        end
    else             
        begin
            out_valid_r1 <= data_valid  ;
            out_valid_r2 <= out_valid_r1;
        end
                  
assign  fir_out = (data_valid == 1'b1)?fir_out_reg:fir_out;                  
assign  fir_out_valid = out_valid_r2;                
                  
endmodule                    
                             
           