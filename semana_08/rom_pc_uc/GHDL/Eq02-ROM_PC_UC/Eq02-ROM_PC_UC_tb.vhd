-- ---------------------------------------------------------------------------
-- ELF61 - Arquitetura e Organizacao de Computadores

-- Equipe 02 - 01/12/2024

-- Ana Paula Rodrigues Raimundo     - 1862197
-- Joao Vitor Santos Anacleto       - 1802836
-- Nilton Miguel Guimaraes de Souza - 2237164
-- ---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity temp_tb is
end entity;

architecture a_temp_tb of temp_tb is

    component rom_pc_uc is
    
        port(
    
            clk, rst : in std_logic
        );
    end component;

    signal s_clk, s_rst             : std_logic := '0';
    
    begin

        mapa : rom_pc_uc port map(

            clk         => s_clk,
            rst         => s_rst
        );

        cadencia : process
        begin

            s_clk <= '0';
            wait for 50 ns;

            s_clk <= '1';
            wait for 50 ns;

        end process;

        apagamento : process
        begin

            s_rst <= '1';
            wait for 200 ns;
            s_rst <= '0';
            wait for 600 ns;
            s_rst <= '1';
            wait for 200 ns;
            s_rst <= '0';
            wait;

        end process;

end architecture;
