module Parking(
    input start,
    input clk,
    input car_entered,
    input is_uni_car_entered,
    input car_exited,
    input is_uni_car_exited,
    output reg [15:0] uni_car_parked,
    output reg [15:0] parked_care,
    output reg [15:0] uni_vacated_space,
    output reg [15:0] vacated_space,
    output reg uni_is_vacated_space,
    output reg is_vacated_space,
    output wire [11:0] clock_time
);
    integer MAX_CAP_PARKING = 700;
    integer MAX_CAP_UNI;
    integer MAX_CAP_GENERAL;

    Clock clock (
        .clk(clk),
        .start(start),
        .clock_time(clock_time)
    );

    always @(car_entered or car_exited or start or clock_time) begin
        if (clock_time < 8) begin
            MAX_CAP_UNI = 0;
            MAX_CAP_GENERAL = 0;
        end
        else if (clock_time < 13) begin
            MAX_CAP_UNI = 500;
            MAX_CAP_GENERAL = 200;
        end
        else if (clock_time < 14) begin
            MAX_CAP_UNI = 450;
            MAX_CAP_GENERAL = 250;
        end
        else if (clock_time < 15) begin
            MAX_CAP_UNI = 400;
            MAX_CAP_GENERAL = 300;
        end
        else if (clock_time < 16) begin
            MAX_CAP_UNI = 350;
            MAX_CAP_GENERAL = 350;
        end
        else begin
            MAX_CAP_UNI = 200;
            MAX_CAP_GENERAL = 500;
        end
        if (~start) begin
            uni_car_parked <= 0;
            parked_care <= 0;
            uni_vacated_space <= MAX_CAP_UNI;
            vacated_space <= MAX_CAP_GENERAL;
            uni_is_vacated_space <= 1'b1;
            is_vacated_space <= 1'b1;
        end
        else if (start) begin 
            vacated_space = MAX_CAP_GENERAL - parked_care;
            uni_vacated_space = MAX_CAP_UNI - uni_car_parked;
            if (car_entered) begin                                  //check if car entered
                if (parked_care + uni_car_parked < MAX_CAP_PARKING) begin     
                    if (is_uni_car_entered) begin                       //check if it is uni car
                        if (uni_is_vacated_space && $signed(uni_vacated_space) >= 1) begin                 //check if there is any empty space
                            uni_car_parked = uni_car_parked + 1;
                            uni_vacated_space = MAX_CAP_UNI - uni_car_parked;
                            if (uni_car_parked >= MAX_CAP_UNI) begin    //check if the uni cap is full
                                uni_is_vacated_space = 1'b0;
                            end
                        end
                    end
                    else begin
                        if (is_vacated_space && $signed(vacated_space) >= 1) begin                     //check for general cars
                            parked_care = parked_care + 1;
                            vacated_space = MAX_CAP_GENERAL - parked_care;
                            if (parked_care >= MAX_CAP_GENERAL) begin
                                is_vacated_space = 1'b0;
                            end
                        end
                    end
                end
            end
            else if (car_exited) begin                             //check if car exited
                if (is_uni_car_exited) begin                       //check if it is uni car
                    if (uni_car_parked > 0) begin    
                        uni_car_parked = uni_car_parked - 1;
                        uni_vacated_space <= MAX_CAP_UNI - uni_car_parked;
                        if (!uni_is_vacated_space) begin                //check if the uni cap is full
                            uni_is_vacated_space = 1'b1;
                        end
                    end
                end
                else begin                                          //check for general cars
                    if (parked_care > 0) begin
                        parked_care = parked_care - 1;
                        vacated_space <= MAX_CAP_GENERAL - parked_care;
                        if (!is_vacated_space) begin
                            is_vacated_space = 1'b1;
                        end
                    end
                end
            end
        end
    end
    
endmodule
