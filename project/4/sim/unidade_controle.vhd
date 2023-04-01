--------------------------------------------------------------------
-- Arquivo   : unidade_controle.vhd
-- Projeto   : Braille Teacher
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
--     04/02/2023  2.0     Pontes Tresolavy  revisao exp4
--     10/03/2023  3.0     Pontes Tresolavy  revisao Braille
--                                           Teacher
--     30/03/2023  4.0     Pontes Tresolavy  versão final 
--                                           Braille Teacher
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
        tem_jogada          : in  std_logic_vector(5 downto 0);
        tem_escrita         : in  std_logic;
		jogada_correta      : in  std_logic;
		tem_erro            : in  std_logic;
        fimT                : in  std_logic;
        fimA                : in  std_logic;
        fimCR               : in  std_logic;
        zeraE               : out std_logic;
        zeraCR              : out std_logic;
        zeraT               : out std_logic;
        zeraEstat           : out std_logic;
        contaE              : out std_logic;
        contaCR             : out std_logic;
        contaT              : out std_logic;
        contaErr            : out std_logic;
        registraTempo       : out std_logic;
        zeraR               : out std_logic;
        registraR           : out std_logic;
        mux_registrador     : out std_logic;
        ativa_escrita       : out std_logic;
        aguarda_escrita     : out std_logic;
        fimDeJogo           : out std_logic; -- DIO8
        errou_jogada        : out std_logic; -- DIO5
        acertou_jogada      : out std_logic; -- DIO6
        db_estado           : out std_logic_vector(3 downto 0) -- HEX5
    );
end entity;

architecture fsm of unidade_controle is
    type t_estado is (inicial, inicializa, espera_escrita, registra_escrita, escreve_dado, inicio_rodada, super_espera_jogada, ultima_jogada, acertou, errou, proxima_jogada, fim);
    type t_subestado is (espera_jogada, registra_jogada, compara_jogada_rodada);
    type t_subestados is array(0 to 5) of t_subestado;

    signal Eatual, Eprox: t_estado;
    signal subEatuais, subEproxs: t_subestados;

    signal registra : std_logic_vector(5 downto 0);

begin

    -- memoria de estado
    process (clock,reset)
    begin
        if reset='1' then
            Eatual <= inicial;
            subEatuais <= (others => espera_jogada);
        elsif clock'event and clock = '1' then
            Eatual <= Eprox;
            subEatuais <= subEproxs;
        end if;
    end process;

    -- logica de proximo estado
    Eprox <=
        inicial             when  Eatual=inicial and iniciar='0' else
        inicializa          when  Eatual=inicial and iniciar='1' else

        espera_escrita      when  Eatual=inicializa else

        espera_escrita      when Eatual=espera_escrita and tem_escrita='0' else
        registra_escrita    when Eatual=espera_escrita and tem_escrita='1' else

        escreve_dado        when Eatual=registra_escrita else

        inicio_rodada       when Eatual=escreve_dado else

        super_espera_jogada when Eatual=inicio_rodada else

        super_espera_jogada when Eatual=super_espera_jogada and jogada_correta='0' and fimT='0' and tem_erro='0' else
        acertou             when Eatual=super_espera_jogada and jogada_correta='1' and fimT='0' else
        errou               when Eatual=super_espera_jogada and (tem_erro='1' or fimT='1') else

		acertou             when Eatual=acertou and fimA='0' else
		proxima_jogada      when Eatual=acertou and fimA='1' else

        errou               when Eatual=errou and fimA='0' else
        proxima_jogada      when Eatual=errou and fimA='1' else

        super_espera_jogada when Eatual=proxima_jogada and enderecoIgualRodada='0' else
        ultima_jogada       when Eatual=proxima_jogada and enderecoIgualRodada='1' else

        espera_escrita      when Eatual=ultima_jogada and fimCR='0' else
        fim                 when Eatual=ultima_jogada and fimCR='1' else

        fim                 when Eatual=fim and iniciar='0' else
        inicializa          when Eatual=fim and iniciar='1' else

        inicial; -- condição inatingível

    subestados: for subestado in 0 to 5 generate
        -- lógica de próximo subestado
        subEproxs(subestado) <=
            espera_jogada   when Eatual=super_espera_jogada and subEatuais(subestado)=espera_jogada and tem_jogada(subestado)='0' else
            registra_jogada when Eatual=super_espera_jogada and subEatuais(subestado)=espera_jogada and tem_jogada(subestado)='1' else

            compara_jogada_rodada when Eatual=super_espera_jogada and subEatuais(subestado)=registra_jogada else

            compara_jogada_rodada when Eatual=super_espera_jogada and subEatuais(subestado)=compara_jogada_rodada else

            espera_jogada;

            with subEatuais(subestado) select
                registra(subestado) <= '1' when registra_jogada,
                                       '0' when others;

    end generate subestados;


    -- logica de saída (maquina de Moore)
    with Eatual select
        zeraE <=  '1' when inicializa | inicio_rodada,
                  '0' when others;

    with Eatual select
        zeraCR <= '1' when inicializa,
                  '0' when others;

    with Eatual select
        zeraT <= '1' when inicio_rodada | acertou | errou,
                 '0' when others;

    with Eatual select
        contaE <= '1' when proxima_jogada,
                  '0' when others;

    with Eatual select
        contaCR <= '1' when ultima_jogada,
                   '0' when others;

    with Eatual select
        contaT <= '1' when super_espera_jogada,
                  '0' when others;

    with Eatual select
        contaErr <= '1' when inicializa | errou,
                    '0' when others;

    with Eatual select
        registraTempo <= '1' when super_espera_jogada,
                        '0' when others;

    with Eatual select
        zeraR <= '1' when inicializa | inicio_rodada | proxima_jogada,
                 '0' when others;

    with Eatual select
        zeraEstat <= '1' when inicial | inicializa | fim,
                     '0' when others;

    with Eatual select
        mux_registrador <= '1' when registra_escrita,
                           '0' when others;

    with Eatual select
        registraR <= '1' when registra_escrita,
                      (registra(5) or
                      registra(4) or
                      registra(3) or
                      registra(2) or
                      registra(1) or
                      registra(0)) when others;

    with Eatual select
        ativa_escrita <= '1' when escreve_dado,
                         '0' when others;

    with Eatual select
        aguarda_escrita <= '1' when espera_escrita,
                           '0' when others;

    with Eatual select
        fimDeJogo <= '1' when fim,
                     '0' when others;

    with Eatual select
        acertou_jogada <= '1' when acertou,
                     '0' when others;

    with Eatual select
        errou_jogada <= '1' when errou,
                     '0' when others;

    -- saida de depuracao (db_estado)
    with Eatual select
        db_estado <= "0000" when inicial,            -- 0
                     "0001" when inicializa,         -- 1
                     "0010" when espera_escrita,     -- 2
                     "0011" when registra_escrita,   -- 3
                     "0100" when escreve_dado,       -- 4
                     "0101" when inicio_rodada,      -- 5
                     "0110" when super_espera_jogada,-- 6
                     "1010" when acertou,            -- A
                     "1110" when errou,              -- E
                     "1001" when proxima_jogada,     -- 9
                     "1011" when ultima_jogada,      -- B
                     "1111" when fim,                -- F
                     "1100" when others;             -- C

end architecture fsm;
