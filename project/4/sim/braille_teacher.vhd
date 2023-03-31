library ieee;
use ieee.std_logic_1164.all;

entity braille_teacher is
    port (
        clock                  : in  std_logic;
        reset                  : in  std_logic;
        iniciar                : in  std_logic;
        resposta               : in  std_logic;
        botoes                 : in  std_logic_vector(5 downto 0);
        dado_escrita           : in  std_logic_vector(5 downto 0);
        aguarda_escrita        : out std_logic;
        erros                  : out std_logic_vector(13 downto 0); -- HEX1 e HEX0
        tempoMedio             : out std_logic_vector(13 downto 0); -- HEX3 e HEX2
        fimDeJogo              : out std_logic; -- Analog Discovery DIO8
        errou_jogada           : out std_logic; -- Analog Discovery DIO5
        acertou_jogada         : out std_logic; -- Analog Discovery DIO6
        db_clock               : out std_logic; -- Analog Discovery DIO3
        db_tem_jogada          : out std_logic; -- Analog Discovery DIO4
        db_enderecoIgualRodada : out std_logic; -- Analog Discovery DIO9
        db_contagem            : out std_logic_vector(3 downto 0); -- LEDR9 até LEDR6
        db_memoria_ou_jogada   : out std_logic_vector(13 downto 0); -- HEX4
        db_rodada              : out std_logic_vector(6 downto 0); -- LEDR3 até LEDR0
        db_estado              : out std_logic_vector(6 downto 0) -- HEX5
    );
end entity;

architecture toplevel of braille_teacher is

    component fluxo_dados is
        port (
            clock               : in  std_logic;
            zeraE               : in  std_logic;
            zeraCR              : in  std_logic;
            zeraT               : in  std_logic;
            zeraEstat           : in  std_logic;
            contaE              : in  std_logic;
            contaCR             : in  std_logic;
            contaT              : in  std_logic;
            contaErr            : in  std_logic;
            escreveM            : in  std_logic;
            zeraR               : in  std_logic;
            registraR           : in  std_logic;
            registraTempo       : in  std_logic;
            botoes              : in  std_logic_vector (5 downto 0);
            dado_escrita        : in  std_logic_vector (5 downto 0);
            mux_registrador     : in  std_logic;
            jogada_correta      : out std_logic;
            tem_erro            : out std_logic;
            enderecoIgualRodada : out std_logic;
            fimCR               : out std_logic;
            tem_jogada          : out std_logic_vector(5 downto 0);
            tem_escrita         : out std_logic;
            fimT                : out std_logic;
            fimA                : out std_logic;
            erros               : out std_logic_vector(7 downto 0);
            tempoMedio          : out std_logic_vector(7 downto 0);
            db_tem_jogada       : out std_logic;
            db_contagem         : out std_logic_vector (3 downto 0);
            db_memoria          : out std_logic_vector (5 downto 0);
            db_jogada_feita     : out std_logic_vector (5 downto 0);
            db_rodada           : out std_logic_vector (3 downto 0)
        );
    end component;

    component unidade_controle is
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
            fimDeJogo           : out std_logic;
            errou_jogada        : out std_logic;
            acertou_jogada      : out std_logic;
            db_estado           : out std_logic_vector(3 downto 0)
        );
    end component;

    component hexa7seg is
        port (
            hexa : in  std_logic_vector(3 downto 0);
            sseg : out std_logic_vector(6 downto 0)
        );
    end component hexa7seg;

    component letter7seg is
        port (
            letter : in  std_logic_vector(5 downto 0);
            sseg   : out std_logic_vector(6 downto 0)
        );
    end component letter7seg;

    component mux_2x1 is
        generic (
            constant bit_width: integer := 4
        );
        port(
            a      : in  std_logic_vector(bit_width-1 downto 0);
            b      : in  std_logic_vector(bit_width-1 downto 0);
            sel    : in  std_logic;
            output : out std_logic_vector(bit_width-1 downto 0)
        );
    end component mux_2x1;


	signal s_contaCR              : std_logic;
    signal s_contaErr             : std_logic;
    signal s_contaE               : std_logic;
    signal s_contaT               : std_logic;
    signal s_enderecoIgualRodada  : std_logic;
    signal s_escreveM             : std_logic;
    signal s_fimCR                : std_logic;
    signal s_fimT                 : std_logic;
    signal s_fimA                 : std_logic;
    signal s_iniciar              : std_logic;
    signal s_jogada_correta       : std_logic;
    signal s_mux_registrador      : std_logic;
    signal s_registraR            : std_logic;
    signal s_registraTempo        : std_logic;
    signal s_tem_escrita          : std_logic;
    signal s_tem_erro             : std_logic;
    signal s_tem_jogada           : std_logic_vector(5 downto 0);
    signal s_zeraCR               : std_logic;
    signal s_zeraEstat            : std_logic;
    signal s_zeraE                : std_logic;
    signal s_zeraR                : std_logic;
    signal s_zeraT                : std_logic;
    signal s_erros                : std_logic_vector(7 downto 0);
    signal s_tempoMedio           : std_logic_vector(7 downto 0);

    signal s_db_estado            : std_logic_vector (3 downto 0);
    signal s_db_jogada_feita      : std_logic_vector (5 downto 0);
    signal s_db_memoria           : std_logic_vector (5 downto 0);
    signal s_db_memoria_ou_jogada : std_logic_vector (5 downto 0);
    signal s_db_memoria_msn       : std_logic_vector (3 downto 0);
    signal s_db_rodada            : std_logic_vector (3 downto 0);
    signal s_db_tem_jogada        : std_logic;

	 signal s_not_botoes 			: std_logic_vector(5 downto 0);
begin

	s_not_botoes <= not botoes;

    FD: fluxo_dados
        port map
        (
            clock => clock,
            zeraE => s_zeraE,
            zeraCR => s_zeraCR,
            zeraT => s_zeraT,
            zeraEstat => s_zeraEstat,
            contaE => s_contaE,
            contaCR => s_contaCR,
            contaT => s_contaT,
            contaErr => s_contaErr,
            escreveM => s_escreveM,
            zeraR => s_zeraR,
            registraR => s_registraR,
            registraTempo => s_registraTempo,
            botoes => s_not_botoes,
            dado_escrita => dado_escrita,
            mux_registrador => s_mux_registrador,
            jogada_correta => s_jogada_correta,
            tem_erro => s_tem_erro,
            enderecoIgualRodada => s_enderecoIgualRodada,
            fimCR => s_fimCR,
            tem_jogada => s_tem_jogada,
            tem_escrita => s_tem_escrita,
            fimT => s_fimT,
            fimA => s_fimA,
            erros => s_erros,
            tempoMedio => s_tempoMedio,
            db_tem_jogada => db_tem_jogada,
            db_contagem => db_contagem,
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
            tem_escrita => s_tem_escrita,
            jogada_correta => s_jogada_correta,
            tem_erro => s_tem_erro,
            fimT => s_fimT,
            fimA => s_fimA,
            fimCR => s_fimCR,
            zeraE => s_zeraE,
            zeraCR => s_zeraCR,
            zeraT => s_zeraT,
            zeraEstat => s_zeraEstat,
            contaE => s_contaE,
            contaCR => s_contaCR,
            contaT => s_contaT,
            contaErr => s_contaErr,
            registraTempo => s_registraTempo,
            zeraR => s_zeraR,
            registraR => s_registraR,
            mux_registrador => s_mux_registrador,
            ativa_escrita => s_escreveM,
            aguarda_escrita => aguarda_escrita,
            fimDeJogo => fimDeJogo,
            errou_jogada => errou_jogada,
            acertou_jogada => acertou_jogada,
            db_estado => s_db_estado
        );

    HEX0: hexa7seg
        port map (
            hexa => s_erros(3 downto 0),
            sseg => erros(6 downto 0)
        );

    HEX1: hexa7seg
        port map (
            hexa => s_erros(7 downto 4),
            sseg => erros(13 downto 7)
        );

    HEX2: hexa7seg
        port map (
            hexa => s_tempoMedio(3 downto 0),
            sseg => tempoMedio(6 downto 0)
        );

    HEX3: hexa7seg
        port map (
            hexa => s_tempoMedio(7 downto 4),
            sseg => tempoMedio(13 downto 7)
        );

    RESP: mux_2x1
        generic map (6)
            port map (
            a => s_db_jogada_feita,
            b => s_db_memoria,
            sel => resposta,
            output => s_db_memoria_ou_jogada
        );

    HEX4: letter7seg
        port map (
            hexa => s_db_memoria_ou_jogada,
            sseg => db_memoria_ou_jogada
        );

    HEX5: hexa7seg
        port map (
            hexa => s_db_estado,
            sseg => db_estado
        );

    db_clock <= clock;
    db_enderecoIgualRodada <= s_enderecoIgualRodada;

end architecture toplevel;
