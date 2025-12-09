library ieee;
use ieee.std_logic_1164.all;

entity topo is
    port(
        i_w, i_coluna, i_linha, i_reset, i_clock  : in std_logic;
		  i_d : in std_logic_vector(7 downto 0);
        o_anodos : out std_logic_vector(3 downto 0);
        o_segmentos : out std_logic_vector(6 downto 0)
    );
end entity;
		
architecture comportamental of topo is

    component memoria
        port(
            i_w, i_coluna, i_linha, i_reset, i_clock : in std_logic;
            i_d: in std_logic_vector(7 downto 0);
            o_saida: out std_logic_vector(7 downto 0)
        );
    end component;

    component decodificador_display
        port (
            i_clk      : in  std_logic;
            i_reset    : in  std_logic;
            i_binario  : in  std_logic_vector(7 downto 0);
            o_anodos   : out std_logic_vector(3 downto 0);
            o_segmentos: out std_logic_vector(6 downto 0)
        );
    end component;
	 
    signal s_mem_out : std_logic_vector(7 downto 0);

begin
    inst_memoria: memoria
        port map(
            i_w      => i_w,
            i_coluna => i_coluna,
            i_linha  => i_linha,
            i_reset  => i_reset,
            i_clock  => i_clock,
            i_d      => i_d,
            o_saida  => s_mem_out);

    inst_display: decodificador_display
        port map(
            i_clk      => i_clock,
            i_reset    => i_reset,
            i_binario  => s_mem_out,
            o_anodos   => o_anodos,
            o_segmentos=> o_segmentos
        );

end architecture;