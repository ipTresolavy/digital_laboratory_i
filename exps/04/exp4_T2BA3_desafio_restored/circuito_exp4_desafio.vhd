library ieee;
use ieee.std_logic_1164.all;

entity circuito_exp4_desafio is
    port (
        clock          : in std_logic;
        reset          : in std_logic;
        iniciar        : in std_logic;
        chaves         : in std_logic_vector(3 downto 0);
        pronto         : out std_logic;
        acertou        : out std_logic;
        errou          : out std_logic;
        leds           : out std_logic_vector(3 downto 0);
        db_igual       : out std_logic;
        db_contagem    : out std_logic_vector(6 downto 0);
        db_memoria     : out std_logic_vector(6 downto 0);
        db_estado      : out std_logic_vector(6 downto 0);
        db_jogadafeita : out std_logic_vector(6 downto 0);
        db_clock       : out std_logic;
        db_tem_jogada  : out std_logic;
        db_timeout     : out std_logic
    );
end entity;

architecture toplevel of circuito_exp4_desafio is

    component fluxo_dados is
        port (
            clock         : in  std_logic;
            zeraC         : in  std_logic;
            zeraM         : in  std_logic;
            contaC        : in  std_logic;
            contaM        : in  std_logic;
            escreveM      : in  std_logic;
            zeraR         : in  std_logic;
            registraR     : in  std_logic;
            chaves        : in  std_logic_vector (3 downto 0);
            igual         : out std_logic;
            fimC          : out std_logic;
            jogada_feita  : out std_logic;
            timeout       : out std_logic;
            db_tem_jogada : out std_logic;
            db_contagem   : out std_logic_vector (3 downto 0);
            db_memoria    : out std_logic_vector (3 downto 0);
            db_jogada     : out std_logic_vector (3 downto 0)
        );
    end component;

    component unidade_controle is
        port (
            clock     : in  std_logic;
            reset     : in  std_logic;
            iniciar   : in  std_logic;
            fim       : in  std_logic;
            jogada    : in  std_logic;
            igual     : in  std_logic;
            timeout_in   : in  std_logic;
            zeraC     : out std_logic;
            zeraM     : out std_logic;
            contaC    : out std_logic;
            contaM    : out std_logic;
            zeraR     : out std_logic;
            registraR : out std_logic;
            acertou   : out std_logic;
            errou	  : out std_logic;
            timeout_out : out std_logic;
            pronto    : out std_logic;
            db_estado : out std_logic_vector(3 downto 0)
        );
    end component;

    component hexa7seg is
        port (
            hexa : in  std_logic_vector(3 downto 0);
            sseg : out std_logic_vector(6 downto 0)
        );
    end component hexa7seg;

    signal s_zeraC : std_logic;
    signal s_zeraM : std_logic;
    signal s_contaC : std_logic;
    signal s_contaM : std_logic;
    signal s_zeraR : std_logic;
    signal s_registraR : std_logic;
    signal s_fim : std_logic;
    signal s_igual : std_logic;
    signal s_jogada : std_logic;
    signal s_db_tem_jogada : std_logic;
    signal s_timeout : std_logic;

    signal s_db_contagem : std_logic_vector(3 downto 0);
    signal s_db_memoria : std_logic_vector(3 downto 0);
    signal s_db_jogadafeita : std_logic_vector(3 downto 0);
    signal s_db_jogada : std_logic_vector(3 downto 0);
    signal s_db_estado : std_logic_vector(3 downto 0);

begin

    FD: fluxo_dados
        port map
        (
            clock => clock,
            zeraC => s_zeraC,
            zeraM => s_zeraM,
            contaC => s_contaC,
            contaM => s_contaM,
            escreveM => '0',
            zeraR => s_zeraR,
            registraR => s_registraR,
            chaves => chaves,
            igual => s_igual,
            fimC => s_fim,
            jogada_feita => s_jogada,
            timeout => s_timeout,
            db_tem_jogada => db_tem_jogada,
            db_contagem => s_db_contagem,
            db_memoria => s_db_memoria,
            db_jogada => s_db_jogada
        );

    UC: unidade_controle
        port map
        (
            clock => clock,
            reset => reset,
            iniciar => iniciar,
            fim => s_fim,
            jogada => s_jogada,
            igual => s_igual,
            timeout_in => s_timeout,
            zeraC => s_zeraC,
            zeraM => s_zeraM,
            contaC => s_contaC,
            contaM => s_contaM,
            zeraR => s_zeraR,
            registraR => s_registraR,
            acertou => acertou,
            errou => errou,
            timeout_out => db_timeout,
            pronto => pronto,
            db_estado => s_db_estado
        );

    HEX2: hexa7seg
        port map (
            hexa => s_db_jogada,
            sseg => db_jogadafeita
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

    HEX3: hexa7seg
        port map (
            hexa => s_db_estado,
            sseg => db_estado
        );

    db_clock <= clock;
    db_igual <= s_igual;

    leds <= s_db_memoria;

end architecture toplevel;











