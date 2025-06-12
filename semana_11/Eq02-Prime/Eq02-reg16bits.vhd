-- ---------------------------------------------------------------------------
-- ELF61 - Arquitetura e Organizacao de Computadores

-- Equipe 02 - 16/12/2024

-- Ana Paula Rodrigues Raimundo     - 1862197
-- Joao Vitor Santos Anacleto       - 1802836
-- Nilton Miguel Guimaraes de Souza - 2237164
-- ---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq02_reg16bits is
	port(
		clk: 	in std_logic;
		rst: 	in std_logic;
		wr_en: 	in std_logic;
		
		data_in: 	in 	unsigned(15 downto 0);
		data_out: 	out unsigned(15 downto 0)
	);
end entity;

architecture a_Eq02_reg16bits of Eq02_reg16bits is

	signal registro: unsigned(15 downto 0) := x"0000";

begin

	process(clk, rst, wr_en)
	begin

		if rst='1' then

			registro <= x"0000";

		elsif wr_en='1' then

			if rising_edge(clk) then

				registro <= data_in;

			end if;

		end if;

	end process;

	data_out <= registro;

end architecture;
