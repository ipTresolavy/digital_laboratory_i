--------------------------------------------------------------------
-- Arquivo   : a_digital_system.vhd
-- Projeto   : Experiencia 3 - Projeto de uma unidade de controle
--------------------------------------------------------------------
-- Descricao : implementacao em vhdl do circuito integrado descrito no projeto
--
--             1) codificação VHDL (maquina de Moore)
--
--             2) definicao de valores da saida de depuracao
--                
-- 
--------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor                           Descricao
--     28/01/2022  1.0     Thiago Souza e Igor Pontes      versao inicial
--------------------------------------------------------------------
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY circuito_exp3 IS
  PORT (
    clock : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    iniciar : IN STD_LOGIC;
    chaves : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    pronto : OUT STD_LOGIC;
    db_igual : OUT STD_LOGIC;
    db_iniciar : OUT STD_LOGIC;
    db_contagem : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    db_memoria : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    db_chaves : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    db_estado : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE estrutural OF circuito_exp3 IS
  COMPONENT unidade_controle
    PORT (
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
  END COMPONENT;
END estrutural;