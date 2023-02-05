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
        clock     : in  std_logic;
        reset     : in  std_logic;
        iniciar   : in  std_logic;
        fim       : in  std_logic;
        jogada    : in  std_logic;
		igual     : in  std_logic;
        zeraC     : out std_logic;
        contaC    : out std_logic;
        zeraR     : out std_logic;
        registraR : out std_logic;
		acertou   : out std_logic;
		errou	  : out std_logic;
        pronto    : out std_logic;
        db_estado : out std_logic_vector(3 downto 0)
    );
end entity;

architecture fsm of unidade_controle is
    type t_estado is (inicial, inicializa, espera_jogada, registra, compara, proximo, fimAcertou, fimErrou);
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
        inicial       when  Eatual=inicial and iniciar='0' else
        inicializa    when  Eatual=inicial and iniciar='1' else

        espera_jogada when  Eatual=inicializa else

        espera_jogada when Eatual=espera_jogada and jogada='0' else
        registra      when Eatual=espera_jogada and jogada='1' else

        compara       when Eatual=registra else

        proximo       when Eatual=compara and fim='0' and igual='1' else
        fimAcertou    when Eatual=compara and fim='1' and igual='1' else
        fimErrou      when Eatual=compara and igual='0' else

        espera_jogada when Eatual=proximo else

        fimAcertou    when Eatual=fimAcertou and iniciar='0' else
        inicializa    when Eatual=fimAcertou and iniciar='1' else

        fimErrou      when Eatual=fimErrou and iniciar='0' else
        inicializa    when Eatual=fimErrou and iniciar='1' else

        inicial; -- condição inatingível

    -- logica de saída (maquina de Moore)
    with Eatual select
        zeraC     <=  '1' when inicial | inicializa,
                      '0' when others;

    with Eatual select
        zeraR     <=  '1' when inicial,
                      '0' when others;

    with Eatual select
        registraR <=  '1' when registra,
                      '0' when others;

    with Eatual select
        contaC    <=  '1' when proximo,
                      '0' when others;

    with Eatual select
        pronto    <=  '1' when fimAcertou | fimErrou,
                      '0' when others;

    with Eatual select
        acertou   <= '1' when fimAcertou,
                     '0' when others;

    with Eatual select
        errou     <= '1' when fimErrou,
                     '0' when others;

    -- saida de depuracao (db_estado)
    with Eatual select
        db_estado <= "0000" when inicial,       -- 0
                     "0001" when inicializa,    -- 1
                     "0010" when espera_jogada, -- 2
                     "0011" when registra,      -- 3
                     "0100" when compara,       -- 4
                     "0101" when proximo,       -- 5
                     "1010" when fimAcertou,    -- A
					 "1110" when fimErrou,      -- E
                     "1111" when others;        -- F

end architecture fsm;
