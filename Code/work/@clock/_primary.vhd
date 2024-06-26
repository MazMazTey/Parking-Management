library verilog;
use verilog.vl_types.all;
entity Clock is
    port(
        start           : in     vl_logic;
        clk             : in     vl_logic;
        clock_time      : out    vl_logic_vector(11 downto 0)
    );
end Clock;
