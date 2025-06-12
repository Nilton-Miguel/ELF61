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

entity Eq02_ULA_tb is
end entity;

architecture Arq_Eq02_ULA_tb of Eq02_ULA_tb is

    component Eq02_ULA is

        port(
    
            in_A, in_B  : in  unsigned(15 downto 0);
            op          : in  unsigned(1  downto 0);
            out_ULA     : out unsigned(15 downto 0);

            zero, maior : out std_logic
        );
    end component;

    signal sig_in_A, sig_in_B, sig_out_ULA : unsigned(15 downto 0);
    signal sig_op                          : unsigned(1  downto 0);
    signal sig_zero, sig_maior             : std_logic;

    begin

        mapeamento: Eq02_ULA port map(

            in_A    => sig_in_A,
            in_B    => sig_in_B,
            out_ULA => sig_out_ULA,
            op      => sig_op,
            zero    => sig_zero,
            maior   => sig_maior
        );
        
        process
            begin
                -- ----------------------------------------
                -- A + 5 = F
                -- A > 5
                -- F != 0
                sig_op   <=  "00";
                sig_in_A <= x"000A";
                sig_in_B <= x"0005";
                wait for 10 ns;
                -- ----------------------------------------
                -- 6 + A = 10
                -- 6 < A
                -- 10 != 0
                sig_op   <=  "00";
                sig_in_A <= x"0006";
                sig_in_B <= x"000A";
                wait for 10 ns;
                -- ----------------------------------------
                -- FFFE + 2 = 0
                -- FFFE < 2
                -- 0 = 0
                sig_op   <=  "00";
                sig_in_A <= x"FFFE";
                sig_in_B <= x"0002";
                wait for 10 ns;
                -- ----------------------------------------
                -- 10 - 5 = B
                -- 10 > 5
                -- B != 0
                sig_op   <=  "01";
                sig_in_A <= x"0010";
                sig_in_B <= x"0005";
                wait for 10 ns;
                -- ----------------------------------------
                -- 0 - 1 = FFFF
                -- 0 < 1
                -- FFFF != 0
                sig_op   <=  "01";
                sig_in_A <= x"0000";
                sig_in_B <= x"0001";
                wait for 10 ns;
                -- ----------------------------------------
                -- 3 - 7 = FFFC
                -- 3 < 7
                -- FFFC != 0
                sig_op   <=  "01";
                sig_in_A <= x"0003";
                sig_in_B <= x"0007";
                wait for 10 ns;
                -- ----------------------------------------
                -- AAAA / 5555 = 2
                -- AAAA > 5555
                -- 2 != 0
                sig_op   <=  "10";
                sig_in_A <= x"AAAA";
                sig_in_B <= x"5555";
                wait for 10 ns;
                -- ----------------------------------------
                -- 55 / AA = 0
                -- 55 < AA
                -- 0 = 0
                sig_op   <=  "10";
                sig_in_A <= x"0055";
                sig_in_B <= x"00AA";
                wait for 10 ns;
                -- ----------------------------------------
                -- 7 / 0 = ?
                -- 7 > 0
                -- FFFC != 0
                sig_op   <=  "10";
                sig_in_A <= x"0007";
                sig_in_B <= x"0001";
                wait for 10 ns;
                -- ----------------------------------------
                -- AA00 xor 0055 = AA55
                -- AA00 > 0055
                -- AA55 != 0
                sig_op   <=  "11";
                sig_in_A <= x"AA00";
                sig_in_B <= x"0055";
                wait for 10 ns;
                -- ----------------------------------------
                -- AA76 xor AA89 = 00FF
                -- AA89 < AA76
                -- 00FF != 0
                sig_op   <=  "11";
                sig_in_A <= x"AA76";
                sig_in_B <= x"AA89";
                wait for 10 ns;
                -- ----------------------------------------
                -- 8080 xor 8080 = 0000
                -- 8080 !< 8080
                -- 0000 != 0
                sig_op   <=  "11";
                sig_in_A <= x"8080";
                sig_in_B <= x"8080";
                wait for 10 ns;
                -- ----------------------------------------
                -- 2237164d --> 7164d --> 0x1BFC
                -- 1802836d --> 2836d --> 0x0B14
                sig_in_A <= X"1BFC";
                sig_in_B <= X"0B14";
                sig_op <= "10";
                wait for 100 ns;
                -- ----------------------------------------

                wait;
        end process;

end architecture;
