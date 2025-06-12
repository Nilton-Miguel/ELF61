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

entity Eq02_ULA is
	port(

		-- 17/12/24 - Nilton - operadores da ULA expandidos para 32 bit

		in_A: 		in unsigned(31 downto 0);
		in_B: 		in unsigned(31 downto 0);

		-- 18/12/24 - Nilton - op aumentado para 3 bits (4 operacoes a mais)
		op: 		in unsigned (2 downto 0);

		out_ULA: 	out unsigned(31 downto 0);
		flag_z: 	out std_logic;
		flag_gt: 	out std_logic;

		-- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
		shift_amount	:	in unsigned(4  downto 0)
	);
end entity;

architecture Eq02_ULA_arch of Eq02_ULA is

	-- 17/12/24 - Nilton - operandos da ULA expandidos para 32 bit
	signal sig_out_mux: unsigned(31 downto 0) := x"00000000";

begin

	sig_out_mux <=

		-- 18/12/24 - Nilton - op aumentado para 3 bits (4 operacoes a mais)
		(in_A + in_B) 			when op="000" else
		(in_A - in_B) 			when op="001" else
		(in_A / in_B) 			when op="010" and 	in_B/=x"00000000" 	else
		(in_A xor in_B) 		when op="011" else

		-- 18/12/24 - Nilton - acrescentei as operacoes de shift
		-- 19/12/24 - Nilton - operacoes de shift alteradas para levar em conta o sinal de shift amount
		(shift_left(in_A, to_integer(shift_amount)))	when op="100" else
		x"00000000";

	out_ULA <= sig_out_mux;

	flag_z <= 
		'1' when sig_out_mux=x"00000000" else
		'0';
	
	flag_gt <=
		'1' when in_A>in_B else
		'0';

end architecture;
