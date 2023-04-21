--------------------------------------------------------------------------
-- Arquivo   : circuito_exp4_tb_modelo.vhd
-- Projeto   : Experiencia 04 - Desenvolvimento de Projeto de
--                              Circuitos Digitais com FPGA
--------------------------------------------------------------------------
-- Descricao : modelo de testbench para simulação com ModelSim
--
--             implementa um Cenário de Teste do circuito
--             com acerto em todas as jogadas e reinicialização
--             do circuito
--------------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     01/02/2020  1.0     Edson Midorikawa  criacao
--     27/01/2021  1.1     Edson Midorikawa  revisao
--     27/01/2022  1.2     Edson Midorikawa  revisao e adaptacao
--     11/03/2023  2.0     Pontes Tresolavy  revisao e adaptacao
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

-- entidade do testbench
entity braille_teacher_tb1 is
end entity;

architecture tb of braille_teacher_tb1 is

  -- Componente a ser testado (Device Under Test -- DUT)
  component braille_teacher
    port (
        clock                  : in  std_logic;
        reset                  : in  std_logic;
        iniciar                : in  std_logic;
        botoes                 : in  std_logic_vector(5 downto 0);
        dado_escrita           : in  std_logic_vector(5 downto 0);
        aguarda_escrita        : out std_logic;
        erros                  : out std_logic_vector(13 downto 0); -- HEX1 e HEX0
        fimDeJogo              : out std_logic; -- Analog Discovery DIO8
        errou_jogada           : out std_logic; -- Analog Discovery DIO5
        acertou_jogada         : out std_logic; -- Analog Discovery DIO6
        db_clock               : out std_logic; -- Analog Discovery DIO3
        db_tem_jogada          : out std_logic; -- Analog Discovery DIO4
        db_enderecoIgualRodada : out std_logic; -- Analog Discovery DIO9
        db_contagem            : out std_logic_vector(3 downto 0); -- LEDR9 até LEDR6
        db_memoria             : out std_logic_vector(13 downto 0); -- HEX3 e HEX2
        db_jogada_feita        : out std_logic_vector(5 downto 0); -- LEDR5 até LEDR0
        db_rodada              : out std_logic_vector(6 downto 0); -- HEX4
        db_estado              : out std_logic_vector(6 downto 0) -- HEX5
    );
  end component;

  ---- Declaracao de sinais de entrada para conectar o componente
  signal clk_in          : std_logic := '0';
  signal rst_in          : std_logic := '0';
  signal iniciar_in      : std_logic := '0';
  signal botoes_in       : std_logic_vector(5 downto 0) := "111111";
  signal dado_escrita_in : std_logic_vector(5 downto 0) := "000000";

  ---- Declaracao dos sinais de saida
  signal aguarda_escrita_out     : std_logic := '0';
  signal erros_out               : std_logic_vector(13 downto 0);
  signal fimDeJogo_out           : std_logic := '0';
  signal errou_jogada_out        : std_logic := '0';
  signal acertou_jogada_out      : std_logic := '0';
  signal clock_out               : std_logic := '0';
  signal tem_jogada_out          : std_logic := '0';
  signal enderecoIgualRodada_out : std_logic := '0';
  signal contagem_out            : std_logic_vector(3 downto 0) := "0000";
  signal memoria_out             : std_logic_vector(13 downto 0) := "00000000000000";
  signal jogada_feita_out        : std_logic_vector(5 downto 0) := "000000";
  signal rodada_out              : std_logic_vector(6 downto 0) := "0000000";
  signal estado_out              : std_logic_vector(6 downto 0) := "0000000";

  -- Configurações do clock
  signal keep_simulating: std_logic := '0'; -- delimita o tempo de geração do clock
  constant clockPeriod : time := 1 ms;     -- frequencia 1kHz

  -- Identificacao de casos de teste
  signal caso : integer := 0;

    type caso_teste_type is record
        id                     : natural;
        reset                  : std_logic;
        iniciar                : std_logic;
        botoes                 : std_logic_vector (5 downto 0);
        dado_escrita           : std_logic_vector (5 downto 0);
        ciclos_de_clock_antes  : natural;
        ciclos_de_clock_depois : natural;
    end record;

    type casos_teste_array is array (natural range <>) of caso_teste_type;
    constant casos_teste : casos_teste_array := (
        -- A
        (1  , '0', '0', "000000", "100000", 1500, 1500),
        (2  , '0', '0', "100000", "000000", 1000, 1000),
        -- B
        (3  , '0', '0', "000000", "101000", 1500, 1500),
        (4  , '0', '0', "100000", "111111", 1000, 1000),
        (5  , '0', '0', "101000", "000000", 1000, 1000),
        -- C
        (6  , '0', '0', "000000", "110000", 1500, 1500),
        (7  , '0', '0', "100000", "111111", 1500, 1500),
        (8  , '0', '0', "101000", "111111", 1000, 1000),
        (9  , '0', '0', "110000", "000000", 1000, 1000),
        -- D
        (10 , '0', '0', "000000", "110100", 1500, 1500),
        (11 , '0', '0', "100000", "111111", 1500, 1500),
        (12 , '0', '0', "101000", "111111", 1000, 1000),
        (13 , '0', '0', "110000", "111111", 1000, 1000),
        (14 , '0', '0', "110100", "000000", 1000, 1000),
        -- E
        (15 , '0', '0', "000000", "100100", 1500, 1500),
        (16 , '0', '0', "100000", "111111", 1500, 1500),
        (17 , '0', '0', "101000", "111111", 1000, 1000),
        (18 , '0', '0', "110000", "111111", 1000, 1000),
        (19 , '0', '0', "110100", "111111", 1000, 1000),
        (20 , '0', '0', "100100", "000000", 1000, 1000),
        -- F
        (21 , '0', '0', "000000", "111000", 1500, 1500),
        (22 , '0', '0', "100000", "111111", 1500, 1500),
        (23 , '0', '0', "101000", "111111", 1000, 1000),
        (24 , '0', '0', "110000", "111111", 1000, 1000),
        (25 , '0', '0', "110100", "111111", 1000, 1000),
        (26 , '0', '0', "100100", "101010", 1000, 1000),
        (27 , '0', '0', "111000", "000000", 1000, 1000),
        -- G
        (28 , '0', '0', "000000", "111100", 1500, 1500),
        (29 , '0', '0', "100000", "111111", 1500, 1500),
        (30 , '0', '0', "101000", "111111", 1000, 1000),
        (31 , '0', '0', "110000", "111111", 1000, 1000),
        (32 , '0', '0', "110100", "111111", 1000, 1000),
        (33 , '0', '0', "100100", "101010", 1000, 1000),
        (34 , '0', '0', "111000", "000000", 1000, 1000),
        (35 , '0', '0', "111100", "000000", 1000, 1000),
        -- H
        (36 , '0', '0', "000000", "101100", 1500, 1500),
        (37 , '0', '0', "100000", "111111", 1500, 1500),
        (38 , '0', '0', "101000", "111111", 1000, 1000),
        (39 , '0', '0', "110000", "111111", 1000, 1000),
        (40 , '0', '0', "110100", "111111", 1000, 1000),
        (41 , '0', '0', "100100", "101010", 1000, 1000),
        (42 , '0', '0', "111000", "000000", 1000, 1000),
        (43 , '0', '0', "111100", "000000", 1000, 1000),
        (44 , '0', '0', "101100", "000000", 1000, 1000),
        -- I
        (45 , '0', '0', "000000", "011000", 1500, 1500),
        (46 , '0', '0', "100000", "111111", 1500, 1500),
        (47 , '0', '0', "101000", "111111", 1000, 1000),
        (48 , '0', '0', "110000", "111111", 1000, 1000),
        (49 , '0', '0', "110100", "111111", 1000, 1000),
        (50 , '0', '0', "100100", "101010", 1000, 1000),
        (51 , '0', '0', "111000", "000000", 1000, 1000),
        (52 , '0', '0', "111100", "000000", 1000, 1000),
        (53 , '0', '0', "101100", "000000", 1000, 1000),
        (54 , '0', '0', "011000", "000000", 1000, 1000),
        -- J
        (55 , '0', '0', "000000", "011100", 1500, 1500),
        (56 , '0', '0', "100000", "111111", 1500, 1500),
        (57 , '0', '0', "101000", "111111", 1000, 1000),
        (58 , '0', '0', "110000", "111111", 1000, 1000),
        (59 , '0', '0', "110100", "111111", 1000, 1000),
        (60 , '0', '0', "100100", "101010", 1000, 1000),
        (61 , '0', '0', "111000", "000000", 1000, 1000),
        (62 , '0', '0', "111100", "000000", 1000, 1000),
        (63 , '0', '0', "101100", "000000", 1000, 1000),
        (64 , '0', '0', "011000", "000000", 1000, 1000),
        (65 , '0', '0', "011100", "000000", 1000, 1000),
        -- K
        (66 , '0', '0', "000000", "100010", 1500, 1500),
        (67 , '0', '0', "100000", "111111", 1500, 1500),
        (68 , '0', '0', "101000", "111111", 1000, 1000),
        (69 , '0', '0', "110000", "111111", 1000, 1000),
        (70 , '0', '0', "110100", "111111", 1000, 1000),
        (71 , '0', '0', "100100", "101010", 1000, 1000),
        (72 , '0', '0', "111000", "000000", 1000, 1000),
        (73 , '0', '0', "111100", "000000", 1000, 1000),
        (74 , '0', '0', "101100", "000000", 1000, 1000),
        (75 , '0', '0', "011000", "000000", 1000, 1000),
        (76 , '0', '0', "011100", "000000", 1000, 1000),
        (77 , '0', '0', "100010", "000000", 1000, 1000),
        -- L
        (78 , '0', '0', "000000", "101010", 1500, 1500),
        (79 , '0', '0', "100000", "111111", 1500, 1500),
        (80 , '0', '0', "101000", "111111", 1000, 1000),
        (81 , '0', '0', "110000", "111111", 1000, 1000),
        (82 , '0', '0', "110100", "111111", 1000, 1000),
        (83 , '0', '0', "100100", "101010", 1000, 1000),
        (84 , '0', '0', "111000", "000000", 1000, 1000),
        (85 , '0', '0', "111100", "000000", 1000, 1000),
        (86 , '0', '0', "101100", "000000", 1000, 1000),
        (87 , '0', '0', "011000", "000000", 1000, 1000),
        (88 , '0', '0', "011100", "000000", 1000, 1000),
        (89 , '0', '0', "100010", "000000", 1000, 1000),
        (90 , '0', '0', "101010", "000000", 1000, 1000),
        -- M
        (91 , '0', '0', "000000", "110010", 1500, 1500),
        (92 , '0', '0', "100000", "111111", 1500, 1500),
        (93 , '0', '0', "101000", "111111", 1000, 1000),
        (94 , '0', '0', "110000", "111111", 1000, 1000),
        (95 , '0', '0', "110100", "111111", 1000, 1000),
        (96 , '0', '0', "100100", "101010", 1000, 1000),
        (97 , '0', '0', "111000", "000000", 1000, 1000),
        (98 , '0', '0', "111100", "000000", 1000, 1000),
        (99 , '0', '0', "101100", "000000", 1000, 1000),
        (100, '0', '0', "011000", "000000", 1000, 1000),
        (101, '0', '0', "011100", "000000", 1000, 1000),
        (102, '0', '0', "100010", "000000", 1000, 1000),
        (103, '0', '0', "101010", "000000", 1000, 1000),
        (104, '0', '0', "110010", "000000", 1000, 1000),
        -- N
        (105, '0', '0', "000000", "110110", 1500, 1500),
        (106, '0', '0', "100000", "111111", 1500, 1500),
        (107, '0', '0', "101000", "111111", 1000, 1000),
        (108, '0', '0', "110000", "111111", 1000, 1000),
        (109, '0', '0', "110100", "111111", 1000, 1000),
        (110, '0', '0', "100100", "101010", 1000, 1000),
        (111, '0', '0', "111000", "000000", 1000, 1000),
        (112, '0', '0', "111100", "000000", 1000, 1000),
        (113, '0', '0', "101100", "000000", 1000, 1000),
        (114, '0', '0', "011000", "000000", 1000, 1000),
        (115, '0', '0', "011100", "000000", 1000, 1000),
        (116, '0', '0', "100010", "000000", 1000, 1000),
        (117, '0', '0', "101010", "000000", 1000, 1000),
        (118, '0', '0', "110010", "000000", 1000, 1000),
        (119, '0', '0', "110110", "000000", 1000, 1000),
        -- O
        (120, '0', '0', "000000", "100110", 1500, 1500),
        (121, '0', '0', "100000", "111111", 1500, 1500),
        (122, '0', '0', "101000", "111111", 1000, 1000),
        (123, '0', '0', "110000", "111111", 1000, 1000),
        (124, '0', '0', "110100", "111111", 1000, 1000),
        (125, '0', '0', "100100", "101010", 1000, 1000),
        (126, '0', '0', "111000", "000000", 1000, 1000),
        (127, '0', '0', "111100", "000000", 1000, 1000),
        (128, '0', '0', "101100", "000000", 1000, 1000),
        (129, '0', '0', "011000", "000000", 1000, 1000),
        (130, '0', '0', "011100", "000000", 1000, 1000),
        (131, '0', '0', "100010", "000000", 1000, 1000),
        (132, '0', '0', "101010", "000000", 1000, 1000),
        (133, '0', '0', "110010", "000000", 1000, 1000),
        (134, '0', '0', "110110", "000000", 1000, 1000),
        (135, '0', '0', "100110", "000000", 1000, 1000),
        -- P
        (136, '0', '0', "000000", "111010", 1500, 1500),
        (137, '0', '0', "100000", "111111", 1500, 1500),
        (138, '0', '0', "101000", "111111", 1000, 1000),
        (139, '0', '0', "110000", "111111", 1000, 1000),
        (140, '0', '0', "110100", "111111", 1000, 1000),
        (141, '0', '0', "100100", "101010", 1000, 1000),
        (142, '0', '0', "111000", "000000", 1000, 1000),
        (143, '0', '0', "111100", "000000", 1000, 1000),
        (144, '0', '0', "101100", "000000", 1000, 1000),
        (145, '0', '0', "011000", "000000", 1000, 1000),
        (146, '0', '0', "011100", "000000", 1000, 1000),
        (147, '0', '0', "100010", "000000", 1000, 1000),
        (148, '0', '0', "101010", "000000", 1000, 1000),
        (149, '0', '0', "110010", "000000", 1000, 1000),
        (150, '0', '0', "110110", "000000", 1000, 1000),
        (151, '0', '0', "100110", "000000", 1000, 1000),
        (152, '0', '0', "111010", "000000", 1500, 1500),
        -- reset e iniciar
        (153, '1', '0', "000000", "000000", 1000, 1000),
        (154, '0', '1', "000000", "000000", 1000, 1000)
    );

begin
  -- Gerador de clock: executa enquanto 'keep_simulating = 1', com o período especificado.
  -- Quando keep_simulating=0, clock é interrompido, bem como a simulação de eventos
  clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;

  ---- DUT para Simulacao
  DUT: braille_teacher
       port map
       (
          clock           => clk_in,
          reset           => rst_in,
          iniciar         => iniciar_in,
          botoes          => botoes_in,
          dado_escrita    => dado_escrita_in,
          aguarda_escrita => aguarda_escrita_out,
          erros           => erros_out,
          fimDeJogo       => fimDeJogo_out,
          errou_jogada    => errou_jogada_out,
          acertou_jogada  => acertou_jogada_out,
          db_clock        => clock_out,
          db_tem_jogada   => tem_jogada_out,
          db_enderecoIgualRodada  => enderecoIgualRodada_out,
          db_contagem        => contagem_out,
          db_memoria   => memoria_out,
          db_jogada_feita => jogada_feita_out,
          db_rodada => rodada_out,
          db_estado => estado_out
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

    -- espera para inicio dos testes
    wait for 10*clockPeriod;
    wait until falling_edge(clk_in);

    -- Cenario de Teste - acerta todas as jogadas

      for i in casos_teste'range loop

            assert false report "Caso de teste " & integer'image(casos_teste(i).id) severity note;

            caso <= casos_teste(i).id;
            rst_in <= casos_teste(i).reset;
            iniciar_in <= casos_teste(i).iniciar;

            dado_escrita_in <= casos_teste(i).dado_escrita;

            if(casos_teste(i).botoes /= "000000") then
                for j in botoes_in'range loop
                        if(casos_teste(i).botoes(j) /= '0') then
                            botoes_in(j) <= not casos_teste(i).botoes(j);
                            wait for 3*clockPeriod;
                        end if;
                end loop;
            else
                    wait for casos_teste(i).ciclos_de_clock_depois*clockPeriod;
            end if;

            botoes_in <= "111111";
            dado_escrita_in <= "000000";

            wait for casos_teste(i).ciclos_de_clock_depois*clockPeriod;

            assert caso = casos_teste(i).id;

        end loop;

    ---- final do testbench
    assert false report "fim da simulacao" severity note;
    keep_simulating <= '0';

    wait; -- fim da simulação: processo aguarda indefinidamente
  end process;

end architecture;
