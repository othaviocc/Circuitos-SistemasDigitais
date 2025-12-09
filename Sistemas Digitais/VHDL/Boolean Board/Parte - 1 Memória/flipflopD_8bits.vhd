library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflopD_8bits is
   port(
      o_Q : out std_logic_vector(7 downto 0);    
      i_Clk, i_Rst, i_w, i_sx, i_sy : in std_logic;
      i_D : in std_logic_vector(7 downto 0)
   );
end flipflopD_8bits;

architecture estrutural of flipflopD_8bits is

   component flipflopD
      port(
         o_q : out std_logic;    
         i_clk, i_d, i_rst : in std_logic   
      );
   end component;

   signal s_d : std_logic_vector(7 downto 0);
   signal s_q : std_logic_vector(7 downto 0); 

begin
   s_d <= i_D when (i_w='1' and i_sx='1' and i_sy='1') else s_q;

   FF1: flipflopD port map(o_q => s_q(0), i_clk => i_Clk, i_d => s_d(0), i_rst => i_Rst);
   FF2: flipflopD port map(o_q => s_q(1), i_clk => i_Clk, i_d => s_d(1), i_rst => i_Rst);
   FF3: flipflopD port map(o_q => s_q(2), i_clk => i_Clk, i_d => s_d(2), i_rst => i_Rst);
   FF4: flipflopD port map(o_q => s_q(3), i_clk => i_Clk, i_d => s_d(3), i_rst => i_Rst);
   FF5: flipflopD port map(o_q => s_q(4), i_clk => i_Clk, i_d => s_d(4), i_rst => i_Rst);
   FF6: flipflopD port map(o_q => s_q(5), i_clk => i_Clk, i_d => s_d(5), i_rst => i_Rst);
   FF7: flipflopD port map(o_q => s_q(6), i_clk => i_Clk, i_d => s_d(6), i_rst => i_Rst);
   FF8: flipflopD port map(o_q => s_q(7), i_clk => i_Clk, i_d => s_d(7), i_rst => i_Rst);

   process(i_w, i_sx, i_sy, s_q)
   begin
      if (i_w='0' and i_sx='1' and i_sy='1') then
         o_Q <= s_q;
      else
         o_Q <= (others => '0');
      end if;
   end process;

end estrutural;
