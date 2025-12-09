library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maquina_de_estados is
    port(
        i_clk   : in std_logic;
        i_reset : in std_logic;
        
        -- Saidas de Controle
        o_w       : out std_logic;
        o_linha   : out std_logic;
        o_coluna  : out std_logic;
        o_d       : out std_logic_vector(7 downto 0);
        o_rst_mem : out std_logic;
        
        -- Saidas de Dados para os Displays
        o_val_display_write : out std_logic_vector(7 downto 0);
        
        -- Estado Final
        o_rgb     : out std_logic_vector(2 downto 0)
    );
end entity;

architecture comportamental of maquina_de_estados is

    type t_estado is (s_INIT, s_WRITE_0, s_WRITE_1, s_WRITE_2, s_WRITE_3, s_READ_0, s_READ_1, s_READ_2, s_READ_3, s_CLEAR_MEM, s_FINAL);
    signal estado_atual, proximo_estado : t_estado; -- Adicionado proximo_estado
    
    constant w_dado_1 : std_logic_vector(7 downto 0) := std_logic_vector(TO_UNSIGNED(40,8));

    -- TEMPORIZACAO
    -- Clock: 100MHz. 3 Segundos = 300.000.000 ciclos.
    -- ATENCAO: Para simular use 10. Para gravar use 300000000.
    constant C_3_SEGUNDOS : integer := 300000000; 
    signal s_contador : integer range 0 to C_3_SEGUNDOS;
    
    constant C_1_SEGUNDO : integer := 100000000;
    signal s_cnt_rgb : integer range 0 to C_1_SEGUNDO;
    signal s_rgb_select : integer range 0 to 2;

begin

    -------------------------------------------------------------------------
    -- PROCESSO 1: REGISTRADOR DE ESTADO (O "SAGRADO")
    -- Este process faz APENAS o sincronismo e reset. Nao mude a logica aqui.
    -- Atende ao requisito: "O process usado para sincronismo... nao deve ser alterado"
    -------------------------------------------------------------------------
    process(i_clk, i_reset)
    begin
        if i_reset = '1' then
            estado_atual <= s_INIT;
        elsif rising_edge(i_clk) then
            estado_atual <= proximo_estado;
        end if;
    end process;

    -------------------------------------------------------------------------
    -- PROCESSO 2: GERENCIAMENTO DE TEMPO E CONTADORES (AUXILIAR)
    -- Separa a contagem da logica de estados para manter o padrao.
    -------------------------------------------------------------------------
    process(i_clk, i_reset)
    begin
        if i_reset = '1' then
            s_contador <= 0;
            s_cnt_rgb <= 0;
            s_rgb_select <= 0;
        elsif rising_edge(i_clk) then
            -- Logica do Contador de 3s
            -- Se mudou de estado (estado_atual != proximo_estado), zera o contador
            -- Porem, como estamos num processo sincrono, verificamos se o contador estourou
            if estado_atual /= s_FINAL then
                if s_contador < C_3_SEGUNDOS then
                    s_contador <= s_contador + 1;
                else
                    s_contador <= 0; -- Reinicia ao atingir o tempo
                end if;
            end if;

            -- Logica do RGB (Pisca apenas no final)
            if estado_atual = s_FINAL then
                if s_cnt_rgb < C_1_SEGUNDO then
                    s_cnt_rgb <= s_cnt_rgb + 1;
                else
                    s_cnt_rgb <= 0;
                    if s_rgb_select = 2 then 
                        s_rgb_select <= 0; 
                    else 
                        s_rgb_select <= s_rgb_select + 1; 
                    end if;
                end if;
            else
                s_cnt_rgb <= 0; -- Zera se sair do estado final
            end if;
        end if;
    end process;

    -------------------------------------------------------------------------
    -- PROCESSO 3: LOGICA DE PROXIMO ESTADO E SAIDAS (COMBINACIONAL)
    -- Aqui define-se para onde a maquina vai e o que ela mostra.
    -------------------------------------------------------------------------
    process(estado_atual, s_contador, s_rgb_select)
    begin
        -- 1. Definicoes Padrao (Evita Latches)
        proximo_estado <= estado_atual; -- Por padrao, fica no mesmo estado
        
        o_w <= '0'; o_linha <= '0'; o_coluna <= '0';
        o_d <= (others => '0');
        o_rst_mem <= '0';
        o_val_display_write <= (others => '0');
        o_rgb <= "000";

        -- 2. Logica de Estados (Case)
        case estado_atual is
            
            when s_INIT =>
                o_rst_mem <= '1';
                if s_contador = C_3_SEGUNDOS then
                    proximo_estado <= s_WRITE_0;
                end if;

            when s_WRITE_0 =>
                o_w <= '1'; o_linha <= '0'; o_coluna <= '0';
                o_d <= w_dado_1;
                o_val_display_write <= w_dado_1;
                
                -- So muda de estado se o tempo acabou
                if s_contador = C_3_SEGUNDOS then proximo_estado <= s_WRITE_1; end if;

            when s_WRITE_1 =>
                o_w <= '1'; o_linha <= '0'; o_coluna <= '1';
                o_d <= std_logic_vector(to_unsigned(120, 8)); -- Valor
                o_val_display_write <= std_logic_vector(to_unsigned(120, 8));
                
                if s_contador = C_3_SEGUNDOS then proximo_estado <= s_WRITE_2; end if;

            when s_WRITE_2 =>
                o_w <= '1'; o_linha <= '1'; o_coluna <= '0';
                o_d <= std_logic_vector(to_unsigned(37, 8)); -- Valor
                o_val_display_write <= std_logic_vector(to_unsigned(37, 8));

                if s_contador = C_3_SEGUNDOS then proximo_estado <= s_WRITE_3; end if;

            when s_WRITE_3 =>
                o_w <= '1'; o_linha <= '1'; o_coluna <= '1';
                o_d <= std_logic_vector(to_unsigned(96, 8)); -- Valor
                o_val_display_write <= std_logic_vector(to_unsigned(96, 8));

                if s_contador = C_3_SEGUNDOS then proximo_estado <= s_READ_0; end if;

            -- LEITURA --------------------------------------------------
            when s_READ_0 =>
                o_w <= '0'; o_linha <= '0'; o_coluna <= '0';
                
                if s_contador = C_3_SEGUNDOS then proximo_estado <= s_READ_1; end if;

            when s_READ_1 =>
                o_w <= '0'; o_linha <= '0'; o_coluna <= '1';
                
                if s_contador = C_3_SEGUNDOS then proximo_estado <= s_READ_2; end if;

            when s_READ_2 =>
                o_w <= '0'; o_linha <= '1'; o_coluna <= '0';
                
                if s_contador = C_3_SEGUNDOS then proximo_estado <= s_READ_3; end if;

            when s_READ_3 =>
                o_w <= '0'; o_linha <= '1'; o_coluna <= '1';
                
                if s_contador = C_3_SEGUNDOS then proximo_estado <= s_CLEAR_MEM; end if;

            -- FINALIZACAO ----------------------------------------------
            when s_CLEAR_MEM =>
                o_rst_mem <= '1';
                
                -- Tempo curto para garantir o reset ou 3s padrao
                if s_contador = C_3_SEGUNDOS then proximo_estado <= s_FINAL; end if;

            when s_FINAL =>
                o_rst_mem <= '0';
                -- Fica aqui para sempre (proximo_estado <= s_FINAL ja eh o padrao)
                
                -- Logica de saida RGB baseada no contador auxiliar
                if s_rgb_select = 0 then o_rgb <= "100"; -- R
                elsif s_rgb_select = 1 then o_rgb <= "010"; -- G
                else o_rgb <= "001"; -- B
                end if;
                
            when others =>
                proximo_estado <= s_INIT;
        end case;
    end process;

end architecture;