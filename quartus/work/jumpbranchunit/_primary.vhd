library verilog;
use verilog.vl_types.all;
entity jumpbranchunit is
    port(
        flagyeni        : in     vl_logic_vector(1 downto 0);
        flageski        : in     vl_logic_vector(1 downto 0);
        flageskikullanma: in     vl_logic;
        JumpNotZero     : in     vl_logic;
        Bgtz            : in     vl_logic;
        jump            : in     vl_logic;
        branch          : in     vl_logic;
        pcsource1       : in     vl_logic;
        pcsource2       : in     vl_logic;
        pcsourceout1    : out    vl_logic;
        pcsourceout2    : out    vl_logic
    );
end jumpbranchunit;
