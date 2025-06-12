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

entity Eq02_ULARegs is
	port(
		clk: in std_logic;
		rst: in std_logic;
		wr_en: in std_logic;

		op: in unsigned(1 downto 0);

		a1: in unsigned(2 downto 0);
		a2: in unsigned(2 downto 0);
		a3: in unsigned(2 downto 0);

		ext_const: in unsigned(15 downto 0);
		ula_src: in std_logic
	);
end entity;

architecture a_Eq02_ULARegs of Eq02_ULARegs is

	component Eq02_RegFile is
		port(
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
	end component;

	component Eq02_ULA is
		port(
			in_A: in unsigned(15 downto 0);
			in_B: in unsigned(15 downto 0);

			op: in unsigned (1 downto 0);

			out_ULA: out unsigned(15 downto 0);
			flag_z: out std_logic;
			flag_gt: out std_logic
		);
	end component;

	signal s_ULAout: unsigned(15 downto 0);

	signal s_flag_z: std_logic;
	signal s_flag_gt: std_logic;

	signal s_rd1: unsigned(15 downto 0);
	signal s_rd2: unsigned(15 downto 0);

	signal s_in_B: unsigned(15 downto 0);

begin

	regs: Eq02_RegFile port map
	(
		clk => clk,
		rst => rst,
		we3 => wr_en,
		a1 => a1,
		a2 => a2,
		a3 => a3,
		wd3 => s_ULAout,
		rd1 => s_rd1,
		rd2 => s_rd2
	);
	ula: Eq02_ULA port map
	(
		in_A => s_rd1,
		in_B => s_in_B,
		op => op,
		out_ULA => s_ULAout,
		flag_z => s_flag_z,
		flag_gt => s_flag_gt
	);

	s_in_B <= 
		s_rd2 when ula_src='0' else
		ext_const when ula_src='1' else
		"0000000000000000";

end architecture;
