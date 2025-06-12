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

entity program_counter is

    port(

        clk: in std_logic;
        rst: in std_logic;
        wr_en: in std_logic;
        next_instruction: out unsigned(15 downto 0);

        data_in: in unsigned(15 downto 0);
        jump_en: in std_logic
        -- jump_en 0 : incrementar em 1 o pc
        -- jump_en 1 : sobrescrever o pc pelo data_in
    );
end entity;

architecture a_program_counter of program_counter is

    component Eq02_reg16bits is
        port(
            clk: in std_logic;
            rst: in std_logic;
            wr_en: in std_logic;
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    -- s_data_in_reg signal que vai pra entrada do reg interno
    -- s_data_out registro atual do registrador interno

    signal s_clk, s_rst, s_wr_en : std_logic                            := '0';
    signal s_data_in_reg, s_next_instruction : unsigned(15 downto 0)    := x"0000";

begin
    
    mapa_pc : Eq02_reg16bits port map(

        clk         => s_clk,
        rst         => s_rst,
        wr_en       => s_wr_en,
        data_in     => s_data_in_reg,
        data_out    => s_next_instruction
    );

    s_data_in_reg   <=  s_next_instruction + 1  when jump_en = '0' else
                        data_in                 when jump_en = '1' else
                        x"0000";

    s_clk       <= clk;
    s_rst       <= rst;
    s_wr_en     <= wr_en;
    next_instruction <= s_next_instruction;

end architecture ;
