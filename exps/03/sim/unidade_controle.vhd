--------------------------------------------------------------------
-- Arquivo   : unidade_controle.vhd
-- Projeto   : Experiencia 3 - Projeto de uma unidade de controle
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
--     20/01/2022  1.0     Edson Midorikawa  versao inicial
--     22/01/2023  1.1     Edson Midorikawa  revisao
--------------------------------------------------------------------
--
library ieee;
use ieee.std_logic_1164.all;

entity unidade_controle is
    port (
        clock              : in  std_logic;
        reset              : in  std_logic;
        iniciar            : in  std_logic;
        fimC               : in  std_logic;
        chavesIgualMemoria : in  std_logic;
        zeraC              : out std_logic;
        contaC             : out std_logic;
        zeraR              : out std_logic;
        registraR          : out std_logic;
        pronto             : out std_logic;
        acertou            : out std_logic;
        errou              : out std_logic;
        db_estado          : out std_logic_vector(3 downto 0)
    );
end entity;

architecture fsm_desafio of unidade_controle is
    type t_estado is (inicial, preparacao, registra, comparacao, proximo, fimErrou, fimAcertou);
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
        inicial     when  Eatual=inicial and iniciar='0' else
        preparacao  when  Eatual=inicial and iniciar='1' else
        registra    when  Eatual=preparacao else
        comparacao  when  Eatual=registra else
        proximo     when  Eatual=comparacao and chavesIgualMemoria='1' else
        fimAcertou  when  Eatual=proximo and fimC='1' else
        fimErrou    when  Eatual=comparacao and chavesIgualMemoria='0' else
        registra    when  Eatual=proximo and fimC='0' else
        inicial     when  Eatual=fimErrou else
        inicial     when  Eatual=fimAcertou else
        inicial;

    -- logica de saída (maquina de Moore)
    with Eatual select
        zeraC <=      '1' when preparacao,
                      '0' when others;

    with Eatual select
        zeraR <=      '1' when inicial | preparacao,
                      '0' when others;

    with Eatual select
        registraR <=  '1' when registra,
                      '0' when others;

    with Eatual select
        contaC <=     '1' when proximo,
                      '0' when others;

    with Eatual select
        pronto <=     '1' when fimAcertou | fimErrou,
                      '0' when others;

    acertou <= '1' when Eatual=fimAcertou else
               '0';

    errou <= '1' when Eatual=fimErrou else
             '0';

    -- saida de depuracao (db_estado)
    with Eatual select
        db_estado <= "0000" when inicial,     -- 0
                     "0001" when preparacao,  -- 1
                     "0100" when registra,    -- 4
                     "0101" when comparacao,  -- 5
                     "0110" when proximo,     -- 6
                     "1100" when fimErrou,    -- C
                     "1101" when fimAcertou,  -- D
                     "1111" when others;      -- F

end architecture fsm_desafio;

architecture fsm of unidade_controle is
    type t_estado is (inicial, preparacao, registra, comparacao, proximo, fim);
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
        inicial     when  Eatual=inicial and iniciar='0' else
        preparacao  when  Eatual=inicial and iniciar='1' else
        registra    when  Eatual=preparacao else
        comparacao  when  Eatual=registra else
        proximo     when  Eatual=comparacao else
        fim         when  Eatual=proximo and fimC='1' else
        --fim         when  Eatual=comparacao and fimC='1' else
        registra    when  Eatual=proximo and fimC='0' else
        inicial     when  Eatual=fim else
        inicial;

    -- logica de saída (maquina de Moore)
    with Eatual select
        zeraC <=      '1' when preparacao,
                      '0' when others;

    with Eatual select
        zeraR <=      '1' when inicial | preparacao,
                      '0' when others;

    with Eatual select
        registraR <=  '1' when registra,
                      '0' when others;

    with Eatual select
        contaC <=     '1' when proximo,
                      '0' when others;

    with Eatual select
        pronto <=     '1' when fim,
                      '0' when others;

    -- saida de depuracao (db_estado)
    with Eatual select
        db_estado <= "0000" when inicial,     -- 0
                     "0001" when preparacao,  -- 1
                     "0100" when registra,    -- 4
                     "0101" when comparacao,  -- 5
                     "0110" when proximo,     -- 6
                     "1100" when fim,         -- C
                     "1111" when others;      -- F

end architecture fsm;
