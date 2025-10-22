library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rca_4bit is
    Port ( A    : in  STD_LOGIC_VECTOR(3 downto 0);
           B    : in  STD_LOGIC_VECTOR(3 downto 0);
           Cin  : in  STD_LOGIC;
           S    : out STD_LOGIC_VECTOR(3 downto 0);
           Cout : out STD_LOGIC);
end rca_4bit;

architecture Structural of rca_4bit is
    component full_adder_1bit is
        Port ( A    : in  STD_LOGIC;
               B    : in  STD_LOGIC;
               Cin  : in  STD_LOGIC;
               S    : out STD_LOGIC;
               Cout : out STD_LOGIC);
    end component;

    signal C_carry : STD_LOGIC_VECTOR(3 downto 1);

begin
    FA0: full_adder_1bit port map (
        A    => A(0),
        B    => B(0),
        Cin  => Cin,
        S    => S(0),
        Cout => C_carry(1)
    );

    FA1: full_adder_1bit port map (
        A    => A(1),
        B    => B(1),
        Cin  => C_carry(1),
        S    => S(1),
        Cout => C_carry(2)
    );

    FA2: full_adder_1bit port map (
        A    => A(2),
        B    => B(2),
        Cin  => C_carry(2),
        S    => S(2),
        Cout => C_carry(3)
    );

    FA3: full_adder_1bit port map (
        A    => A(3),
        B    => B(3),
        Cin  => C_carry(3),
        S    => S(3),
        Cout => Cout
    );

end Structural;