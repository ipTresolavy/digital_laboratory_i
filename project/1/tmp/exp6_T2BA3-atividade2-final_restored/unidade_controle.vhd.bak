--------------------------------------------------------------------
-- Arquivo   : unidade_controle.vhd
-- Projeto   : Experiencia 4 - Desenvolvimento de projeto de circuitos
--             digitais em FPGA
--------------------------------------------------------------------
-- Descricao : unidade de controle
--
--             1) codificação VHDL (maquina de Moore)
--
--             2) definicao de valores da saida de depuracao
--                db_estado
--
--------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     20/01/2023  1.0     Edson Midorikawa  versao inicial
--     22/01/2023  1.1     Edson Midorikawa  revisao
--     04/02/2023  2.0     Igor Pontes Tresolavy revisao exp4
--------------------------------------------------------------------
--
library ieee;
use ieee.std_logic_1164.all;

entity unidade_controle is
    port (
        clock               : in  std_logic;
        reset               : in  std_logic;
        iniciar             : in  std_logic;
        enderecoIgualRodada : in  std_logic;
        tem_jogada          : in  std_logic;
		jogada_correta      : in  std_logic;
        fimT                : in  std_logic;
        fimCR               : in  std_logic;
        fimA                : in  std_logic;
        zeraE               : out std_logic;
        zeraCR              : out std_logic;
        zeraT               : out std_logic;
        zeraA               : out std_logic;
        contaE              : out std_logic;
        contaCR             : out std_logic;
        contaT              : out std_logic;
        contaA              : out std_logic;
        zeraR               : out std_logic;
        registraR           : out std_logic;
        ativa_escrita       : out std_logic;
        controla_led        : out std_logic;
		ganhou              : out std_logic;
		perdeu	            : out std_logic;
        pronto              : out std_logic;
        db_estado           : out std_logic_vector(3 downto 0);
        db_timeout          : out std_logic
    );
end entity;

architecture fsm of unidade_controle is
    type t_estado is (inicial, inicializa, amostra_jogada, inicio_rodada, espera_jogada, registra, compara_rod_jog, ultima_rodada, proximo, proxima_rodada, fimAcertou, fimErrou, fimTimeout, espera_escrita, registra_escrita);
    signal Eatual, Eprox: t_estado;
begin

    -- memoria de estado
    process (clock,reset)
    begin
        if reset='1' then
            Eatual <= inicial;
        elsif clock'event and clock = '1' then
            Eatual <= Eprox;
        end if;
    end process;

    -- logica de proximo estado
    Eprox <=
        inicial        when  Eatual=inicial and iniciar='0' else
        inicializa     when  Eatual=inicial and iniciar='1' else

        amostra_jogada when  Eatual=inicializa else

        amostra_jogada when Eatual=amostra_jogada and fimA='0' else
        inicio_rodada  when Eatual=amostra_jogada and fimA='1' else

        espera_jogada  when Eatual=inicio_rodada else

        espera_jogada  when Eatual=espera_jogada and tem_jogada='0' and fimT='0' else
        registra       when Eatual=espera_jogada and tem_jogada='1' and fimT='0' else
        fimTimeout     when Eatual=espera_jogada and fimT='1' else

        compara_rod_jog when Eatual=registra else

        proximo         when Eatual=compara_rod_jog and enderecoIgualRodada='0' and jogada_correta='1' else
        ultima_rodada   when Eatual=compara_rod_jog and enderecoIgualRodada='1' and jogada_correta='1' else
        fimErrou        when Eatual=compara_rod_jog and jogada_correta='0' else

        espera_escrita  when Eatual=ultima_rodada and fimCR='0' else
        fimAcertou      when Eatual=ultima_rodada and fimCR='1' else
        
        espera_escrita  when Eatual=espera_escrita and tem_jogada='0' else
        registra_escrita when Eatual=espera_escrita and tem_jogada='1' else

        proxima_rodada  when Eatual=registra_escrita else
		  
		  espera_jogada   when Eatual=proximo else
        
        inicio_rodada   when Eatual=proxima_rodada else

        fimAcertou      when Eatual=fimAcertou and iniciar='0' else
        inicializa      when Eatual=fimAcertou and iniciar='1' else

        fimErrou        when Eatual=fimErrou and iniciar='0' else
        inicializa      when Eatual=fimErrou and iniciar='1' else

        fimTimeout      when Eatual=fimTimeout and iniciar='0' else
        inicializa      when Eatual=fimTimeout and iniciar='1' else

        inicial; -- condição inatingível

    -- logica de saída (maquina de Moore)
    with Eatual select
        zeraE     <=  '1' when inicial | inicializa | inicio_rodada,
                      '0' when others;

    with Eatual select
        zeraCR    <= '1' when inicial | inicializa,
                     '0' when others;

    with Eatual select
        zeraT     <= '1' when inicio_rodada | proximo,
                     '0' when others;
    with Eatual select
        zeraA     <= '1' when inicializa,
                     '0' when others;

    with Eatual select
        contaE    <= '1' when proximo | ultima_rodada,
                     '0' when others;

    with Eatual select
        contaCR   <= '1' when proxima_rodada,
                     '0' when others;

    with Eatual select
        contaT    <= '1' when espera_jogada,
                     '0' when others;

    with Eatual select
        contaA    <= '1' when amostra_jogada,
                     '0' when others;

    with Eatual select
        zeraR     <= '1' when inicial,
                     '0' when others;

    with Eatual select
        registraR <= '1' when registra | registra_escrita,
                     '0' when others;

    with Eatual select
        ativa_escrita <= '1' when proxima_rodada,
                         '0' when others;

    with Eatual select
        controla_led <= '1' when amostra_jogada,
                        '0' when others;

    with Eatual select
        pronto    <=  '1' when fimAcertou | fimErrou | fimTimeout,
                      '0' when others;

    with Eatual select
        ganhou   <= '1' when fimAcertou,
                     '0' when others;

    with Eatual select
        perdeu   <= '1' when fimErrou | fimTimeout,
                      '0' when others;

    -- saida de depuracao (db_estado)
    with Eatual select
        db_estado <= "0000" when inicial,         -- 0
                     "0001" when inicializa,      -- 1
                     "0010" when amostra_jogada,  -- 2
                     "0011" when inicio_rodada,   -- 3
                     "0100" when espera_jogada,   -- 4
                     "0101" when registra,        -- 5
                     "0110" when compara_rod_jog, -- 6
                     "0111" when proximo,         -- 7
                     "1000" when ultima_rodada,   -- 8
                     "1001" when proxima_rodada,  -- 9
                     "1011" when espera_escrita,  -- B
                     "1101" when registra_escrita,-- D 
                     "1010" when fimAcertou,      -- A
                     "1100" when fimTimeout,      -- C
				     "1110" when fimErrou,        -- E
                     "1111" when others;          -- F

    -- saida de depuracao (db_timeout)
    with Eatual select
        db_timeout <= '1' when fimTimeout,
                      '0' when others;

end architecture fsm;
