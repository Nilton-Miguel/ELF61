-- ---------------------------------------------------------------------------
-- ELF61 - Arquitetura e Organizacao de Computadores

-- Equipe 02 - 18/12/2024

-- Ana Paula Rodrigues Raimundo     - 1862197
-- Joao Vitor Santos Anacleto       - 1802836
-- Nilton Miguel Guimaraes de Souza - 2237164
-- ---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bench is
end entity;

architecture a_bench of bench is

    component Eq02_ULARegs is
        port(
    
            clk: 	in std_logic;
            rst: 	in std_logic;
            wr_en: 	in std_logic;
    
            op: in unsigned(2 downto 0);
    
            a1: in unsigned(3 downto 0);
            a2: in unsigned(3 downto 0);
            a3: in unsigned(3 downto 0);
    
            external_const: 	in unsigned(31 downto 0);
            ula_B_src: 			in std_logic
        );
    end component;

    signal s_clk, s_rst, s_wr_en, s_ula_B_src   :   std_logic               := '0';
    signal s_op                                 :   unsigned(2 downto 0)    := "000";
    signal s_a1, s_a2, s_a3                     :   unsigned(3 downto 0)    := "0000";
    signal s_external_const                     :   unsigned(31 downto 0)   := x"00000000";

begin

    -------------------------------------------------
    mapa_ula_regs : Eq02_ULARegs port map(

        clk             => s_clk,
        rst             => s_rst,
        wr_en           => s_wr_en,
        op              => s_op,
        a1              => s_a1,
        a2              => s_a2,
        a3              => s_a3,
        external_const  => s_external_const,
        ula_B_src       => s_ula_B_src
    );
    -------------------------------------------------
    cadencia: process
    begin

        s_clk <= '0';
        wait for 50 ns;
        s_clk <= '1';
        wait for 50 ns;

    end process;
    -------------------------------------------------
    resetando: process
    begin

        s_rst <= '1';
        wait for 200 ns;
        s_rst <= '0';
        wait;

    end process;
    -------------------------------------------------
    passos: process
    begin

        -------------------------------------------------
        -- espera o reset
        wait for 200 ns;

        s_wr_en             <= '0';
        s_op                <= "000";
        s_a1                <= x"0";
        s_a2                <= x"0";
        s_a3                <= x"0";
        s_ula_B_src         <= '0';
        s_external_const    <= x"00000000";
        -------------------------------------------------
        wait for 100 ns;
        -- escreva no (registro F)
        s_wr_en             <= '1';
        s_a3                <= x"F";
        -- a soma de 0 (no registro 0) com a constante externa
        s_a1                <= x"0";
        s_op                <= "000";
        s_ula_B_src         <= '1';
        s_external_const    <= x"00000001";
        -------------------------------------------------
        wait for 100 ns;
        -- escreva no (registro F) o (registro F) deslocado em alguns bits
        s_a1                <= x"F";
        s_a3                <= x"F";
        s_wr_en             <= '1';
        s_op                <= "111";
        -------------------------------------------------
        wait;
    end process;
    -------------------------------------------------

end architecture;
