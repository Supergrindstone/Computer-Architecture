library verilog;
use verilog.vl_types.all;
entity alu32 is
    port(
        sum             : out    vl_logic_vector(31 downto 0);
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        shamt           : in     vl_logic_vector(4 downto 0);
        flag            : out    vl_logic_vector(1 downto 0);
        gin             : in     vl_logic_vector(2 downto 0)
    );
end alu32;
