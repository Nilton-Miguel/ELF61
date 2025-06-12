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

entity Eq02_regFile is

	port
	(
		clk: in 	std_logic;
		rst: in 	std_logic;
		we3: in 	std_logic;

		-- 17/12/24 - Nilton - enderecos dos registrados aumentados para 4 bits

		a1: in 		unsigned(3 downto 0);
		a2: in 		unsigned(3 downto 0);
		a3: in 		unsigned(3 downto 0);

		-- 17/12/24 - Nilton - dado aumentado de 16 para 32 bit

		wd3: in 	unsigned(31 downto 0);
		rd1: out 	unsigned(31 downto 0);
		rd2: out 	unsigned(31 downto 0)
	);

end entity;

architecture a_Eq02_regFile of Eq02_regFile is

	-- 17/12/24 - Nilton - registradores convertidos para 32 bit
	component Eq02_reg32bits is

		port
		(
			clk: in 		std_logic;
			rst: in 		std_logic;
			wr_en: in 		std_logic;
			data_in: in 	unsigned(31 downto 0);
			data_out: out 	unsigned(31 downto 0)
		);

	end component;

	signal r0_wr_en: std_logic 	:= '0';
	signal r1_wr_en: std_logic 	:= '0';
	signal r2_wr_en: std_logic 	:= '0';
	signal r3_wr_en: std_logic 	:= '0';
	signal r4_wr_en: std_logic 	:= '0';
	signal r5_wr_en: std_logic 	:= '0';
	signal r6_wr_en: std_logic 	:= '0';
	signal r7_wr_en: std_logic 	:= '0';

	signal r0_data_out: unsigned(31 downto 0) := x"00000000";
	signal r1_data_out: unsigned(31 downto 0) := x"00000000";
	signal r2_data_out: unsigned(31 downto 0) := x"00000000";
	signal r3_data_out: unsigned(31 downto 0) := x"00000000";
	signal r4_data_out: unsigned(31 downto 0) := x"00000000";
	signal r5_data_out: unsigned(31 downto 0) := x"00000000";
	signal r6_data_out: unsigned(31 downto 0) := x"00000000";
	signal r7_data_out: unsigned(31 downto 0) := x"00000000";

	-- 17/12/24 - Nilton - acrescentei os 8 novos registradores

	signal r8_wr_en: 	std_logic 	:= '0';
	signal r9_wr_en: 	std_logic 	:= '0';
	signal r10_wr_en: 	std_logic 	:= '0';
	signal r11_wr_en: 	std_logic 	:= '0';
	signal r12_wr_en: 	std_logic 	:= '0';
	signal r13_wr_en: 	std_logic 	:= '0';
	signal r14_wr_en: 	std_logic 	:= '0';
	signal r15_wr_en: 	std_logic 	:= '0';

	signal r8_data_out: 	unsigned(31 downto 0) 	:= x"00000000";
	signal r9_data_out: 	unsigned(31 downto 0) 	:= x"00000000";
	signal r10_data_out: 	unsigned(31 downto 0) 	:= x"00000000";
	signal r11_data_out: 	unsigned(31 downto 0) 	:= x"00000000";
	signal r12_data_out: 	unsigned(31 downto 0) 	:= x"00000000";
	signal r13_data_out: 	unsigned(31 downto 0) 	:= x"00000000";
	signal r14_data_out: 	unsigned(31 downto 0) 	:= x"00000000";
	signal r15_data_out: 	unsigned(31 downto 0) 	:= x"00000000";
	
begin
	
	r0: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r0_wr_en,
		-- 17/12/24 - Nilton - probido sobrescrever o r0
		data_in => x"00000000",
		data_out => r0_data_out
	);
	r1: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r1_wr_en,
		data_in => wd3,
		data_out => r1_data_out
	);
	r2: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r2_wr_en,
		data_in => wd3,
		data_out => r2_data_out
	);
	r3: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r3_wr_en,
		data_in => wd3,
		data_out => r3_data_out
	);
	r4: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r4_wr_en,
		data_in => wd3,
		data_out => r4_data_out
	);
	r5: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r5_wr_en,
		data_in => wd3,
		data_out => r5_data_out
	);
	r6: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r6_wr_en,
		data_in => wd3,
		data_out => r6_data_out
	);
	r7: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r7_wr_en,
		data_in => wd3,
		data_out => r7_data_out
	);

	-- 17/12/24 - Nilton - mapeamento dos novos registradores

	r8: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r8_wr_en,
		data_in => wd3,
		data_out => r8_data_out
	);
	r9: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r9_wr_en,
		data_in => wd3,
		data_out => r9_data_out
	);
	r10: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r10_wr_en,
		data_in => wd3,
		data_out => r10_data_out
	);
	r11: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r11_wr_en,
		data_in => wd3,
		data_out => r11_data_out
	);
	r12: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r12_wr_en,
		data_in => wd3,
		data_out => r12_data_out
	);
	r13: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r13_wr_en,
		data_in => wd3,
		data_out => r13_data_out
	);
	r14: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r14_wr_en,
		data_in => wd3,
		data_out => r14_data_out
	);
	r15: Eq02_reg32bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r15_wr_en,
		data_in => wd3,
		data_out => r15_data_out
	);
	
	-- 17/12/24 - Nilton - proibido escrever no r0
	r0_wr_en <= '0';
	r1_wr_en <= we3 when a3 = x"1" else '0';
	r2_wr_en <= we3 when a3 = x"2" else '0';
	r3_wr_en <= we3 when a3 = x"3" else '0';
	r4_wr_en <= we3 when a3 = x"4" else '0';
	r5_wr_en <= we3 when a3 = x"5" else '0';
	r6_wr_en <= we3 when a3 = x"6" else '0';
	r7_wr_en <= we3 when a3 = x"7" else '0';

	-- 17/12/24 - Nilton - ativa de escrita dos novos registradores

	r8_wr_en 	<= we3 when a3 = x"8" else '0';
	r9_wr_en 	<= we3 when a3 = x"9" else '0';
	r10_wr_en 	<= we3 when a3 = x"A" else '0';
	r11_wr_en 	<= we3 when a3 = x"B" else '0';
	r12_wr_en 	<= we3 when a3 = x"C" else '0';
	r13_wr_en 	<= we3 when a3 = x"D" else '0';
	r14_wr_en 	<= we3 when a3 = x"E" else '0';
	r15_wr_en 	<= we3 when a3 = x"F" else '0';

	rd1 <=
		r0_data_out 	when a1 = x"0" else
		r1_data_out 	when a1 = x"1" else
		r2_data_out 	when a1 = x"2" else
		r3_data_out 	when a1 = x"3" else
		r4_data_out 	when a1 = x"4" else
		r5_data_out 	when a1 = x"5" else
		r6_data_out 	when a1 = x"6" else
		r7_data_out 	when a1 = x"7" else

		-- 17/12/24 - Nilton - selecao de saida dos novos registradores

		r8_data_out 	when a1 = x"8" else
		r9_data_out 	when a1 = x"9" else
		r10_data_out 	when a1 = x"A" else
		r11_data_out 	when a1 = x"B" else
		r12_data_out 	when a1 = x"C" else
		r13_data_out 	when a1 = x"D" else
		r14_data_out 	when a1 = x"E" else
		r15_data_out 	when a1 = x"F" else
		x"00000000";

	rd2 <=
		r0_data_out 	when a2 = x"0" else
		r1_data_out 	when a2 = x"1" else
		r2_data_out 	when a2 = x"2" else
		r3_data_out 	when a2 = x"3" else
		r4_data_out 	when a2 = x"4" else
		r5_data_out 	when a2 = x"5" else
		r6_data_out 	when a2 = x"6" else
		r7_data_out 	when a2 = x"7" else

		-- 17/12/24 - Nilton - selecao de saida dos novos registradores

		r8_data_out 	when a1 = x"8" else
		r9_data_out 	when a1 = x"9" else
		r10_data_out 	when a1 = x"A" else
		r11_data_out 	when a1 = x"B" else
		r12_data_out 	when a1 = x"C" else
		r13_data_out 	when a1 = x"D" else
		r14_data_out 	when a1 = x"E" else
		r15_data_out 	when a1 = x"F" else
		x"00000000";
		
end architecture;
