library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin_to_bcd is
    port (
        i_binario : in  std_logic_vector(7 downto 0);
        o_bcd_h   : out std_logic_vector(3 downto 0); --cent
        o_bcd_t   : out std_logic_vector(3 downto 0); --dez
        o_bcd_u   : out std_logic_vector(3 downto 0)  --unid
    );
end entity;

architecture combinacional of bin_to_bcd is
begin

    process(i_binario)
        variable v_bcd : std_logic_vector(11 downto 0);
        variable v_bin : std_logic_vector(7 downto 0);
    begin
        v_bcd := (others => '0');
        v_bin := i_binario;

        for i in 0 to 7 loop            
            if unsigned(v_bcd(3 downto 0)) > 4 then
                v_bcd(3 downto 0) := std_logic_vector(unsigned(v_bcd(3 downto 0)) + 3);
            end if;
            
            if unsigned(v_bcd(7 downto 4)) > 4 then
                v_bcd(7 downto 4) := std_logic_vector(unsigned(v_bcd(7 downto 4)) + 3);
            end if;
            
            if unsigned(v_bcd(11 downto 8)) > 4 then
                v_bcd(11 downto 8) := std_logic_vector(unsigned(v_bcd(11 downto 8)) + 3);
            end if;

            v_bcd(11 downto 1) := v_bcd(10 downto 0); 
            v_bcd(0) := v_bin(7);       
            v_bin(7 downto 1) := v_bin(6 downto 0);   
            v_bin(0) := '0';                 
            
        end loop;

        o_bcd_h <= v_bcd(11 downto 8);
        o_bcd_t <= v_bcd(7 downto 4);
        o_bcd_u <= v_bcd(3 downto 0);
        
    end process;
end architecture;