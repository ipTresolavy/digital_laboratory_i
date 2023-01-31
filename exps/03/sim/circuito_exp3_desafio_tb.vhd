--------------------------------------------------------------------
-- Arquivo   : circuito_exp3_tb.vhd
-- Projeto   : Experiencia 3 - Projeto de uma Unidade de Controle
--------------------------------------------------------------------
-- Descricao : testbench para circuito da experiencia 3
--
--             1) plano de teste: 16 casos de teste
--
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

entity circuito_exp3_desafio_tb is
end entity;

architecture tb of circuito_exp3_desafio_tb is

  -- Componente a ser testado (Device Under Test -- DUT)
    component circuito_exp3_desafio is
    port (
        clock       : in std_logic;
        reset       : in std_logic;
        iniciar     : in std_logic;
        chaves      : in std_logic_vector (3 downto 0);
        pronto      : out std_logic;
        acertou     : out std_logic;
        errou       : out std_logic;
        db_igual    : out std_logic;
        db_iniciar  : out std_logic;
        db_contagem : out std_logic_vector (6 downto 0);
        db_memoria  : out std_logic_vector (6 downto 0);
        db_chaves   : out std_logic_vector (6 downto 0);
        db_estado   : out std_logic_vector (6 downto 0)
    );
    end component;

  -- Declaração de sinais para conectar o componente a ser testado (DUT)
  --   valores iniciais para fins de simulacao (GHDL ou ModelSim)
  signal clock_in         : std_logic := '0';
  signal reset_in         : std_logic := '0';
  signal iniciar_in       : std_logic := '0';
  signal chaves_in        : std_logic_vector (3 downto 0) := "0000";
  signal pronto_out       : std_logic := '0';
  signal acertou_out      : std_logic := '0';
  signal errou_out        : std_logic := '0';
  signal db_igual_out     : std_logic := '0';
  signal db_iniciar_out   : std_logic := '0';
  signal db_contagem_out  : std_logic_vector (6 downto 0) := "0000000";
  signal db_memoria_out   : std_logic_vector (6 downto 0) := "0000000";
  signal db_chaves_out    : std_logic_vector (6 downto 0) := "0000000";
  signal db_estado_out    : std_logic_vector (6 downto 0) := "0000000";

  -- Configurações do clock
  signal keep_simulating : std_logic := '0'; -- delimita o tempo de geração do clock
  constant clockPeriod   : time := 20 ns;

  -- Identificacao de casos de teste
  signal caso : integer := 0;

    type caso_teste_type is record
        id        : natural;
        reset     : std_logic;
        iniciar   : std_logic;
        chaves    : std_logic_vector (3 downto 0);
    end record;

    type casos_teste_array is array (natural range <>) of caso_teste_type;
    constant casos_teste : casos_teste_array := (
        --(0, '1', '0', "0000"), -- c.i.
        (1 ,'1', '0', "0000"), -- teste 1 - reinicia a máquina de estados
        (2 , '0', '1', "0000"), -- teste 2 - zera registrador (inicial)
        (3 , '0', '0', "0000"), -- teste 3 - zera contador e registrador (preparacao)
        (4 , '0', '0', "0001"), -- teste 4-19 - acerta as jogadas (registra -> comparacao -> proximo -> registra)
        (5 , '0', '0', "0010"),
        (6 , '0', '0', "0100"),
        (7 , '0', '0', "1000"),
        (8 , '0', '0', "0100"),
        (9 , '0', '0', "0010"),
        (10, '0', '0', "0001"),
        (11, '0', '0', "0001"),
        (12, '0', '0', "0010"),
        (13, '0', '0', "0010"),
        (14, '0', '0', "0100"),
        (15, '0', '0', "0100"),
        (16, '0', '0', "1000"),
        (17, '0', '0', "1000"),
        (18, '0', '0', "0001"),
        (19, '0', '0', "0100"),
        (20, '0', '0', "0000"), -- teste 20 - garantir que máquina esteja no estado fim com saída acertou (fim)
        (21, '0', '0', "0000"), -- teste 21 - garantir que máquina esteja no estado inicial (inicial)
        (22 , '0', '1', "0000"), -- teste 22 - zera registrador (inicial)
        (23 , '0', '0', "0000"), -- teste 23 - zera contador e registrador (preparacao)
        (24 , '0', '0', "0001"), -- teste 24-27 - acerta as jogadas (registra -> comparacao -> proximo -> registra)
        (25 , '0', '0', "0010"),
        (26 , '0', '0', "0100"),
        (27 , '0', '0', "1111"), -- teste 27 - erra a jogada
        --(28 , '0', '0', "1111"), -- teste 28 - erra a jogada
        (28 , '0', '0', "1111"), -- teste 29 - assegura estado fim e saída errou
        (29 , '0', '0', "0000")  -- teste 30 - assegura estado inicial
    );

begin

  -- Gerador de clock: executa enquanto 'keep_simulating = 1', com o período especificado.
  -- Quando keep_simulating=0, clock é interrompido, bem como a simulação de eventos
  clock_in <= (not clock_in) and keep_simulating after clockPeriod/2;

  -- Conecta DUT (Device Under Test)
  dut: circuito_exp3_desafio
       port map(
           clock         =>  clock_in,
           reset         =>  reset_in,
           iniciar       =>  iniciar_in,
           chaves        =>  chaves_in,
           pronto        =>  pronto_out,
           acertou       =>  acertou_out,
           errou         =>  errou_out,
           db_igual      =>  db_igual_out,
           db_iniciar    =>  db_iniciar_out,
           db_contagem   =>  db_contagem_out,
           db_memoria    =>  db_memoria_out,
           db_chaves     =>  db_chaves_out,
           db_estado     =>  db_estado_out
       );

  -- geracao dos sinais de entrada (estimulos)
  stimulus: process is
  begin

    assert false report "Inicio da simulacao" severity note;
    keep_simulating <= '1';

    ---- condicoes iniciais ----------------
    caso       <= 0;
    reset_in   <= '0';
    iniciar_in <= '0';
    chaves_in  <= "0000";
    wait for clockPeriod;

      for i in casos_teste'range loop
            assert false report "Caso de teste " & integer'image(casos_teste(i).id) severity note;
            caso <= casos_teste(i).id;
            reset_in <= casos_teste(i).reset;
            iniciar_in <= casos_teste(i).iniciar;
            chaves_in <= casos_teste(i).chaves;
            assert caso = casos_teste(i).id;

            if((i < 3) or (i > 19 and i < 23)) then
                wait until falling_edge(clock_in);
            elsif(i = 26) then
                wait for 2*clockPeriod;
            elsif(i = 20 or i = 29) then
                wait for clockPeriod;
            else
                wait for 3*clockPeriod;
            end if;
        end loop;

        keep_simulating <= '0';
        assert false report "Fim da simulacao" severity note;
        wait; -- fim da simulação: aguarda indefinidamente
    end process;

end architecture;
