----------------------------------------------------------------
-- Arquivo   : letter7seg.vhd
-- Projeto   : Braille Teacher
----------------------------------------------------------------
-- Descricao : decodificador do alfabeto latino braille para
--             display de 7 segmentos
--
-- entrada: letter - letra em braille do alfabeto latino
-- saida:   sseg - codigo de 7 bits para display de 7 segmentos
----------------------------------------------------------------
-- dica de uso: mapeamento para displays da placa DE0-CV
--              bit 6 mais significativo é o bit a esquerda
--              p.ex. sseg(6) -> HEX0[6] ou HEX06
----------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     29/12/2020  1.0     Edson Midorikawa  criacao
--     07/01/2023  1.1     Edson Midorikawa  revisao
--     31/03/2023  2.0     Pontes Tresolavy  criacao para braille
----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity letter7seg is
    port (
        letter : in  std_logic_vector(5 downto 0);
        sseg   : out std_logic_vector(6 downto 0)
    );
end entity letter7seg;

architecture comportamental of letter7seg is
        signal s_sseg : std_logic_vector(6 downto 0);
begin

  s_sseg <= "1110111" when letter="100000" else -- A
            "1111100" when letter="101000" else -- B
            "0111001" when letter="110000" else -- C
            "1011110" when letter="110100" else -- D
            "1111001" when letter="100100" else -- E
            "1110001" when letter="111000" else -- F
            "0111101" when letter="111100" else -- G
            "1110110" when letter="101100" else -- H
            "0110000" when letter="011000" else -- I
            "0011110" when letter="011100" else -- J
            "1110101" when letter="100010" else -- K
            "0111000" when letter="101010" else -- L
            "0010101" when letter="110010" else -- M
            "0110111" when letter="110110" else -- N
            "0111111" when letter="100110" else -- O
            "1110011" when letter="111010" else -- P
            "1101011" when letter="111110" else -- Q
            "0110011" when letter="000001" else -- R
            "1101101" when letter="011010" else -- S
            "1111000" when letter="011110" else -- T
            "0111110" when letter="100011" else -- U
            "0111110" when letter="101011" else -- V
            "0101010" when letter="011101" else -- W
            "1110110" when letter="110011" else -- X
            "1101110" when letter="110111" else -- Y
            "1011011" when letter="100111" else -- Z
            "1111111";

  sseg <= not s_sseg;

end architecture comportamental;
