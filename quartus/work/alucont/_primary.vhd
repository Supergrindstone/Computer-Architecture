library verilog;
use verilog.vl_types.all;
entity alucont is
    port(
        aluop1          : in     vl_logic;
        aluop0          : in     vl_logic;
        f3              : in     vl_logic;
        f2              : in     vl_logic;
        f1              : in     vl_logic;
        f0              : in     vl_logic;
        gout            : out    vl_logic_vector(2 downto 0)
    );
end alucont;
