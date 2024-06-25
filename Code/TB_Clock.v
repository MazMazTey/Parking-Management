module TB_Clock ();
    reg start;
    reg clk;
    wire [11:0] clock_time;

    Clock clock (
        .clk(clk),
        .start(start),
        .clock_time(clock_time)
    );

    initial begin
        clk <= 0;
    end

    always begin
        #1 clk = ~clk;
    end

    initial begin
        start <= 0;
        #10;
        start <= 1;
        #10000;
        $stop();
    end

    initial begin
        $monitor("Time: ", $time, " clock time: ", clock_time);
    end
endmodule
