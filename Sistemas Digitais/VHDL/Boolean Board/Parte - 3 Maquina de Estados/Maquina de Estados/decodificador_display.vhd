library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decodificador_display is
    port (
        i_clk : in  std_logic;
        i_reset : in  std_logic;
        
        i_val_mem : in  std_logic_vector(7 downto 0);
        i_val_write : in  std_logic_vector(7 downto 0);
        
        o_seg_esq : out std_logic_vector(7 downto 0);
        o_an_esq : out std_logic_vector(3 downto 0);
        
        o_seg_dir : out std_logic_vector(7 downto 0);
        o_an_dir : out std_logic_vector(3 downto 0)
    );
end entity;

architecture comportamental of decodificador_display is

    component bin_to_bcd
        port (i_binario : in std_logic_vector(7 downto 0); o_bcd_h, o_bcd_t, o_bcd_u : out std_logic_vector(3 downto 0));
    end component;
    
    component bcd_to_7seg
        port (i_bcd : in std_logic_vector(3 downto 0); o_seg : out std_logic_vector(6 downto 0));
    end component;

    -- Sinais MEMORIA (Direita)
    signal s_mem_h, s_mem_t, s_mem_u : std_logic_vector(3 downto 0);
    signal s_seg_mem_h, s_seg_mem_t, s_seg_mem_u : std_logic_vector(6 downto 0);

    -- Sinais ESCRITA (Esquerda)
    signal s_write_h, s_write_t, s_write_u : std_logic_vector(3 downto 0);
    signal s_seg_write_h, s_seg_write_t, s_seg_write_u : std_logic_vector(6 downto 0);

    signal s_refresh_count : unsigned(16 downto 0); 
    signal s_digit_select : unsigned(1 downto 0); -- 0 a 3 (sincronizado para ambos)

begin
    -- Conversores
    bcd_mem: bin_to_bcd port map (i_val_mem, s_mem_h, s_mem_t, s_mem_u);
    seg_mem_h: bcd_to_7seg port map (s_mem_h, s_seg_mem_h);
    seg_mem_t: bcd_to_7seg port map (s_mem_t, s_seg_mem_t);
    seg_mem_u: bcd_to_7seg port map (s_mem_u, s_seg_mem_u);

    bcd_write: bin_to_bcd port map (i_val_write, s_write_h, s_write_t, s_write_u);
    seg_write_h: bcd_to_7seg port map (s_write_h, s_seg_write_h);
    seg_write_t: bcd_to_7seg port map (s_write_t, s_seg_write_t);
    seg_write_u: bcd_to_7seg port map (s_write_u, s_seg_write_u);

    process(i_clk, i_reset)
    begin
        if i_reset = '1' then
            s_refresh_count <= (others => '0');
            s_digit_select <= (others => '0');
        elsif rising_edge(i_clk) then
            s_refresh_count <= s_refresh_count + 1;
            if s_refresh_count(16) = '1' then
                s_refresh_count <= (others => '0');
                s_digit_select <= s_digit_select + 1;
            end if;
        end if;
    end process;

    process(s_digit_select, s_seg_mem_u, s_seg_mem_t, s_seg_mem_h, s_seg_write_u, s_seg_write_t, s_seg_write_h)
    begin
        o_an_esq <= "1111"; o_seg_esq <= "11111111";
        o_an_dir <= "1111"; o_seg_dir <= "11111111";

        case s_digit_select is
            when "00" => -- Unidades
                o_seg_esq(6 downto 0) <= s_seg_write_u; 
                o_an_esq <= "1110"; 
                o_seg_dir(6 downto 0) <= s_seg_mem_u;
                o_an_dir <= "1110"; 
                
            when "01" => -- Dezenas
                o_seg_esq(6 downto 0) <= s_seg_write_t; 
                o_an_esq <= "1101";
                o_seg_dir(6 downto 0) <= s_seg_mem_t;
                o_an_dir <= "1101";

            when "10" => -- Centenas
                o_seg_esq(6 downto 0) <= s_seg_write_h; 
                o_an_esq <= "1011";
                o_seg_dir(6 downto 0) <= s_seg_mem_h;
                o_an_dir <= "1011";

            when others => 
                o_an_esq <= "0111"; o_seg_esq <= "11111111";
                o_an_dir <= "0111"; o_seg_dir <= "11111111";
        end case;
    end process;
end architecture;