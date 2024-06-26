library verilog;
use verilog.vl_types.all;
entity Parking is
    port(
        start           : in     vl_logic;
        clk             : in     vl_logic;
        car_entered     : in     vl_logic;
        is_uni_car_entered: in     vl_logic;
        car_exited      : in     vl_logic;
        is_uni_car_exited: in     vl_logic;
        uni_car_parked  : out    vl_logic_vector(15 downto 0);
        parked_care     : out    vl_logic_vector(15 downto 0);
        uni_vacated_space: out    vl_logic_vector(15 downto 0);
        vacated_space   : out    vl_logic_vector(15 downto 0);
        uni_is_vacated_space: out    vl_logic;
        is_vacated_space: out    vl_logic;
        clock_time      : out    vl_logic_vector(11 downto 0)
    );
end Parking;
