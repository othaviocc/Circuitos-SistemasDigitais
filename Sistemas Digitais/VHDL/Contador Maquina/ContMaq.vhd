library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ContMaq is
    port(
        i_clk   : in std_logic;
        i_reset : in std_logic;
        o_saida : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behav of ContMaq is
	type estado is (s_0, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15);
	signal estado_atual, proximo_estado : estado;
	
begin
		
	 sequencial : process(i_clk,i_reset)

	 begin 
			if(i_reset = '1') then
				estado_atual <= s_0;
			elsif(rising_edge(i_clk)) then
				estado_atual <= proximo_estado;
			end if;
	 end process;
    processo_contar : process(estado_atual)
    begin
		
		case estado_atual is
			when s_0 =>
						o_saida <= "0000";
						proximo_estado <= s_1;
			when s_1 =>
						o_saida <= "0001";
						proximo_estado <= s_2;					
			when s_2 =>
						o_saida <= "0010";
						proximo_estado <= s_3;						
			when s_3 =>
						o_saida <= "0011";
						proximo_estado <= s_4;
			when s_4 =>
						o_saida <= "0100";
						proximo_estado <= s_5;						
			when s_5 =>
						o_saida <= "0101";
						proximo_estado <= s_6;						
			when s_6 =>
						o_saida <= "0110";
						proximo_estado <= s_7;						
			when s_7 =>
						o_saida <= "0111";
						proximo_estado <= s_8;						
			when s_8 =>
						o_saida <= "1000";
						proximo_estado <= s_9;						
			when s_9 =>
						o_saida <= "1001";
						proximo_estado <= s_10;					
			when s_10 =>
						o_saida <= "1010";
						proximo_estado <= s_11;			
			when s_11 =>
						o_saida <= "1011";
						proximo_estado <= s_12;						
			when s_12 =>
						o_saida <= "1100";
						proximo_estado <= s_13;						
			when s_13 =>
						o_saida <= "1101";
						proximo_estado <= s_14;			
			when s_14 =>
						o_saida <= "1110";
						proximo_estado <= s_15;						
			when s_15 =>
						o_saida <= "1111";
						proximo_estado <= s_0;			
			when others =>
						o_saida <= "0000";
						proximo_estado <= s_0;
		end case;		
    end process;
end architecture;