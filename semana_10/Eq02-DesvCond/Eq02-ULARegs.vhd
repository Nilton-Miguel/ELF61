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

entity Eq02_ULARegs is
	port(

		clk: 	in std_logic;
		rst: 	in std_logic;
		wr_en: 	in std_logic;

		-- 18/12/24 - Nilton - operacoes da ULA extendidas para shifts
		op: in unsigned(2 downto 0);

		-- 17/12/24 - Nilton - enderecos do banco aumentados para 4 bits

		a1: in unsigned(3 downto 0);
		a2: in unsigned(3 downto 0);
		a3: in unsigned(3 downto 0);

		-- 17/12/24 - Nilton - constante numerica aumentada para 32 bit

		external_const: 	in unsigned(31 downto 0);
		ula_B_src: 			in std_logic;

		-- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
		shift_amount	:	in unsigned(4  downto 0);

		-- 06/02/2025 - Nilton - as flags agora sao um barramento de 16 bits
		flags			:	out unsigned(15 downto 0);

		-- 06/02/2025 - Nilton - novo sinal para controlar o registro de flags
		flags_register_wr_enable	:	in	std_logic
	);
end entity;

architecture a_Eq02_ULARegs of Eq02_ULARegs is

	-- 17/12/24 - Nilton - enderecos do banco aumentados para 4 bits

	component Eq02_RegFile is
		port(

			clk: in std_logic;
			rst: in std_logic;
			we3: in std_logic;

			a1: in unsigned(3 downto 0);
			a2: in unsigned(3 downto 0);
			a3: in unsigned(3 downto 0);

			-- 17/12/24 - Nilton - registradores aumentados para 32 bit

			wd3: in 	unsigned(31 downto 0);
			rd1: out 	unsigned(31 downto 0);
			rd2: out 	unsigned(31 downto 0)
		);
	end component;

	-- 17/12/24 - Nilton - ULA expandida para 32 bit
	-- 18/12/24 - Nilton - barramento op aumentado para 3 bit

	component Eq02_ULA is
		port(
			in_A: 		in unsigned(31 downto 0);
			in_B: 		in unsigned(31 downto 0);

			op: 		in unsigned (2 downto 0);

			out_ULA: 	out unsigned(31 downto 0);

			-- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
			shift_amount	:	in unsigned(4  downto 0);

			-- 06/02/2025 - Nilton - as flags agora sao um barramento de 16 bits
			flags			:	out unsigned(15 downto 0)
		);
	end component;

	-- 06/02/2025 - Nilton - adicionando um registrador para as flags
	component Eq02_reg16bits is
		port(
			clk: 	in std_logic;
			rst: 	in std_logic;
			wr_en: 	in std_logic;
			
			data_in: 	in 	unsigned(15 downto 0);
			data_out: 	out unsigned(15 downto 0)
		);
	end component;

	---------------------------------------------------

	signal s_ULAout: 	unsigned(31 downto 0);
	
	-- 06/02/2025 - Nilton - as flags agora sao um barramento de 16 bits
	signal s_flags:		unsigned(15 downto 0);

	signal s_rd1: 		unsigned(31 downto 0);
	signal s_rd2: 		unsigned(31 downto 0);

	signal s_in_B: 		unsigned(31 downto 0);

	-- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
    signal s_shift_amount:	unsigned(4  downto 0)     := b"0_0000";

	-- 06/02/2025 - Nilton - novo sinal para controlar o registro de flags
    signal s_flags_register_wr_enable   :   std_logic   :=  '0';

begin

	-- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
	s_shift_amount	<=	shift_amount;

	------------------------------------------------------------------
	-- ULA_SRC - 0 - o operando B vem do banco de registradores
	-- ULA_SRC - 1 - o operando B vem de uma constante externa

	s_in_B <= 
		s_rd2 				when ula_B_src='0' 	else
		external_const 		when ula_B_src='1' 	else
		b"0000_0000_0000_0000_0000_0000_0000_0000";
	------------------------------------------------------------------

	regs: Eq02_RegFile port map
	(
		clk	=> clk,
		rst => rst,
		we3 => wr_en,
		a1 	=> a1,
		a2 	=> a2,
		a3 	=> a3,
		wd3 => s_ULAout,
		rd1 => s_rd1,
		rd2 => s_rd2
	);
	ula: Eq02_ULA port map
	(
		in_A	=> s_rd1,
		in_B	=> s_in_B,
		op		=> op,
		out_ULA => s_ULAout,
		flags 	=> s_flags,

		shift_amount	=>	s_shift_amount
	);

	-- 06/02/2025 - Nilton - sinal de controle do registro recebe o input importado da UC
    s_flags_register_wr_enable	<=	flags_register_wr_enable;

	reg_flags: Eq02_reg16bits port map
	(
		clk			=>	clk,
		rst			=>	rst,
		wr_en 		=>	s_flags_register_wr_enable,
		data_in 	=>	s_flags,
		data_out	=>	flags
	);

end architecture;
