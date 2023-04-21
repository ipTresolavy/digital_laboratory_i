--------------------------------------------------------------------------
-- Arquivo   : circuito_exp4_tb_modelo.vhd
-- Projeto   : Experiencia 04 - Desenvolvimento de Projeto de
--                              Circuitos Digitais com FPGA
--------------------------------------------------------------------------
-- Descricao : modelo de testbench para simulação com ModelSim
--
--             implementa um Cenário de Teste do circuito
--             com dois erros nas duas primeiras rodadas
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
entity braille_teacher_tb2 is
end entity;

architecture tb of braille_teacher_tb2 is

  -- Componente a ser testado (Device Under Test -- DUT)
  component braille_teacher
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
        memoria_ou_jogada      : out std_logic_vector(6 downto 0); -- HEX4
        db_clock               : out std_logic; -- Analog Discovery DIO3
        db_tem_jogada          : out std_logic; -- Analog Discovery DIO4
        db_enderecoIgualRodada : out std_logic; -- Analog Discovery DIO9
        db_contagem            : out std_logic_vector(3 downto 0); -- LEDR9 até LEDR6
        db_rodada              : out std_logic_vector(3 downto 0); -- LEDR3 até LEDR0
        db_estado              : out std_logic_vector(6 downto 0)  -- HEX5
    );
  end component;

  ---- Declaracao de sinais de entrada para conectar o componente
  signal clk_in          : std_logic := '0';
  signal rst_in          : std_logic := '0';
  signal iniciar_in      : std_logic := '0';
  signal resposta_in     : std_logic := '0';
  signal botoes_in       : std_logic_vector(5 downto 0) := "111111";
  signal dado_escrita_in : std_logic_vector(5 downto 0) := "000000";

  ---- Declaracao dos sinais de saida
  signal aguarda_escrita_out     : std_logic := '0';
  signal erros_out               : std_logic_vector(13 downto 0);
  signal tempoMedio_out          : std_logic_vector(13 downto 0);
  signal fimDeJogo_out           : std_logic := '0';
  signal errou_jogada_out        : std_logic := '0';
  signal acertou_jogada_out      : std_logic := '0';
  signal clock_out               : std_logic := '0';
  signal tem_jogada_out          : std_logic := '0';
  signal enderecoIgualRodada_out : std_logic := '0';
  signal contagem_out            : std_logic_vector(3 downto 0) := "0000";
  signal memoria_ou_jogada_out   : std_logic_vector(6 downto 0) := "0000000";
  signal rodada_out              : std_logic_vector(3 downto 0) := "0000";
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
        resposta               : std_logic;
        botoes                 : std_logic_vector (5 downto 0);
        dado_escrita           : std_logic_vector (5 downto 0);
        ciclos_de_clock_antes  : natural;
        ciclos_de_clock_depois : natural;
    end record;

    type casos_teste_array is array (natural range <>) of caso_teste_type;
    constant casos_teste : casos_teste_array := (
        -- Q
        (1  , '0', '0', '0', "111111", "111110", 1500, 1500),
        (2  , '0', '0', '0', "000001", "111111", 1000, 1000),
        -- R
        (3  , '0', '0', '0', "000001", "101110", 1500, 1500),
        (4  , '0', '0', '0', "111110", "111111", 1000, 1000),
        (5  , '0', '0', '0', "000001", "111111", 1000, 1000),
        -- reinicialização
        (6  , '1', '0', '0', "000100", "111111", 1000, 1000),
        (7  , '0', '1', '0', "000100", "111111", 1000, 1000)
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
          resposta        => resposta_in,
          botoes          => botoes_in,
          dado_escrita    => dado_escrita_in,
          aguarda_escrita => aguarda_escrita_out,
          erros           => erros_out,
          tempoMedio      => tempoMedio_out,
          fimDeJogo       => fimDeJogo_out,
          errou_jogada    => errou_jogada_out,
          acertou_jogada  => acertou_jogada_out,
          memoria_ou_jogada   => memoria_ou_jogada_out,
          db_clock        => clock_out,
          db_tem_jogada   => tem_jogada_out,
          db_enderecoIgualRodada  => enderecoIgualRodada_out,
          db_contagem             => contagem_out,
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
            rst_in <= not casos_teste(i).reset;
            iniciar_in <= not casos_teste(i).iniciar;
            resposta_in <= casos_teste(i).resposta;
            botoes_in <= not casos_teste(i).botoes;
            dado_escrita_in <= casos_teste(i).dado_escrita;

            wait for casos_teste(i).ciclos_de_clock_antes*clockPeriod;

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
