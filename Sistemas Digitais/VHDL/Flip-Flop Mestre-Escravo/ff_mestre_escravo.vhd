library ieee;
use ieee.std_logic_1164.all;

entity ff_mestre_escravo is
    port (
        D    : in  std_logic;  
        CLK  : in  std_logic;  --Clock
        Q    : out std_logic;  
        Qn   : out std_logic   
    );
end entity ff_mestre_escravo;

architecture ESTRUTURAL of ff_mestre_escravo is

    component d_latch is
        port (
            D  : in  std_logic;
            EN : in  std_logic;
            Q  : out std_logic
        );
    end component d_latch;
    
    signal clk_n    : std_logic; 
    signal master_q : std_logic; 

begin

    clk_n <= not CLK;

    u_mestre : d_latch
        port map (
            D  => D,
            EN => clk_n,
            Q  => master_q
        );
        
    u_escravo : d_latch
        port map (
            D  => master_q,
            EN => CLK,
            Q  => Q
        );
        
    Qn <= not Q;

end architecture ESTRUTURAL;