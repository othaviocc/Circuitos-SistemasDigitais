library ieee;
use ieee.std_logic_1164.all;

--FlipFlop D de 8bits
entity ff_d_8bit is
    port (
        D     : in  std_logic_vector(7 downto 0); 
        CLK   : in  std_logic;                    
        RESET : in  std_logic;                    
        Q     : out std_logic_vector(7 downto 0)  
    );
end entity ff_d_8bit;

architecture ESTRUCTURAL of ff_d_8bit is

    component ff_d_1bit is
        port (
            D     : in  std_logic;
            CLK   : in  std_logic;
            RESET : in  std_logic;
            Q     : out std_logic
        );
    end component ff_d_1bit;

begin

    GEN_FF_BITS : for i in 0 to 7 generate
        u_ff_d_bit : ff_d_1bit
            port map (
                D     => D(i),     
                CLK   => CLK,      
                RESET => RESET,    
                Q     => Q(i)     
            );
    end generate GEN_FF_BITS;

end architecture ESTRUCTURAL;