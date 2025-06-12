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

entity rom_pc_uc is
    
    port(

        clk, rst    : in    std_logic;
        pc          : out   unsigned(15 downto 0);
        instrucao   : out   unsigned(7 downto 0);
    );
end entity;

architecture a_rom_oc_uc of rom_pc_uc is

    component rom is
        port( 
            clk : in std_logic;
            add : in unsigned(15 downto 0);
            instruction : out unsigned(7 downto 0)
        );
    end component;

    component program_counter is

        port(
    
            clk: in std_logic;
            rst: in std_logic;
            wr_en: in std_logic;
            next_instruction: out unsigned(15 downto 0);

            data_in: in unsigned(15 downto 0);
            jump_en: in std_logic
        );
    end component;

    component maq_estados is
        port(
            clk, rst:       in std_logic;
            step:           out std_logic
        );
    end component;

    component uc is

        port(
    
            step        : in  std_logic;
            pc_wr_en    : out std_logic;
            jump_en     : out std_logic;
            
            instruction : in unsigned(7 downto 0)
        );
    end component;

    signal s_clk, s_rst, s_wr_en, s_step    : std_logic                 := '0';
    signal s_next_instruction, s_jump_add   : unsigned(15 downto 0)     := x"0000";
    signal s_instruction                    : unsigned(7 downto 0)      := x"00";
    
    signal s_jump_en : std_logic := '0';

    begin

        mapa_rom : rom port map(

            clk         => s_clk,
            add         => s_next_instruction,
            instruction => s_instruction
        );

        mapa_PC : program_counter port map(

            clk                 => s_clk,
            rst                 => s_rst,
            wr_en               => s_wr_en,
            next_instruction    => s_next_instruction,

            -- data_in de 16 precisa ser extendido pelo imediato ser de 7
            data_in             => s_jump_add,
            jump_en             => s_jump_en
        );

        s_jump_add <= "000000000" & s_instruction(6 downto 0);

        mapa_SM : maq_estados port map(

            clk     =>      s_clk,
            rst     =>      s_rst,
            step    =>      s_step
        );

        mapa_UC : uc port map(

            instruction         =>      s_instruction,

            pc_wr_en            =>      s_wr_en,
            step                =>      s_step,

            jump_en             =>      s_jump_en
        );

        s_clk   <= clk;
        s_rst   <= rst;

        instrucao   <= s_instruction;
        pc          <= s_next_instruction;

end architecture;
