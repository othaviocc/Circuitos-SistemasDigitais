library ieee;
use ieee.std_logic_1164.all;

entity bcd_to_7seg is
    port (
        i_bcd : in  std_logic_vector(3 downto 0);
        o_seg : out std_logic_vector(6 downto 0)
    );
end entity;

architecture lookup_table of bcd_to_7seg is
begin
    process(i_bcd)
    begin
        case i_bcd is
            when "0000" => o_seg <= "1000000"; -- '0' 
            when "0001" => o_seg <= "1111001"; -- '1' 
            when "0010" => o_seg <= "0100100"; -- '2'
            when "0011" => o_seg <= "0110000"; -- '3'
            when "0100" => o_seg <= "0011001"; -- '4'
            when "0101" => o_seg <= "0010010"; -- '5'
            when "0110" => o_seg <= "0000010"; -- '6'
            when "0111" => o_seg <= "1111000"; -- '7'
            when "1000" => o_seg <= "0000000"; -- '8' 
            when "1001" => o_seg <= "0010000"; -- '9'
            when others => o_seg <= "1111111"; -- Apagado
        end case;
    end process;
end architecture;