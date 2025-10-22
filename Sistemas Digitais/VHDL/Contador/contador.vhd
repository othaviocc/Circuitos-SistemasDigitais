library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
    port(
        i_clk   : in std_logic;
        i_reset : in std_logic;
        o_saida : out std_logic_vector(3 downto 0)
    );
end entity; 

architecture comportamental of contador is
    
begin
    processo_cont : process(i_clk, i_reset)
        variable contador : integer range 0 to 15 := 0; 
    begin
        if (i_reset = '1') then 
            contador := 0; 
        elsif rising_edge(i_clk) then 
            if contador = 15 then --Se atingir 15
                contador := 0;     
            else
                contador := contador + 1; 
            end if;
        end if;

        o_saida <= std_logic_vector(to_unsigned(contador, 4)); 
    end process;
end architecture;