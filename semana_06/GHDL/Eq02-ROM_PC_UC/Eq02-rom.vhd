-- ---------------------------------------------------------------------------
-- ELF61 - Arquitetura e Organizacao de Computadores

-- Equipe 02 - 01/12/2024

-- Ana Paula Rodrigues Raimundo     - 1862197
-- Joao Vitor Santos Anacleto       - 1802836
-- Nilton Miguel Guimaraes de Souza - 2237164
-- ---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port( 
        clk : in std_logic;
        add : in unsigned(15 downto 0);
        instruction : out unsigned(7 downto 0) := x"00"
    );
end entity;

architecture a_rom of rom is

    type mem is array (0 to 127) of unsigned(7 downto 0);
    constant conteudo_rom : mem := (

        0  => x"00",
        1  => x"00",
        2  => x"00",
        3  => x"00",
        4  => x"89",
        5  => x"ff",
        6  => x"ff",
        7  => x"ff",
        8  => x"ff",
        9  => x"00",
        10 => x"00",
        11 => x"00",
        12 => x"80",

        others => (others=>'0')
    );

    begin

        process(clk)
        begin
            if(rising_edge(clk)) then
                instruction <= conteudo_rom(to_integer(add));
            end if;
        end process;

end architecture;
