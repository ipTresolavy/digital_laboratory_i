--------------------------------------------------------------------
-- Arquivo   : circuito_exp3.vhd
-- Projeto   : Experiencia 3 - Projeto de uma unidade de controle
--------------------------------------------------------------------
-- Descricao : implementacao em vhdl da entidade topo do projeto
--------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor                           Descricao
--     28/01/2022  1.0     Thiago Souza                    versao inicial
--     29/01/2022  1.1     Igor Pontes Tresolavy           versao inicial
--------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity circuito_exp3 is
    port (
        clock       : in std_logic;
        reset       : in std_logic;
        iniciar     : in std_logic;
        chaves      : in std_logic_vector (3 downto 0);
        pronto      : out std_logic;
        db_igual    : out std_logic;
        db_iniciar  : out std_logic;
        db_contagem : out std_logic_vector (6 downto 0);
        db_memoria  : out std_logic_vector (6 downto 0);
        db_chaves   : out std_logic_vector (6 downto 0);
        db_estado   : out std_logic_vector (6 downto 0)
    );
end entity;

architecture toplevel of circuito_exp3 is

    component unidade_controle
        port (
          clock     : in  std_logic;
          reset     : in  std_logic;
          iniciar   : in  std_logic;
          fimC      : in  std_logic;
          zeraC     : out std_logic;
          contaC    : out std_logic;
          zeraR     : out std_logic;
          registraR : out std_logic;
          pronto    : out std_logic;
          db_estado : out std_logic_vector(3 downto 0)
        );
    end component;

    component fluxo_dados is
        port (
            clock               : in  std_logic;
            zeraC               : in  std_logic;
            contaC              : in  std_logic;
            escreveM            : in  std_logic;
            zeraR               : in  std_logic;
            registraR           : in  std_logic;
            chaves              : in  std_logic_vector (3 downto 0);
            chavesIgualMemoria  : out std_logic;
            fimC                : out std_logic;
            db_contagem         : out std_logic_vector (3 downto 0);
            db_memoria          : out std_logic_vector (3 downto 0);
            db_chaves           : out std_logic_vector (3 downto 0)
        );
    end component;

    component hexa7seg is
        port (
            hexa : in  std_logic_vector(3 downto 0);
            sseg : out std_logic_vector(6 downto 0)
        );
    end component hexa7seg;

    signal s_zeraC : std_logic;
    signal s_contaC : std_logic;
    signal s_zeraR : std_logic;
    signal s_registraR : std_logic;
    signal s_fimC : std_logic;

    signal s_db_contagem : std_logic_vector(3 downto 0);
    signal s_db_memoria : std_logic_vector(3 downto 0);
    signal s_db_chaves : std_logic_vector(3 downto 0);
    signal s_db_estado : std_logic_vector(3 downto 0);

begin

    FD: fluxo_dados
        port map (
            clock => clock,
            zeraC => s_zeraC,
            contaC => s_contaC,
            escreveM => '0',
            zeraR => s_zeraR,
            registraR => s_registraR,
            chaves => chaves,
            chavesIgualMemoria => db_igual,
            fimC => s_fimC,
            db_contagem => s_db_contagem,
            db_memoria => s_db_memoria,
            db_chaves => s_db_chaves
        );

        UC: entity work.unidade_controle(fsm)
        port map (
            clock => clock,
            reset => reset,
            iniciar => iniciar,
            fimC => s_fimC,
            chavesIgualMemoria => db_igual,
            zeraC => s_zeraC,
            contaC => s_contaC,
            zeraR => s_zeraR,
            registraR => s_registraR,
            pronto => pronto,
            acertou => open,
            errou => open,
            db_estado => s_db_estado
        );

    HEX2: hexa7seg
        port map (
            hexa => s_db_chaves,
            sseg => db_chaves
        );

    HEX0: hexa7seg
        port map (
            hexa => s_db_contagem,
            sseg => db_contagem
        );

    HEX1: hexa7seg
        port map (
            hexa => s_db_memoria,
            sseg => db_memoria
        );

    HEX5: hexa7seg
        port map (
            hexa => s_db_estado,
            sseg => db_estado
        );

    db_iniciar <= iniciar;

end toplevel;
