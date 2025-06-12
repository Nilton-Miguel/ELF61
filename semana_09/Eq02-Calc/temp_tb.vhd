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

    component microProcessador is
        port(
    
            clk, rst    :   std_logic
        );
    end component;

    signal s_clk, s_rst:    std_logic   := '0';

begin

    -------------------------------------------------
    mapa_microProcessador : microProcessador port map(

        clk             => s_clk,
        rst             => s_rst
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

end architecture;
