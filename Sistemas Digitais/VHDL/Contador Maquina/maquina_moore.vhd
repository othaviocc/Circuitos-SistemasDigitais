library ieee;
use ieee.std_logic_1164.all;

entity maquina_moore is
  generic (N : integer := 8);
  port (
    i_clk, i_rst, i_w : in std_logic;
    o_saida : out std_logic
  );

end maquina_moore;

architecture behv of maquina_moore is

	type estado is (A, B, C, D);
	signal estado_atual, proximo_estado : estado;

begin

	sequencial : process(i_rst, i_clk)
	begin
	
	if(i_rst = '1') then
		estado_atual <= A;
	elsif(rising_edge(i_clk)) then
		estado_atual <= proximo_estado;
	end if;
	
	end process;
	
	
	combinacional : process(estado_atual, proximo_estado)
	begin
		case estado_atual is
			when A =>
					o_saida <= '0';
					if(i_w = '1') then
						proximo_estado <= B;
					else
						proximo_estado <= A;
					end if;
			when B =>
					o_saida <= '0';
					if(i_w = '1') then
						proximo_estado <= C;
					else
						proximo_estado <= A;
					end if;
			when C =>
					o_saida <= '0';
					if(i_w = '1') then
						proximo_estado <= D;
					else
						proximo_estado <= A;
					end if;
			when D =>
					o_saida <= '1';
					if(i_w = '1') then
						proximo_estado <= D;
					else
						proximo_estado <= A;
					end if;
			when others =>
					o_saida <= '0';
					proximo_estado <= A;
		end case;
	
	end process;

end behv;