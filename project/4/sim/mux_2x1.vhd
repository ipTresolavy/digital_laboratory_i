library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1 is
    generic (
        constant bit_width: integer := 4
    );
    port(
        a      : in  std_logic_vector(bit_width-1 downto 0);
        b      : in  std_logic_vector(bit_width-1 downto 0);
        sel    : in  std_logic;
        output : out std_logic_vector(bit_width-1 downto 0)
    );
end entity mux_2x1;

architecture combinatorial of mux_2x1 is

begin
    output <= a when sel = '0' else
              b;

end architecture combinatorial;

