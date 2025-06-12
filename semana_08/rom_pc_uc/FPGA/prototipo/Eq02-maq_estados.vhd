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

entity maq_estados is
	port(
		clk, rst:       in std_logic;
		step:           out std_logic
	);
end entity;

architecture a_maq_estados of maq_estados is

	signal estado: std_logic := '0';

begin

	process(clk, rst)
	begin

		if rst='1' then
			estado <= '0';

		elsif rising_edge(clk) then
			estado <= not estado;

		end if;

	end process;

	step <= estado;

end architecture;
