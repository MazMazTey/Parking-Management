module TB_Parking ();
    reg clk;
    reg start;
    reg car_entered;
    reg is_uni_car_entered;
    reg car_exited;
    reg is_uni_car_exited;
    wire [15:0] uni_car_parked;
    wire [15:0] parked_care;
    wire [15:0] uni_vacated_space;
    wire [15:0] vacated_space;
    wire uni_is_vacated_space;
    wire is_vacated_space;
    wire [11:0] clock_time;

    Parking parking(
        .clk(clk),
        .start(start),
        .car_entered(car_entered),
        .is_uni_car_entered(is_uni_car_entered),
        .car_exited(car_exited),
        .is_uni_car_exited(is_uni_car_exited),
        .uni_car_parked(uni_car_parked),
        .parked_care(parked_care),
        .uni_vacated_space(uni_vacated_space),
        .vacated_space(vacated_space),
        .uni_is_vacated_space(uni_is_vacated_space),
        .is_vacated_space(is_vacated_space),
        .clock_time(clock_time)
    );

    initial begin
        clk <= 0;
        start <= 0;
        car_entered <= 0;
        car_exited <= 0;
        is_uni_car_entered <= 0;
        is_uni_car_exited <= 0;
    end

    always begin
        #5 clk <= ~clk;
    end

    initial begin
        #12;
        start = 1;
        #100;
        car_entered <= 1;
        is_uni_car_entered = 0;
        #1;
        car_entered = 0;
        #30;
        car_entered <= 1;
        is_uni_car_entered = 1;
        #1;
        car_entered = 0;
        #30;
        car_entered <= 1;
        is_uni_car_entered = 1;
        #1;
        car_entered = 0;
        #30;
        car_exited <= 1;
        is_uni_car_exited = 0;
        #1;
        car_exited = 0;
        #30;
        car_entered <= 1;
        is_uni_car_entered = 0;
        #1;
        car_entered = 0;
        #30;
        car_exited <= 1;
        is_uni_car_exited = 1;
        #1;
        car_exited = 0;
        #300;
        $stop();
    end

    initial begin
        $monitor("clock time: ", clock_time ," car entered: ", car_entered, " car exited: ", car_exited,
        " uni car parked: ", $signed(uni_car_parked), " parked care: ", $signed(parked_care),
         " uni vacated space: ", $signed(uni_vacated_space), " vacated space: ", $signed(vacated_space));
    end
endmodule
