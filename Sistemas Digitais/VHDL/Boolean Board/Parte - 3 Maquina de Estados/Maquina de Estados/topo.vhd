library ieee;
use ieee.std_logic_1164.all;

entity topo is
    port(
        i_clock : in std_logic;
        i_reset : in std_logic;
        
        -- Display Esquerdo (Escrita)
        o_seg_esq : out std_logic_vector(7 downto 0);
        o_an_esq : out std_logic_vector(3 downto 0);
        
        -- Display Direito (Memoria)
        o_seg_dir : out std_logic_vector(7 downto 0);
        o_an_dir : out std_logic_vector(3 downto 0);
        
        o_led_rgb : out std_logic_vector(2 downto 0)
    );
end entity;
		
architecture comportamental of topo is
    component memoria
        port(i_w, i_coluna, i_linha, i_reset, i_clock: in std_logic; i_d: in std_logic_vector(7 downto 0); o_saida: out std_logic_vector(7 downto 0));
    end component;

    component maquina_de_estados
        port(i_clk, i_reset: in std_logic; o_w, o_linha, o_coluna: out std_logic; o_d: out std_logic_vector(7 downto 0); o_rst_mem: out std_logic; o_val_display_write: out std_logic_vector(7 downto 0); o_rgb: out std_logic_vector(2 downto 0));
    end component;

    component decodificador_display
        port (
            i_clk, i_reset : in std_logic;
            i_val_mem, i_val_write : in std_logic_vector(7 downto 0);
            o_seg_esq : out std_logic_vector(7 downto 0);
            o_an_esq : out std_logic_vector(3 downto 0);
            o_seg_dir : out std_logic_vector(7 downto 0);
            o_an_dir : out std_logic_vector(3 downto 0)
        );
    end component;

    signal s_w, s_linha, s_coluna, s_rst_mem : std_logic;
    signal s_d_mem, s_mem_out, s_val_write : std_logic_vector(7 downto 0);
    signal s_rgb : std_logic_vector(2 downto 0);

begin
    inst_fsm: maquina_de_estados port map(i_clock, i_reset, s_w, s_linha, s_coluna, s_d_mem, s_rst_mem, s_val_write, s_rgb);
    inst_memoria: memoria port map(s_w, s_coluna, s_linha, s_rst_mem, i_clock, s_d_mem, s_mem_out);
    
    inst_display: decodificador_display port map(
            i_clk => i_clock, i_reset => i_reset,
            i_val_mem => s_mem_out, i_val_write => s_val_write,
            o_seg_esq => o_seg_esq, o_an_esq => o_an_esq,
            o_seg_dir => o_seg_dir, o_an_dir => o_an_dir
        );
    o_led_rgb <= s_rgb;
end architecture;