library ieee;
use ieee.std_logic_1164.all;

--FlipFlop D de 1 bit
entity ff_d_1bit is
    port (
        D     : in  std_logic; 
        CLK   : in  std_logic; 
        RESET : in  std_logic; 
        Q     : out std_logic  
    );
end entity ff_d_1bit;

architecture BEHAVIORAL of ff_d_1bit is
begin
    ff_process : process (CLK, RESET)
    begin
        if (RESET = '1') then
            Q <= '0';
        elsif rising_edge(CLK) then
            Q <= D;
        end if;
    end process ff_process;
end architecture BEHAVIORAL;