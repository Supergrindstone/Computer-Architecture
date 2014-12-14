library verilog;
use verilog.vl_types.all;
entity mult2_to_1_5 is
    port(
        \out\           : out    vl_logic_vector(4 downto 0);
        i0              : in     vl_logic_vector(4 downto 0);
        i1              : in     vl_logic_vector(4 downto 0);
        s0              : in     vl_logic
    );
end mult2_to_1_5;
