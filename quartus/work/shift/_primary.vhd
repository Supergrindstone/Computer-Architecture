library verilog;
use verilog.vl_types.all;
entity shift is
    port(
        shout           : out    vl_logic_vector(31 downto 0);
        shin            : in     vl_logic_vector(31 downto 0)
    );
end shift;
