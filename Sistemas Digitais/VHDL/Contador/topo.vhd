library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity topo is
    port(
        i_clk, i_reset, i_display : in std_logic;
        o_saida : out std_logic_vector(6 downto 0)
    );
end entity; 

architecture estrutural of topo is

    signal s_contador : std_logic_vector(3 downto 0); 

begin
    u_cont : entity work.contador
        port map(
            i_clk   => i_clk, 
            i_reset => i_reset,
            o_saida => s_contador
        ); 

    u_decod : entity work.toplevel
        port map(
            i_binario       => s_contador, 
            i_display       => i_display,
            o_saida_display => o_saida
        ); 

end architecture;