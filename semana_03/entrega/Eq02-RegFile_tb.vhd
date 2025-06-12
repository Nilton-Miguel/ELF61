-- ---------------------------------------------------------------------------
-- ELF61 - Arquitetura e Organizacao de Computadores

-- Equipe 02 - 10/11/2024

-- Ana Paula Rodrigues Raimundo     - 1862197
-- Joao Vitor Santos Anacleto       - 1802836
-- Nilton Miguel Guimaraes de Souza - 2237164
-- ---------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regFile_tb is
end entity;

architecture a_regFile_tb of regFile_tb is

	component banco_8x16 is

		port
		(
			a1, a2, a3          : in    unsigned(2  downto 0);
        	wd3                 : in    unsigned(15 downto 0);
        	clk, rst, we3       : in    std_logic;

        	rd1, rd2            : out   unsigned(15 downto 0)
		);

	end component;

	signal s_clk: std_logic;
	signal s_rst: std_logic;
	signal s_we3: std_logic;

	signal s_a1: unsigned(2 downto 0);
	signal s_a2: unsigned(2 downto 0);
	signal s_a3: unsigned(2 downto 0);

	signal s_wd3: unsigned(15 downto 0);

	signal s_rd1: unsigned(15 downto 0);
	signal s_rd2: unsigned(15 downto 0);

begin

	uut: banco_8x16 port map
	(
		clk => s_clk,
		rst => s_rst,
		we3 => s_we3,
		a1  => s_a1,
		a2  => s_a2,
		a3  => s_a3,
		wd3 => s_wd3,
		rd1 => s_rd1,
		rd2 => s_rd2
	);

	-- sinal de clock
	process
	begin

		s_clk <= '0';
		wait for 50 ns;

		s_clk <= '1';
		wait for 50 ns;

	end process;

	-- sinal de reset
	process
	begin

		s_rst <= '1';
		wait for 100 ns;
		s_rst <= '0';
		
		wait for 4000 ns;

		s_rst <= '1';
		wait for 100 ns;
		s_rst <= '0';
		
		wait;

	end process;

	-- sinal de write enable
	process
	begin

		s_we3 <= '0';
		wait for 100 ns;

		s_we3 <= '1';
		wait for 100 ns;

	end process;

	--sinais dos casos de teste
	process
	begin

		-- escrever x0186 x2197

		s_a1  <= "000";
		s_a2  <= "000";
		s_a3  <= "001";
		s_wd3 <= x"0186";
		wait for 200 ns;

		s_a1  <= "000";
		s_a2  <= "000";
		s_a3  <= "010";
		s_wd3 <= x"2197";
		wait for 200 ns;

		-- escrever x0180 x2836

		s_a1  <= "000";
		s_a2  <= "000";
		s_a3  <= "011";
		s_wd3 <= x"0180";
		wait for 200 ns;

		s_a1  <= "000";
		s_a2  <= "000";
		s_a3  <= "100";
		s_wd3 <= x"2836";
		wait for 200 ns;

		-- escrever x0223 x7164

		s_a1  <= "000";
		s_a2  <= "000";
		s_a3  <= "101";
		s_wd3 <= x"0223";
		wait for 200 ns;

		s_a1  <= "000";
		s_a2  <= "000";
		s_a3  <= "110";
		s_wd3 <= x"7164";
		wait for 200 ns;

		-- leituras em rd2

		s_a1  <= "000";
		s_a2  <= "001";
		s_a3  <= "000";
		s_wd3 <= x"0000";
		wait for 200 ns;

		s_a2  <= "010";
		wait for 200 ns;

		s_a2  <= "011";
		wait for 200 ns;

		s_a2  <= "100";
		wait for 200 ns;

		s_a2  <= "101";
		wait for 200 ns;

		s_a2  <= "110";
		wait for 200 ns;

		-- leituras em rd1

		s_a1  <= "001";
		s_a2  <= "000";
		wait for 200 ns;

		s_a1  <= "010";
		wait for 200 ns;

		s_a1  <= "011";
		wait for 200 ns;

		s_a1  <= "100";
		wait for 200 ns;

		s_a1  <= "101";
		wait for 200 ns;

		s_a1  <= "110";
		wait for 200 ns;

		wait;

	end process;

end architecture;
