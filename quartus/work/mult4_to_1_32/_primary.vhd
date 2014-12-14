library verilog;
use verilog.vl_types.all;
entity mult4_to_1_32 is
    port(
        \out\           : out    vl_logic_vector(31 downto 0);
        i0              : in     vl_logic_vector(31 downto 0);
        i1              : in     vl_logic_vector(31 downto 0);
        i2              : in     vl_logic_vector(31 downto 0);
        i3              : in     vl_logic_vector(31 downto 0);
        s1              : in     vl_logic;
        s0              : in     vl_logic
    );
end mult4_to_1_32;
