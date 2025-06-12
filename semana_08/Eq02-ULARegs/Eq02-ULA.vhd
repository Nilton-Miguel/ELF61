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

entity Eq02_ULA is
	port(
		in_A: in unsigned(15 downto 0);
		in_B: in unsigned(15 downto 0);

		op: in unsigned (1 downto 0);

		out_ULA: out unsigned(15 downto 0);
		flag_z: out std_logic;
		flag_gt: out std_logic
	);
end entity;

architecture Eq02_ULA_arch of Eq02_ULA is

	signal sig_out_mux: unsigned(15 downto 0) := x"0000";

begin

	sig_out_mux <=

		(in_A + in_B) 	when op="00" else
		(in_A - in_B) 	when op="01" else
		(in_A / in_B) 	when op="10" and in_B/=x"0000" else
		(in_A xor in_B) when op="11" else
		X"0000";

	out_ULA <= sig_out_mux;

	flag_z <= 
		'1' when sig_out_mux=X"0000" else
		'0';
	
	flag_gt <=
		'1' when in_A>in_B else
		'0';

end architecture;
