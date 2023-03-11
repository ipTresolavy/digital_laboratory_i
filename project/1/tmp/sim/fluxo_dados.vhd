--------------------------------------------------------------------
-- Arquivo   : circuito_exp2_ativ2.vhd.parcial.txt
-- Projeto   : Experiencia 2 - Um Fluxo de Dados Simples
--------------------------------------------------------------------
-- Descricao : ARQUIVO PARCIAL DO
--    Circuito do fluxo de dados da Atividade 2
--
-- COMPLETAR TRECHOS DE CODIGO ABAIXO
--
--    1) contem saidas de depuracao db_contagem e db_memoria
--    2) escolha da arquitetura do componente ram_16x4
--       para simulacao com ModelSim => ram_modelsim
--    3) escolha da arquitetura do componente ram_16x4
--       para sintese com Intel Quartus => ram_mif
--
--------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     11/01/2022  1.0     Edson Midorikawa  versao inicial
--     07/01/2022  1.1     Edson Midorikawa  revisao
--     10/02/2022  1.1.1   Edson Midorikawa  arquivo parcial
--     10/02/2022  1.1.1   Edson Midorikawa  arquivo parcial
--     04/02/2023  2.0     Igor Tresolavy    revisao exp4
--     04/02/2023  3.0     Igor Tresolavy    revisao exp5
--------------------------------------------------------------------
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

entity fluxo_dados is
    port (
        clock               : in  std_logic;
        zeraE               : in  std_logic;
        zeraCR              : in  std_logic;
        zeraT               : in  std_logic;
        zeraA               : in  std_logic;
        zeraP               : in  std_logic;
        contaE              : in  std_logic;
        contaCR             : in  std_logic;
        contaT              : in  std_logic;
        contaA              : in  std_logic;
        contaP              : in  std_logic;
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
        erros                : out std_logic_vector(3 downto 0);
        db_tem_jogada       : out std_logic;
        db_contagem         : out std_logic_vector (3 downto 0);
        db_memoria          : out std_logic_vector (3 downto 0);
        db_jogada_feita     : out std_logic_vector (3 downto 0);
        db_rodada           : out std_logic_vector (3 downto 0)
    );
end entity;

architecture estrutural of fluxo_dados is

  signal s_endereco       : std_logic_vector (3 downto 0);
  signal s_dado           : std_logic_vector (3 downto 0);
  signal s_rodada         : std_logic_vector (3 downto 0);
  signal s_not_zeraE      : std_logic;
  signal s_not_zeraP      : std_logic;
  signal s_not_zeraCR     : std_logic;
  signal s_not_escreve    : std_logic;
  signal s_jogada         : std_logic_vector(3 downto 0);
  signal s_botao_acionado : std_logic;

  component contador_163
    port (
        clock : in  std_logic;
        clr   : in  std_logic;
        ld    : in  std_logic;
        ent   : in  std_logic;
        enp   : in  std_logic;
        D     : in  std_logic_vector (3 downto 0);
        Q     : out std_logic_vector (3 downto 0);
        rco   : out std_logic
    );
  end component;

  component comparador_85
    port (
        i_A3   : in  std_logic;
        i_B3   : in  std_logic;
        i_A2   : in  std_logic;
        i_B2   : in  std_logic;
        i_A1   : in  std_logic;
        i_B1   : in  std_logic;
        i_A0   : in  std_logic;
        i_B0   : in  std_logic;
        i_AGTB : in  std_logic;
        i_ALTB : in  std_logic;
        i_AEQB : in  std_logic;
        o_AGTB : out std_logic;
        o_ALTB : out std_logic;
        o_AEQB : out std_logic
    );
  end component;

  component ram_16x4 is
    port (
       clk          : in  std_logic;
       endereco     : in  std_logic_vector(3 downto 0);
       dado_entrada : in  std_logic_vector(3 downto 0);
       we           : in  std_logic;
       ce           : in  std_logic;
       dado_saida   : out std_logic_vector(3 downto 0)
    );
  end component;

  component registrador_n is
    generic (
        constant N: integer := 8
    );
    port (
        clock  : in  std_logic;
        clear  : in  std_logic;
        enable : in  std_logic;
        D      : in  std_logic_vector (N-1 downto 0);
        Q      : out std_logic_vector (N-1 downto 0)
    );
  end component registrador_n;

  component edge_detector is
    port (
        clock  : in  std_logic;
        reset  : in  std_logic;
        sinal  : in  std_logic;
        pulso  : out std_logic
    );
  end component edge_detector;

  component contador_m is
      generic (
          constant M: integer := 100 -- modulo do contador
      );
      port (
          clock   : in  std_logic;
          zera_as : in  std_logic;
          zera_s  : in  std_logic;
          conta   : in  std_logic;
          Q       : out std_logic_vector(natural(ceil(log2(real(M))))-1 downto 0);
          fim     : out std_logic;
          meio    : out std_logic
      );
  end component contador_m;

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

begin

  -- sinais de controle ativos em alto
  -- sinais dos componentes ativos em baixo
  s_not_zeraE   <= not zeraE;
  s_not_zeraP   <= not zeraP;
  s_not_zeraCR  <= not zeraCR;
  s_not_escreve <= not escreveM;
  s_botao_acionado <= botoes(0) or botoes(1) or botoes(2) or botoes(3);

  ContEnd: contador_163
    port map (
        clock => clock,
        clr   => s_not_zeraE,  -- clr ativo em baixo
        ld    => '1',
        ent   => '1',
        enp   => contaE,
        D     => "0000",
        Q     => s_endereco,
        rco   => open
    );

  ContRod: contador_163
    port map (
        clock => clock,
        clr   => s_not_zeraCR,  -- clr ativo em baixo
        ld    => '1',
        ent   => '1',
        enp   => contaCR,
        D     => "0000",
        Q     => s_rodada,
        rco   => fimCR
    );

  ContP: contador_163
    port map (
        clock => clock,
        clr   => s_not_zeraP,  -- clr ativo em baixo
        ld    => '1',
        ent   => '1',
        enp   => contaP,
        D     => "0000",
        Q     => erros,
        rco   => open
    );

  MemJog: entity work.ram_16x4 (ram_modelsim)
    port map (
       clk          => clock,
       endereco     => s_endereco,
       dado_entrada => s_jogada,
       we           => s_not_escreve, -- we ativo em baixo
       ce           => '0',
       dado_saida   => s_dado
    );

  RegChv: registrador_n
    generic map (4)
    port map (
        clock  => clock,
        clear  => zeraR,
        enable => registraR,
        D      => botoes,
        Q      => s_jogada
    );

  CompJog: comparador_85
    port map (
        i_A3   => s_dado(3),
        i_B3   => s_jogada(3),
        i_A2   => s_dado(2),
        i_B2   => s_jogada(2),
        i_A1   => s_dado(1),
        i_B1   => s_jogada(1),
        i_A0   => s_dado(0),
        i_B0   => s_jogada(0),
        i_AGTB => '0',
        i_ALTB => '0',
        i_AEQB => '1',
        o_AGTB => open, -- saidas nao usadas
        o_ALTB => open,
        o_AEQB => jogada_correta
    );

  CompEnd: comparador_85
    port map (
        i_A3   => s_rodada(3),
        i_B3   => s_endereco(3),
        i_A2   => s_rodada(2),
        i_B2   => s_endereco(2),
        i_A1   => s_rodada(1),
        i_B1   => s_endereco(1),
        i_A0   => s_rodada(0),
        i_B0   => s_endereco(0),
        i_AGTB => '0',
        i_ALTB => '0',
        i_AEQB => '1',
        o_AGTB => open, -- saidas nao usadas
        o_ALTB => open,
        o_AEQB => enderecoIgualRodada
    );

   TemJog: edge_detector
       port map (
        clock => clock,
        reset => zeraCR,
        sinal => s_botao_acionado,
        pulso => tem_jogada
    );

    Timer: contador_m
      generic map (5000)
      port map
      (
        clock => clock,
        zera_as => zeraT,
        zera_s => '0',
        conta => contaT,
        Q => open,
        fim => fimT,
        meio => open
      );

    TimerA: contador_m
      generic map (2000)
      port map
      (
        clock => clock,
        zera_as => zeraA,
        zera_s => '0',
        conta => contaA,
        Q => open,
        fim => fimA,
        meio => open
      );

    mux2x1: mux_2x1
    generic map (4)
    port map
    (
       a => botoes,
       b => s_dado,
       sel => controla_led,
       output => leds
   );

  db_tem_jogada <= s_botao_acionado;
  db_contagem <= s_endereco;
  db_memoria  <= s_dado;
  db_jogada_feita <= s_jogada;
  db_rodada <= s_rodada;

end architecture estrutural;
