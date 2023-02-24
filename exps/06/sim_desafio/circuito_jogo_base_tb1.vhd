--------------------------------------------------------------------------
-- Arquivo   : circuito_exp4_tb_modelo.vhd
-- Projeto   : Experiencia 04 - Desenvolvimento de Projeto de
--                              Circuitos Digitais com FPGA
--------------------------------------------------------------------------
-- Descricao : modelo de testbench para simulação com ModelSim
--
--             implementa um Cenário de Teste do circuito
--             com 4 jogadas certas e erro na quinta jogada
--------------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     01/02/2020  1.0     Edson Midorikawa  criacao
--     27/01/2021  1.1     Edson Midorikawa  revisao
--     27/01/2022  1.2     Edson Midorikawa  revisao e adaptacao --------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

-- entidade do testbench
entity circuito_jogo_base_tb1 is
end entity;

architecture tb of circuito_jogo_base_tb1 is

  -- Componente a ser testado (Device Under Test -- DUT)
  component circuito_jogo_base
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
        db_estado              : out std_logic_vector(6 downto 0);
        db_escreve             : out std_logic
    );
  end component;

  ---- Declaracao de sinais de entrada para conectar o componente
  signal clk_in     : std_logic := '0';
  signal rst_in     : std_logic := '0';
  signal iniciar_in : std_logic := '0';
  signal botoes_in  : std_logic_vector(3 downto 0) := "0000";

  ---- Declaracao dos sinais de saida
  signal leds_out   : std_logic_vector(3 downto 0) := "0000";
  signal pronto_out     : std_logic := '0';
  signal ganhou_out    : std_logic := '0';
  signal perdeu_out      : std_logic := '0';
  signal clock_out      : std_logic := '0';
  signal tem_jogada_out : std_logic := '0';
  signal jogada_correta_out : std_logic := '0';
  signal enderecoIgualRodada_out : std_logic := '0';
  signal timeout_out : std_logic := '0';
  signal contagem_out   : std_logic_vector(6 downto 0) := "0000000";
  signal memoria_out    : std_logic_vector(6 downto 0) := "0000000";
  signal jogada_feita_out     : std_logic_vector(6 downto 0) := "0000000";
  signal rodada_out     : std_logic_vector(6 downto 0) := "0000000";
  signal estado_out     : std_logic_vector(6 downto 0) := "0000000";
  signal jogadafeita_out     : std_logic_vector(6 downto 0) := "0000000";
  signal escreve_memoria_out     : std_logic := '0';

  -- Configurações do clock
  signal keep_simulating: std_logic := '0'; -- delimita o tempo de geração do clock
  constant clockPeriod : time := 1 ms;     -- frequencia 50MHz

  -- Identificacao de casos de teste
  signal caso : integer := 0;

    type caso_teste_type is record
        id                     : natural;
        reset                  : std_logic;
        iniciar                : std_logic;
        botoes                 : std_logic_vector (3 downto 0);
        ciclos_de_clock_antes  : natural;
        ciclos_de_clock_depois : natural;
    end record;

    type casos_teste_array is array (natural range <>) of caso_teste_type;
    constant casos_teste : casos_teste_array := (
        (0 , '0', '0', "0001", 15, 15),
        (2 , '0', '0', "0001", 10, 10),

        (1 , '0', '0', "0001", 15, 15),
        (2 , '0', '0', "0001", 10, 10),
        (5 , '0', '0', "0001", 10, 10),

        (3 , '0', '0', "0001", 15, 15),
        (4 , '0', '0', "0001", 15, 15),
        (5 , '0', '0', "0001", 10, 10),
        (7 , '0', '0', "0001", 10, 10),
        
        (4  , '0', '0', "0001", 15, 15),
        (5  , '0', '0', "0001", 15, 15),
        (6  , '0', '0', "0001", 10, 10),
        (7  , '0', '0', "0001", 10, 10),
        (12 , '0', '0', "0001", 10, 10),

        (8  , '0', '0', "0001", 15, 15),
        (9  , '0', '0', "0001", 15, 15),
        (10 , '0', '0', "0001", 10, 10),
        (11 , '0', '0', "0001", 10, 10),
        (12 , '0', '0', "0001", 10, 10),
        (18 , '0', '0', "0001", 10, 10),

        (13 , '0', '0', "0001", 15, 15),
        (14 , '0', '0', "0001", 15, 15),
        (15 , '0', '0', "0001", 10, 10),
        (16 , '0', '0', "0001", 10, 10),
        (17 , '0', '0', "0001", 10, 10),
        (18 , '0', '0', "0001", 10, 10),
        (25 , '0', '0', "0001", 10, 10),

        (19 , '0', '0', "0000", 15, 15),
        (20 , '0', '0', "0001", 15, 15),
        (21 , '0', '0', "0001", 10, 10),
        (22 , '0', '0', "0001", 10, 10),
        (23 , '0', '0', "0001", 10, 10),
        (24 , '0', '0', "0001", 10, 10),
        (25 , '0', '0', "0001", 10, 10),
        (33 , '0', '0', "0001", 10, 10),

        (26 , '0', '0', "0001", 15, 15),
        (27 , '0', '0', "0001", 15, 15),
        (28 , '0', '0', "0001", 10, 10),
        (29 , '0', '0', "0001", 10, 10),
        (30 , '0', '0', "0001", 10, 10),
        (31 , '0', '0', "0001", 10, 10),
        (32 , '0', '0', "0001", 10, 10),
        (33 , '0', '0', "0001", 10, 10),
        (42 , '0', '0', "0010", 10, 10),

        (34 , '0', '0', "0001", 15, 15),
        (35 , '0', '0', "0001", 15, 15),
        (36 , '0', '0', "0001", 10, 10),
        (37 , '0', '0', "0001", 10, 10),
        (38 , '0', '0', "0001", 10, 10),
        (39 , '0', '0', "0001", 10, 10),
        (40 , '0', '0', "0001", 10, 10),
        (41 , '0', '0', "0001", 10, 10),
        (42 , '0', '0', "0010", 10, 10),
        (52 , '0', '0', "0010", 10, 10),

        (43 , '0', '0', "0001", 15, 15),
        (44 , '0', '0', "0001", 15, 15),
        (45 , '0', '0', "0001", 10, 10),
        (46 , '0', '0', "0001", 10, 10),
        (47 , '0', '0', "0001", 10, 10),
        (48 , '0', '0', "0001", 10, 10),
        (49 , '0', '0', "0001", 10, 10),
        (50 , '0', '0', "0001", 10, 10),
        (51 , '0', '0', "0010", 10, 10),
        (52 , '0', '0', "0010", 10, 10),
        (63 , '0', '0', "0010", 10, 10),

        (53 , '0', '0', "0001", 15, 15),
        (54 , '0', '0', "0001", 15, 15),
        (55 , '0', '0', "0001", 10, 10),
        (56 , '0', '0', "0001", 10, 10),
        (57 , '0', '0', "0001", 10, 10),
        (58 , '0', '0', "0001", 10, 10),
        (59 , '0', '0', "0001", 10, 10),
        (60 , '0', '0', "0001", 10, 10),
        (61 , '0', '0', "0010", 10, 10),
        (62 , '0', '0', "0010", 10, 10),
        (63 , '0', '0', "0010", 10, 10),
        (75 , '0', '0', "0010", 10, 10),

        (64 , '0', '0', "0001", 15, 15),
        (65 , '0', '0', "0001", 15, 15),
        (66 , '0', '0', "0001", 10, 10),
        (67 , '0', '0', "0001", 10, 10),
        (68 , '0', '0', "0001", 10, 10),
        (69 , '0', '0', "0001", 10, 10),
        (70 , '0', '0', "0001", 10, 10),
        (71 , '0', '0', "0001", 10, 10),
        (72 , '0', '0', "0010", 10, 10),
        (73 , '0', '0', "0010", 10, 10),
        (74 , '0', '0', "0010", 10, 10),
        (75 , '0', '0', "0010", 10, 10),
        (88 , '0', '0', "0010", 10, 10),

        (76  , '0', '0', "0001", 15, 15),
        (77  , '0', '0', "0001", 15, 15),
        (78  , '0', '0', "0001", 10, 10),
        (79  , '0', '0', "0001", 10, 10),
        (80  , '0', '0', "0001", 10, 10),
        (81  , '0', '0', "0001", 10, 10),
        (82  , '0', '0', "0001", 10, 10),
        (83  , '0', '0', "0001", 10, 10),
        (84  , '0', '0', "0010", 10, 10),
        (85  , '0', '0', "0010", 10, 10),
        (86  , '0', '0', "0010", 10, 10),
        (87  , '0', '0', "0010", 10, 10),
        (88  , '0', '0', "0010", 10, 10),
        (102 , '0', '0', "0010", 10, 10),

        (89  , '0', '0', "0001", 15, 15),
        (90  , '0', '0', "0001", 15, 15),
        (91  , '0', '0', "0001", 10, 10),
        (92  , '0', '0', "0001", 10, 10),
        (93  , '0', '0', "0001", 10, 10),
        (94  , '0', '0', "0001", 10, 10),
        (95  , '0', '0', "0001", 10, 10),
        (96  , '0', '0', "0001", 10, 10),
        (97  , '0', '0', "0010", 10, 10),
        (98  , '0', '0', "0010", 10, 10),
        (99  , '0', '0', "0010", 10, 10),
        (100 , '0', '0', "0010", 10, 10),
        (101 , '0', '0', "0010", 10, 10),
        (102 , '0', '0', "0010", 10, 10),
        (117 , '0', '0', "0010", 10, 10),

        (103 , '0', '0', "0001", 15, 15),
        (104 , '0', '0', "0001", 15, 15),
        (105 , '0', '0', "0001", 10, 10),
        (106 , '0', '0', "0001", 10, 10),
        (107 , '0', '0', "0001", 10, 10),
        (108 , '0', '0', "0001", 10, 10),
        (109 , '0', '0', "0001", 10, 10),
        (110 , '0', '0', "0001", 10, 10),
        (111 , '0', '0', "0010", 10, 10),
        (112 , '0', '0', "0010", 10, 10),
        (113 , '0', '0', "0010", 10, 10),
        (114 , '0', '0', "0010", 10, 10),
        (115 , '0', '0', "0010", 10, 10),
        (116 , '0', '0', "0010", 10, 10),
        (117 , '0', '0', "0010", 10, 10),
        (133 , '0', '0', "0010", 10, 10),

        (118 , '0', '0', "0001", 15, 15),
        (119 , '0', '0', "0001", 15, 15),
        (120 , '0', '0', "0001", 10, 10),
        (121 , '0', '0', "0001", 10, 10),
        (122 , '0', '0', "0001", 10, 10),
        (123 , '0', '0', "0001", 10, 10),
        (124 , '0', '0', "0001", 10, 10),
        (125 , '0', '0', "0001", 10, 10),
        (126 , '0', '0', "0010", 10, 10),
        (127 , '0', '0', "0010", 10, 10),
        (128 , '0', '0', "0010", 10, 10),
        (129 , '0', '0', "0010", 10, 10),
        (130 , '0', '0', "0010", 10, 10),
        (131 , '0', '0', "0010", 10, 10),
        (132 , '0', '0', "0010", 10, 10),
        (133 , '0', '0', "0010", 10, 10)

begin
  -- Gerador de clock: executa enquanto 'keep_simulating = 1', com o período especificado.
  -- Quando keep_simulating=0, clock é interrompido, bem como a simulação de eventos
  clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;

  ---- DUT para Simulacao
  dut: circuito_jogo_base
       port map
       (
          clock           => clk_in,
          reset           => rst_in,
          iniciar         => iniciar_in,
          botoes          => botoes_in,
          leds            => leds_out,
          ganhou          => ganhou_out,
          pronto          => pronto_out,
          perdeu          => perdeu_out,
          db_clock        => clock_out,
          db_tem_jogada   => tem_jogada_out,
          db_jogada_correta => jogada_correta_out,
          db_enderecoIgualRodada  => enderecoIgualRodada_out,
          db_timeout  => timeout_out,
          db_contagem        => contagem_out,
          db_memoria   => memoria_out,
          db_jogada_feita => jogada_feita_out,
          db_rodada => rodada_out,
          db_estado => estado_out,
          db_escreve => escreve_memoria_out
       );

  ---- Gera sinais de estimulo para a simulacao
  -- Cenario de Teste : todas as jogadas
  stimulus: process is
  begin

    -- inicio da simulacao
    assert false report "inicio da simulacao" severity note;
    keep_simulating <= '1';  -- inicia geracao do sinal de clock

    -- gera pulso de reset (1 periodo de clock)
    rst_in <= '1';
    wait for clockPeriod;
    rst_in <= '0';


    -- pulso do sinal de Iniciar (muda na borda de descida do clock)
    wait until falling_edge(clk_in);
    iniciar_in <= '1';
    wait until falling_edge(clk_in);
    iniciar_in <= '0';

    -- espera até amostra da jogada inicial acabar
    wait until estado_out="0110000";

    -- espera para inicio dos testes
    wait for 10*clockPeriod;
    wait until falling_edge(clk_in);

    -- Cenario de Teste - acerta todas as jogadas

      for i in casos_teste'range loop

            assert false report "Caso de teste " & integer'image(casos_teste(i).id) severity note;

            caso <= casos_teste(i).id;
            rst_in <= casos_teste(i).reset;
            iniciar_in <= casos_teste(i).iniciar;
            botoes_in <= casos_teste(i).botoes;

            wait for casos_teste(i).ciclos_de_clock_antes*clockPeriod;

            botoes_in <= "0000";

            wait for casos_teste(i).ciclos_de_clock_depois*clockPeriod;

            assert caso = casos_teste(i).id;

        end loop;

    ---- final do testbench
    assert false report "fim da simulacao" severity note;
    keep_simulating <= '0';

    wait; -- fim da simulação: processo aguarda indefinidamente
  end process;

end architecture;
