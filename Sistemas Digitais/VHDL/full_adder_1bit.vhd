library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_1bit is
    Port ( A    : in  STD_LOGIC;
           B    : in  STD_LOGIC;
           Cin  : in  STD_LOGIC;
           S    : out STD_LOGIC;
           Cout : out STD_LOGIC);
end full_adder_1bit;

architecture Dataflow of full_adder_1bit is

begin
    S <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and (A xor B));
end Dataflow;