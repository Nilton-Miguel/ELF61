-- ---------------------------------------------------------------------------
-- ELF61 - Arquitetura e Organizacao de Computadores

-- Equipe 02 - 10/11/2024

-- Ana Paula Rodrigues Raimundo     - 1862197
-- Joao Vitor Santos Anacleto       - 1802836
-- Nilton Miguel Guimaraes de Souza - 2237164
-- ---------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_8x16 is
    port(

        a1, a2, a3          : in    unsigned(2  downto 0);
        wd3                 : in    unsigned(15 downto 0);
        clk, rst, we3       : in    std_logic;

        rd1, rd2            : out   unsigned(15 downto 0)

    );
end entity;

architecture arq_banco_8x16 of banco_8x16 is
    
    -- header do registrador
    component registrador_16 is

        port( 
    
            clk, rst, wr_en : in    std_logic;
            data_in         : in    unsigned(15 downto 0);
            data_out        : out   unsigned(15 downto 0)
        );
    end component;

    -- os 8 dados existentes no banco
    signal registro0 : unsigned(15 downto 0) := x"0000";
    signal registro1 : unsigned(15 downto 0) := x"0000";
    signal registro2 : unsigned(15 downto 0) := x"0000";
    signal registro3 : unsigned(15 downto 0) := x"0000";
    signal registro4 : unsigned(15 downto 0) := x"0000";
    signal registro5 : unsigned(15 downto 0) := x"0000";
    signal registro6 : unsigned(15 downto 0) := x"0000";
    signal registro7 : unsigned(15 downto 0) := x"0000";

    -- os 8 diferentes sinais de enable
    signal controle_enable : unsigned(7 downto 0) := x"00";

    signal read_adress1, read_adress2, write_adress    : unsigned(2 downto 0) := "000";
    signal master_write_enable                         : std_logic := '0';

    begin

        read_adress1 <= a1;
        read_adress2 <= a2;

        rd1 <=  registro0 when read_adress1 = "000" else
                registro1 when read_adress1 = "001" else
                registro2 when read_adress1 = "010" else
                registro3 when read_adress1 = "011" else
                registro4 when read_adress1 = "100" else
                registro5 when read_adress1 = "101" else
                registro6 when read_adress1 = "110" else
                registro7 when read_adress1 = "111" else
                x"0000"
            ;

        rd2 <=  registro0 when read_adress2 = "000" else
                registro1 when read_adress2 = "001" else
                registro2 when read_adress2 = "010" else
                registro3 when read_adress2 = "011" else
                registro4 when read_adress2 = "100" else
                registro5 when read_adress2 = "101" else
                registro6 when read_adress2 = "110" else
                registro7 when read_adress2 = "111" else
                x"0000"
            ;

        master_write_enable <= we3;
        write_adress <= a3;

        controle_enable(0) <= '0';
        controle_enable(1) <= master_write_enable when write_adress = x"1" else '0';
        controle_enable(2) <= master_write_enable when write_adress = x"2" else '0';
        controle_enable(3) <= master_write_enable when write_adress = x"3" else '0';
        controle_enable(4) <= master_write_enable when write_adress = x"4" else '0';
        controle_enable(5) <= master_write_enable when write_adress = x"5" else '0';
        controle_enable(6) <= master_write_enable when write_adress = x"6" else '0';
        controle_enable(7) <= master_write_enable when write_adress = x"7" else '0';

        -- registrador 0 sempre um zero constante de 16 bits
        registro0 <= x"0000";

        mapa1: registrador_16 port map(

            clk      => clk,
            rst      => rst,
            wr_en    => controle_enable(1),
            data_in  => wd3,
            data_out => registro1
        );

        mapa2: registrador_16 port map(

            clk      => clk,
            rst      => rst,
            wr_en    => controle_enable(2),
            data_in  => wd3,
            data_out => registro2
        );

        mapa3: registrador_16 port map(

            clk      => clk,
            rst      => rst,
            wr_en    => controle_enable(3),
            data_in  => wd3,
            data_out => registro3
        );

        mapa4: registrador_16 port map(

            clk      => clk,
            rst      => rst,
            wr_en    => controle_enable(4),
            data_in  => wd3,
            data_out => registro4
        );

        mapa5: registrador_16 port map(

            clk      => clk,
            rst      => rst,
            wr_en    => controle_enable(5),
            data_in  => wd3,
            data_out => registro5
        );

        mapa6: registrador_16 port map(

            clk      => clk,
            rst      => rst,
            wr_en    => controle_enable(6),
            data_in  => wd3,
            data_out => registro6
        );

        mapa7: registrador_16 port map(

            clk      => clk,
            rst      => rst,
            wr_en    => controle_enable(7),
            data_in  => wd3,
            data_out => registro7
        );

    end architecture;
