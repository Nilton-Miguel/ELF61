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

entity Eq02_ULARegs_tb is 
end entity;

architecture arq_Eq02_ULARegs_tb of Eq02_ULARegs_tb is

    component Eq02_ULARegs is
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
    end component;

    signal sig_clk, sig_rst, sig_wr_en, sig_ula_src      : std_logic                := '0';
    signal sig_op                                        : unsigned(1  downto 0)    := "00";
    signal sig_a1, sig_a2, sig_a3                        : unsigned(2  downto 0)    := "000";
    signal sig_ext_const                                 : unsigned(15 downto 0)    := x"0000";

    begin

        top: Eq02_ULARegs port map(

            clk         => sig_clk,
            rst         => sig_rst,
            wr_en       => sig_wr_en,
            op          => sig_op,
            a1          => sig_a1,
            a2          => sig_a2,
            a3          => sig_a3,
            ext_const   => sig_ext_const,
            ula_src     => sig_ula_src
        );
    
        cadencia: process
	    begin

            sig_clk <= '0';
            wait for 50 ns;

            sig_clk <= '1';
            wait for 50 ns;

	    end process;

        limpeza: process
	    begin

            sig_rst <= '1';
            wait for 100 ns;

            sig_rst <= '0';
            wait;
	    end process;
        
        combinacionais: process
        begin

            -- esperar pelo reset
            wait for 100 ns;

            -- truncar 2237164 para x7164 para r6

            sig_ula_src     <= '1';
            sig_wr_en       <= '1';

            sig_ext_const   <= x"7164";
            sig_a3          <= "110";

            wait for 100 ns;

            -- truncar 1802836 para x2836 para r7

            sig_ext_const   <= x"2836";
            sig_a3          <= "111";

            wait for 100 ns;

            -- dividir r6 por r7 e guardar em r6

            sig_a1          <= "110";
            sig_ula_src     <= '0';
            sig_a2          <= "111";
            sig_a3          <= "110";
            sig_op          <= "10";

            wait for 100 ns;

            -- dividir r6 por r0 (zero) e guardar em r6

            sig_a1          <= "110";
            sig_ula_src     <= '0';
            sig_a2          <= "000";
            sig_a3          <= "110";
            sig_op          <= "10";

            wait for 100 ns;
            
            wait;
        end process;

end architecture ;