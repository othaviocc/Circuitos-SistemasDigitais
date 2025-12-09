Library IEEE;
USE IEEE.Std_logic_1164.all;

entity flipflopD is 
   port(
      o_q : out std_logic;    
      i_clk, i_d, i_rst:in std_logic   
   );
end flipflopD;

architecture comportamental of flipflopD is  
	signal s_q : std_logic;
begin  
	process(i_clk,i_rst)
	begin 
		if i_rst = '1' then
          s_q <= '0';
			
		elsif(rising_edge(i_clk)) then
			s_q <= i_d;
			
   end if; 
	end process;
	o_q <= s_q;
      
end comportamental; 