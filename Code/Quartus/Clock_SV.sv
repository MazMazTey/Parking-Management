module Clock (
    input start,
    input clk,
    output reg [11:0] clock_time
);
    reg [12:0] counter;
    always @(posedge clk) begin
        if (~start) begin
            clock_time <= 0;
            counter <= 0;
        end
        else begin
            if (counter >= 60) begin
                clock_time <= clock_time + 1;
                counter <= 0;
            end
            if (clock_time >= 23) begin
                clock_time <= 0;
            end
            else begin
                counter <= counter + 30;
            end
        end
    end
    
endmodule
