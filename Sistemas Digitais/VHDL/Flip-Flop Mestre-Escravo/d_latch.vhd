library ieee;
use ieee.std_logic_1164.all;

entity d_latch is
    port (
        D  : in  std_logic; 
        EN : in  std_logic; 
        Q  : out std_logic  
    );
end entity d_latch;

architecture BEHAVIORAL of d_latch is
begin
    process(D, EN)
    begin
        if (EN = '1') then
            Q <= D;
        end if;
    end process;
end architecture BEHAVIORAL;