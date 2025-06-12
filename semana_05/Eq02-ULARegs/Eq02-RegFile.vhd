-- ---------------------------------------------------------------------------
-- ELF61 - Arquitetura e Organizacao de Computadores

-- Equipe 02 - 24/11/2024

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
		clk: in std_logic;
		rst: in std_logic;
		we3: in std_logic;

		a1: in unsigned(2 downto 0);
		a2: in unsigned(2 downto 0);
		a3: in unsigned(2 downto 0);

		wd3: in unsigned(15 downto 0);

		rd1: out unsigned(15 downto 0);
		rd2: out unsigned(15 downto 0)
	);

end entity;

architecture a_Eq02_regFile of Eq02_regFile is
	
	component Eq02_reg16bits is

		port
		(
			clk: in std_logic;
			rst: in std_logic;
			wr_en: in std_logic;
			data_in: in unsigned(15 downto 0);
			data_out: out unsigned(15 downto 0)
		);

	end component;

	signal r0_wr_en: std_logic := '0';
	signal r1_wr_en: std_logic := '0';
	signal r2_wr_en: std_logic := '0';
	signal r3_wr_en: std_logic := '0';
	signal r4_wr_en: std_logic := '0';
	signal r5_wr_en: std_logic := '0';
	signal r6_wr_en: std_logic := '0';
	signal r7_wr_en: std_logic := '0';

	signal r0_data_out: unsigned(15 downto 0) := x"0000";
	signal r1_data_out: unsigned(15 downto 0) := x"0000";
	signal r2_data_out: unsigned(15 downto 0) := x"0000";
	signal r3_data_out: unsigned(15 downto 0) := x"0000";
	signal r4_data_out: unsigned(15 downto 0) := x"0000";
	signal r5_data_out: unsigned(15 downto 0) := x"0000";
	signal r6_data_out: unsigned(15 downto 0) := x"0000";
	signal r7_data_out: unsigned(15 downto 0) := x"0000";
	
begin
	
	r0: Eq02_reg16bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r0_wr_en,
		data_in => wd3,
		data_out => r0_data_out
	);
	r1: Eq02_reg16bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r1_wr_en,
		data_in => wd3,
		data_out => r1_data_out
	);
	r2: Eq02_reg16bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r2_wr_en,
		data_in => wd3,
		data_out => r2_data_out
	);
	r3: Eq02_reg16bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r3_wr_en,
		data_in => wd3,
		data_out => r3_data_out
	);
	r4: Eq02_reg16bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r4_wr_en,
		data_in => wd3,
		data_out => r4_data_out
	);
	r5: Eq02_reg16bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r5_wr_en,
		data_in => wd3,
		data_out => r5_data_out
	);
	r6: Eq02_reg16bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r6_wr_en,
		data_in => wd3,
		data_out => r6_data_out
	);
	r7: Eq02_reg16bits port map
	(
		clk => clk,
		rst => rst,
		wr_en => r7_wr_en,
		data_in => wd3,
		data_out => r7_data_out
	);

	r0_wr_en <= we3 when a3 = x"0" else '0';
	r1_wr_en <= we3 when a3 = x"1" else '0';
	r2_wr_en <= we3 when a3 = x"2" else '0';
	r3_wr_en <= we3 when a3 = x"3" else '0';
	r4_wr_en <= we3 when a3 = x"4" else '0';
	r5_wr_en <= we3 when a3 = x"5" else '0';
	r6_wr_en <= we3 when a3 = x"6" else '0';
	r7_wr_en <= we3 when a3 = x"7" else '0';

	rd1 <=
		r0_data_out when a1 = x"0" else
		r1_data_out when a1 = x"1" else
		r2_data_out when a1 = x"2" else
		r3_data_out when a1 = x"3" else
		r4_data_out when a1 = x"4" else
		r5_data_out when a1 = x"5" else
		r6_data_out when a1 = x"6" else
		r7_data_out when a1 = x"7" else
		x"0000";

	rd2 <=
		r0_data_out when a2 = x"0" else
		r1_data_out when a2 = x"1" else
		r2_data_out when a2 = x"2" else
		r3_data_out when a2 = x"3" else
		r4_data_out when a2 = x"4" else
		r5_data_out when a2 = x"5" else
		r6_data_out when a2 = x"6" else
		r7_data_out when a2 = x"7" else
		x"0000";
		
end architecture;
