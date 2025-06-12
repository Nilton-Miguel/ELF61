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

entity uc is

    port(

        step        : in  std_logic;
        pc_wr_en    : out std_logic;
        jump_en     : out std_logic;

        instruction : in unsigned(7 downto 0)
    );
end entity;

architecture a_uc of uc is

    signal s_pc_wr_en   : std_logic := '0';
    signal s_jump_en    : std_logic := '0';

    signal s_opcode     : std_logic             := '0';
    signal s_immediate  : unsigned(6 downto 0)  := "0000000";

begin

    -- OPCODE    : 1 BIT  : INSTRUCTION(7)
    -- IMMEDIATE : 7 BITS : INSTRUCTION(6 DOWNTO 0)

    s_opcode    <= instruction(7);
    s_immediate <= instruction(6 downto 0);

    s_pc_wr_en  <= not step;
    pc_wr_en    <= s_pc_wr_en;
    jump_en     <= s_jump_en;

    s_jump_en <=    '1' when s_opcode = '1' else
                    '0';

end architecture;
