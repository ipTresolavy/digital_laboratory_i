1. --------------------------------------------------------------------
2. -- Arquivo   : circuito_exp3.vhd
3. -- Projeto   : Experiencia 3 - Projeto de uma unidade de controle
4. --------------------------------------------------------------------
5. -- Descricao : implementacao em vhdl da entidade topo do projeto
6. --------------------------------------------------------------------
7. -- Revisoes  :
8. --     Data        Versao  Autor                           Descricao
9. --     28/01/2022  1.0     Thiago Souza                    versao inicial
10. --     29/01/2022  1.1     Igor Pontes Tresolavy           versao inicial
11. --------------------------------------------------------------------
12. 
13. library ieee;
14. use ieee.std_logic_1164.all;
15. 
16. entity circuito_exp3 is
17.     port (
18.         clock       : in std_logic;
19.         reset       : in std_logic;
20.         iniciar     : in std_logic;
21.         chaves      : in std_logic_vector (3 downto 0);
22.         pronto      : out std_logic;
23.         db_igual    : out std_logic;
24.         db_iniciar  : out std_logic;
25.         db_contagem : out std_logic_vector (6 downto 0);
26.         db_memoria  : out std_logic_vector (6 downto 0);
27.         db_chaves   : out std_logic_vector (6 downto 0);
28.         db_estado   : out std_logic_vector (6 downto 0)
29.     );
30. end entity;
31. 
32. architecture toplevel of circuito_exp3 is
33. 
34.     component unidade_controle
35.         port (
36.           clock     : in  std_logic;
37.           reset     : in  std_logic;
38.           iniciar   : in  std_logic;
39.           fimC      : in  std_logic;
40.           zeraC     : out std_logic;
41.           contaC    : out std_logic;
42.           zeraR     : out std_logic;
43.           registraR : out std_logic;
44.           pronto    : out std_logic;
45.           db_estado : out std_logic_vector(3 downto 0)
46.         );
47.     end component;
48. 
49.     component fluxo_dados is
50.         port (
51.             clock               : in  std_logic;
52.             zeraC               : in  std_logic;
53.             contaC              : in  std_logic;
54.             escreveM            : in  std_logic;
55.             zeraR               : in  std_logic;
56.             registraR           : in  std_logic;
57.             chaves              : in  std_logic_vector (3 downto 0);
58.             chavesIgualMemoria  : out std_logic;
59.             fimC                : out std_logic;
60.             db_contagem         : out std_logic_vector (3 downto 0);
61.             db_memoria          : out std_logic_vector (3 downto 0);
62.             db_chaves           : out std_logic_vector (3 downto 0)
63.         );
64.     end component;
65. 
66.     component hexa7seg is
67.         port (
68.             hexa : in  std_logic_vector(3 downto 0);
69.             sseg : out std_logic_vector(6 downto 0)
70.         );
71.     end component hexa7seg;
72. 
73.     signal s_zeraC : std_logic;
74.     signal s_contaC : std_logic;
75.     signal s_zeraR : std_logic;
76.     signal s_registraR : std_logic;
77.     signal s_fimC : std_logic;
78. 
79.     signal s_db_contagem : std_logic_vector(3 downto 0);
80.     signal s_db_memoria : std_logic_vector(3 downto 0);
81.     signal s_db_chaves : std_logic_vector(3 downto 0);
82.     signal s_db_estado : std_logic_vector(3 downto 0);
83. 
84. begin
85. 
86.     FD: fluxo_dados
87.         port map (
88.             clock => clock,
89.             zeraC => s_zeraC,
90.             contaC => s_contaC,
91.             escreveM => '0',
92.             zeraR => s_zeraR,
93.             registraR => s_registraR,
94.             chaves => chaves,
95.             chavesIgualMemoria => db_igual,
96.             fimC => s_fimC,
97.             db_contagem => s_db_contagem,
98.             db_memoria => s_db_memoria,
99.             db_chaves => s_db_chaves
100.         );
101. 
102.     UC: unidade_controle
103.         port map (
104.             clock => clock,
105.             reset => reset,
106.             iniciar => iniciar,
107.             fimC => s_fimC,
108.             zeraC => s_zeraC,
109.             contaC => s_contaC,
110.             zeraR => s_zeraR,
111.             registraR => s_registraR,
112.             pronto => pronto,
113.             db_estado => s_db_estado
114.         );
115. 
116.     HEX2: hexa7seg
117.         port map (
118.             hexa => s_db_chaves,
119.             sseg => db_chaves
120.         );
121. 
122.     HEX0: hexa7seg
123.         port map (
124.             hexa => s_db_contagem,
125.             sseg => db_contagem
126.         );
127. 
128.     HEX1: hexa7seg
129.         port map (
130.             hexa => s_db_memoria,
131.             sseg => db_memoria
132.         );
133. 
134.     HEX5: hexa7seg
135.         port map (
136.             hexa => s_db_estado,
137.             sseg => db_estado
138.         );
139. 
140.     db_iniciar <= iniciar;
141. 
142. end toplevel;
143. 
