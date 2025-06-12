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

		-- 16/12/2024 - Nilton - mantive por agora a state machine em 2 estados
		-- 16/12/2024 - Nilton - (ciclo 0) fetch da instrucao
		-- 16/12/2024 - Nilton - (ciclo 1) atualizacao do PC com execute da instrucao

		elsif rising_edge(clk) then
			estado <= not estado;

		end if;

	end process;

	step <= estado;

end architecture;
