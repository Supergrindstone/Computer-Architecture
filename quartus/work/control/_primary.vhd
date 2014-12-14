library verilog;
use verilog.vl_types.all;
entity control is
    port(
        \in\            : in     vl_logic_vector(5 downto 0);
        regdest         : out    vl_logic;
        alusrc          : out    vl_logic;
        memtoreg        : out    vl_logic;
        regwrite        : out    vl_logic;
        memread         : out    vl_logic;
        memwrite        : out    vl_logic;
        branch          : out    vl_logic;
        aluop0          : out    vl_logic;
        aluop1          : out    vl_logic;
        Pcsource1       : out    vl_logic;
        Pcsource2       : out    vl_logic;
        JumpNotZero     : out    vl_logic;
        Flageski        : out    vl_logic;
        bgtz            : out    vl_logic;
        Link            : out    vl_logic;
        ori             : out    vl_logic;
        jump            : out    vl_logic;
        Link2           : out    vl_logic
    );
end control;
