library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is
	port(
		seletor: in std_logic;

		entrada0: in std_logic;
		entrada1: in std_logic;

		enable: in std_logic;
		saida: out std_logic
	);
end entity;

architecture a_mux2x1 of mux2x1 is
begin
	saida <=
		entrada0 when enable='1' and seletor='0' else
		entrada1 when enable='1' and seletor='1' else
		'0';
end architecture;
