library ieee;
use ieee.std_logic_1164.all;

entity memoria is
    port(
        i_w, i_coluna, i_linha, i_reset, i_clock  : in std_logic;
		  i_d : in std_logic_vector(7 downto 0);
        o_saida : out std_logic_vector(7 downto 0)
    );
end entity;

architecture comportamental of memoria is

	 --decodificador
	 component decodificador
			port(
				i_entrada   : in std_logic;
				o_saida : out std_logic_vector(1 downto 0)
			);
	 end component;
	 signal o_linha, o_coluna: std_logic_vector(1 downto 0);
	 
	 --multiplexador
	 component multiplexador
			port(
				i_w   : in std_logic;
				i_ff : in std_logic_vector(7 downto 0);
				o_saida : out std_logic_vector(7 downto 0)
			);
	 end component;

	--flipflop 8 bits
	 component flipflopD_8bits
    port(
      o_Q : out std_logic_vector(7 downto 0);    
      i_Clk, i_Rst, i_w, i_sx, i_sy : in std_logic;
      i_D : in std_logic_vector(7 downto 0)
		);
	 end component;
	 signal s_q0, s_q1, s_q2, s_q3 : std_logic_vector(7 downto 0);
	 signal s_or1, s_or2, s_or3 : std_logic_vector(7 downto 0);
	
begin
	decodificador_line: decodificador port map(i_entrada => i_linha, o_saida=>o_linha);
	decodificador_col: decodificador port map(i_entrada=> i_coluna, o_saida=>o_coluna);
	
	ff0: flipflopD_8bits port map(i_D=>i_d, i_Clk=>i_clock, i_Rst=>i_reset, o_Q=> s_q0, i_w=> i_w, i_sx=> o_linha(0),i_sy=> o_coluna(0));
	ff1: flipflopD_8bits port map(i_D=>i_d, i_Clk=>i_clock, i_Rst=>i_reset, o_Q=> s_q1, i_w=> i_w, i_sx=> o_linha(0),i_sy=> o_coluna(1));
	ff2: flipflopD_8bits port map(i_D=>i_d, i_Clk=>i_clock, i_Rst=>i_reset, o_Q=> s_q2, i_w=> i_w, i_sx=> o_linha(1),i_sy=> o_coluna(0));
	ff3: flipflopD_8bits port map(i_D=>i_d, i_Clk=>i_clock, i_Rst=>i_reset, o_Q=> s_q3, i_w=> i_w, i_sx=> o_linha(1),i_sy=> o_coluna(1));
	
	s_or1 <= s_q0 or s_q2;
	s_or2 <= s_q1 or s_q3;
	s_or3 <= s_or1 or s_or2;
	
	mux : multiplexador port map(i_w=> i_w, i_ff=> s_or3, o_saida=> o_saida);
	
end architecture;