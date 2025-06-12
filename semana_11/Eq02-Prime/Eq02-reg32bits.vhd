-- ---------------------------------------------------------------------------
-- ELF61 - Arquitetura e Organizacao de Computadores

-- Equipe 02 - 17/12/2024

-- Ana Paula Rodrigues Raimundo     - 1862197
-- Joao Vitor Santos Anacleto       - 1802836
-- Nilton Miguel Guimaraes de Souza - 2237164
-- ---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq02_reg32bits is
	port(
		clk: 	in std_logic;
		rst: 	in std_logic;
		wr_en: 	in std_logic;

		-- 17/12/24 - Nilton - registrador expandido para 32 bit
		data_in: 	in 	unsigned(31 downto 0);
		data_out: 	out unsigned(31 downto 0)
	);
end entity;

architecture a_Eq02_reg32bits of Eq02_reg32bits is

    -- 17/12/24 - Nilton - registrador expandido para 32 bit
	signal registro: unsigned(31 downto 0) := x"00000000";

begin

	process(clk, rst, wr_en)
	begin

		if rst='1' then

            -- 17/12/24 - Nilton - registro de 32 bit
			registro <= x"00000000";

		elsif wr_en='1' then

			if rising_edge(clk) then

				registro <= data_in;

			end if;

		end if;

	end process;

	data_out <= registro;

end architecture;
