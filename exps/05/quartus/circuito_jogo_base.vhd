library ieee;
use ieee.std_logic_1164.all;

entity circuito_jogo_base is
    port (
        clock                  : in std_logic;
        reset                  : in std_logic;
        iniciar                : in std_logic;
        botoes                 : in std_logic_vector(3 downto 0);
        leds                   : out std_logic_vector(3 downto 0);
        pronto                 : out std_logic;
        ganhou                 : out std_logic;
        perdeu                 : out std_logic;
        db_clock               : out std_logic;
        db_tem_jogada          : out std_logic;
        db_jogada_correta      : out std_logic;
        db_enderecoIgualRodada : out std_logic;
        db_timeout             : out std_logic;
        db_contagem            : out std_logic_vector(6 downto 0);
        db_memoria             : out std_logic_vector(6 downto 0);
        db_jogada_feita        : out std_logic_vector(6 downto 0);
        db_rodada              : out std_logic_vector(6 downto 0);
        db_estado              : out std_logic_vector(6 downto 0)
    );
end entity;

architecture toplevel of circuito_jogo_base is

    component fluxo_dados is
        port (
            clock               : in  std_logic;
            zeraE               : in  std_logic;
            zeraCR              : in  std_logic;
            zeraT               : in  std_logic;
            zeraA               : in  std_logic;
            contaE              : in  std_logic;
            contaCR             : in  std_logic;
            contaT              : in  std_logic;
            contaA              : in  std_logic;
            escreveM            : in  std_logic;
            zeraR               : in  std_logic;
            registraR           : in  std_logic;
            botoes              : in  std_logic_vector (3 downto 0);
            controla_led        : in  std_logic;
            jogada_correta      : out std_logic;
            enderecoIgualRodada : out std_logic;
            fimCR               : out std_logic;
            fimA                : out std_logic;
            tem_jogada          : out std_logic;
            fimT                : out std_logic;
            leds                : out std_logic_vector(3 downto 0);
            db_tem_jogada       : out std_logic;
            db_contagem         : out std_logic_vector (3 downto 0);
            db_memoria          : out std_logic_vector (3 downto 0);
            db_jogada_feita     : out std_logic_vector (3 downto 0);
            db_rodada           : out std_logic_vector (3 downto 0)
        );
    end component;

    component unidade_controle is
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
            controla_led        : out std_logic;
            ganhou              : out std_logic;
            perdeu	            : out std_logic;
            pronto              : out std_logic;
            db_estado           : out std_logic_vector(3 downto 0);
            db_timeout          : out std_logic
        );
    end component;

    component hexa7seg is
        port (
            hexa : in  std_logic_vector(3 downto 0);
            sseg : out std_logic_vector(6 downto 0)
        );
    end component hexa7seg;

    signal s_contaA : std_logic;
    signal s_contaCR : std_logic;
    signal s_contaC : std_logic;
    signal s_contaE : std_logic;
    signal s_contaT : std_logic;
    signal s_controla_led : std_logic;
    signal s_db_tem_jogada : std_logic;
    signal s_enderecoIgualRodada : std_logic;
    signal s_fimA : std_logic;
    signal s_fimCR : std_logic;
    signal s_fim : std_logic;
    signal s_fimT : std_logic;
    signal s_igual : std_logic;
    signal s_jogada_correta : std_logic;
    signal s_jogada : std_logic;
    signal s_registraR : std_logic;
    signal s_tem_jogada : std_logic;
    signal s_timeout : std_logic;
    signal s_zeraA : std_logic;
    signal s_zeraCR : std_logic;
    signal s_zeraE : std_logic;
    signal s_zeraR : std_logic;
    signal s_zeraT : std_logic;

    signal s_db_contagem : std_logic_vector(3 downto 0);
    signal s_db_memoria : std_logic_vector(3 downto 0);
    signal s_db_jogada_feita : std_logic_vector(3 downto 0);
    signal s_db_rodada : std_logic_vector(3 downto 0);
    signal s_db_estado : std_logic_vector(3 downto 0);

begin

    FD: fluxo_dados
        port map
        (
            clock => clock,
            zeraE => s_zeraE,
            zeraCR => s_zeraCR,
            zeraT => s_zeraT,
            zeraA => s_zeraA,
            contaE => s_contaE,
            contaCR => s_contaCR,
            contaT => s_contaT,
            contaA => s_contaA,
            escreveM => '0',
            zeraR => s_zeraR,
            registraR => s_registraR,
            botoes => botoes,
            controla_led => s_controla_led,
            jogada_correta => s_jogada_correta,
            enderecoIgualRodada => s_enderecoIgualRodada,
            fimCR => s_fimCR,
            fimA => s_fimA,
            tem_jogada => s_tem_jogada,
            fimT => s_fimT,
            leds => leds,
            db_tem_jogada => db_tem_jogada,
            db_contagem => s_db_contagem,
            db_memoria => s_db_memoria,
            db_jogada_feita => s_db_jogada_feita,
            db_rodada => s_db_rodada
        );

    UC: unidade_controle
        port map
        (
            clock => clock,
            reset => reset,
            iniciar => iniciar,
            enderecoIgualRodada => s_enderecoIgualRodada,
            tem_jogada => s_tem_jogada,
            jogada_correta => s_jogada_correta,
            fimT => s_fimT,
            fimCR => s_fimCR,
            fimA => s_fimA,
            zeraE => s_zeraE,
            zeraCR => s_zeraCR,
            zeraT => s_zeraT,
            zeraA => s_zeraA,
            contaE => s_contaE,
            contaCR => s_contaCR,
            contaT => s_contaT,
            contaA => s_contaA,
            zeraR => s_zeraR,
            registraR => s_registraR,
            controla_led => s_controla_led,
            ganhou => ganhou,
            perdeu => perdeu,
            pronto => pronto,
            db_estado => s_db_estado,
            db_timeout => db_timeout
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

    HEX2: hexa7seg
        port map (
            hexa => s_db_jogada_feita,
            sseg => db_jogada_feita
        );

    HEX3: hexa7seg
        port map (
            hexa => s_db_rodada,
            sseg => db_rodada
        );

    HEX5: hexa7seg
        port map (
            hexa => s_db_estado,
            sseg => db_estado
        );

    db_clock <= clock;
    db_jogada_correta <= s_jogada_correta;
    db_enderecoIgualRodada <= s_enderecoIgualRodada;

end architecture toplevel;











