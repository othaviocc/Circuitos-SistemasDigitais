library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decodificador_display is
    port (
        i_clk     : in  std_logic;
        i_reset   : in  std_logic;
        i_binario : in  std_logic_vector(7 downto 0);
        o_segmentos : out std_logic_vector(6 downto 0); -- g,f,e,d,c,b,a
        
        o_anodos    : out std_logic_vector(3 downto 0)
    );
end entity;

architecture comportamental of decodificador_display is

    component bin_to_bcd
        port (
            i_binario : in  std_logic_vector(7 downto 0);
            o_bcd_h   : out std_logic_vector(3 downto 0);
            o_bcd_t   : out std_logic_vector(3 downto 0);
            o_bcd_u   : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component bcd_to_7seg
        port (
            i_bcd : in  std_logic_vector(3 downto 0);
            o_seg : out std_logic_vector(6 downto 0)
        );
    end component;

    signal s_bcd_h, s_bcd_t, s_bcd_u : std_logic_vector(3 downto 0);
    signal s_seg_h, s_seg_t, s_seg_u : std_logic_vector(6 downto 0);
    
    signal s_refresh_count : unsigned(17 downto 0); 
    signal s_digit_select  : unsigned(2 downto 0);
    
begin

    inst_bin_to_bcd: bin_to_bcd
        port map (
            i_binario => i_binario,
            o_bcd_h   => s_bcd_h,
            o_bcd_t   => s_bcd_t,
            o_bcd_u   => s_bcd_u
        );
        
    inst_seg_h: bcd_to_7seg port map (i_bcd => s_bcd_h, o_seg => s_seg_h);
    inst_seg_t: bcd_to_7seg port map (i_bcd => s_bcd_t, o_seg => s_seg_t);
    inst_seg_u: bcd_to_7seg port map (i_bcd => s_bcd_u, o_seg => s_seg_u);
    
    process(i_clk, i_reset)
    begin
        if i_reset = '1' then
            s_refresh_count <= (others => '0');
            s_digit_select  <= (others => '0');
        elsif rising_edge(i_clk) then
            s_refresh_count <= s_refresh_count + 1;
            
            if s_refresh_count(10) = '1' then 
                s_refresh_count <= (others => '0');
                if s_digit_select = 2 then
                    s_digit_select <= (others => '0');
                else
                    s_digit_select <= s_digit_select + 1;
                end if;
            end if;
        end if;
    end process;

    process(s_digit_select, s_seg_h, s_seg_t, s_seg_u)
    begin
        case s_digit_select is
            when "00" =>  -- unidade
                o_segmentos <= s_seg_u;  -- 0 acende
                o_anodos    <= "1110";   -- AN0 ligado 
            when "01" =>  -- dezena
                o_segmentos <= s_seg_t;
                o_anodos    <= "1101";   -- AN1 ligado
            when "10" =>  -- centena
                o_segmentos <= s_seg_h;
                o_anodos    <= "1011";   -- AN2 ligado
            when others =>
                o_segmentos <= "1111111"; -- tudo apagado
                o_anodos    <= "1111";    -- todos desligados
        end case;
    end process;
end architecture;