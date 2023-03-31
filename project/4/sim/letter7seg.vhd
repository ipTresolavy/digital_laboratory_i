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
        s_sseg : std_logic_vector(6 downto 0);
begin

  s_sseg <= "1110111" when hexa="100000" else
            "1111100" when hexa="101000" else
            "0111001" when hexa="110000" else
            "1011110" when hexa="110100" else
            "1111001" when hexa="100100" else
            "1110001" when hexa="111000" else
            "0111101" when hexa="111100" else
            "1110110" when hexa="101100" else
            "0110000" when hexa="011000" else
            "0011110" when hexa="011100" else
            "1110101" when hexa="100010" else
            "0111000" when hexa="101010" else
            "0010101" when hexa="110010" else
            "0110111" when hexa="110110" else
            "0111111" when hexa="100110" else
            "1110011" when hexa="111010" else
            "1101011" when hexa="111110" else
            "0110011" when hexa="000001" else
            "1101101" when hexa="011010" else
            "1111000" when hexa="011110" else
            "0111110" when hexa="100011" else
            "0111110" when hexa="101011" else
            "0101010" when hexa="011101" else
            "1110110" when hexa="110011" else
            "1101110" when hexa="110111" else
            "1011011" when hexa="100111" else
            "1111111";

  sseg <= not s_sseg;

end architecture comportamental;
