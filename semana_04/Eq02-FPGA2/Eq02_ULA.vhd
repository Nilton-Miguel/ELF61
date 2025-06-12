-- ---------------------------------------------------------------------------
-- ELF61 - Arquitetura e Organizacao de Computadores

-- Equipe 02 - 19/10/2024

-- Ana Paula Rodrigues Raimundo     - 1862197
-- Joao Vitor Santos Anacleto       - 1802836
-- Nilton Miguel Guimaraes de Souza - 2237164
-- ---------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq02_ULA is

    port(

        -- para 4 operacoes bastam 2 bits de op

        -- 00 - ADD
        -- 01 - SUB
        -- 10 - DIV
        -- 11 - XOR

        in_A, in_B  : in  unsigned(15 downto 0);
        op          : in  unsigned(1  downto 0);
        out_ULA     : out unsigned(15 downto 0);

        zero, maior : out std_logic
    );
end entity;

architecture Arq_Eq02_ULA of Eq02_ULA is

    signal sig_out_ULA : unsigned(15 downto 0);

    begin

        out_ULA <= sig_out_ULA;

        sig_out_ULA <=  (in_A + in_B)   when op = "00" else
                        (in_A - in_B)   when op = "01" else 
                        (in_A / in_B)   when op = "10" else 
                        (in_A xor in_B) when op = "11" else
                        x"0000";
        
        zero <=     '1' when sig_out_ULA = x"0000" else
                    '0';
        
        maior <=    '1' when in_A > in_B else
                    '0';        

end architecture;
