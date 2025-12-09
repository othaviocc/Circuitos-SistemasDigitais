library ieee;
use ieee.std_logic_1164.all;

entity multiplexador is
    port(
        i_w   : in std_logic;
		  i_ff : in std_logic_vector(7 downto 0);
        o_saida : out std_logic_vector(7 downto 0)
    );
end entity;

architecture comportamental of multiplexador is
begin
    o_saida <= i_ff when i_w = '0' else "00000000";
end architecture;