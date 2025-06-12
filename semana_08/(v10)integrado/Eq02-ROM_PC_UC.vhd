-- ---------------------------------------------------------------------------
-- ELF61 - Arquitetura e Organizacao de Computadores

-- Equipe 02 - 16/12/2024

-- Ana Paula Rodrigues Raimundo     - 1862197
-- Joao Vitor Santos Anacleto       - 1802836
-- Nilton Miguel Guimaraes de Souza - 2237164
-- ---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_pc_uc is
    
    port(

        clk, rst                : in std_logic;

        -- 18/12/24 - Nilton - criacao das novas saidas de controle da ULA e Banco
        registers_write_enable  : out std_logic;
        ula_B_src               : out std_logic;
        ula_opcode              : out unsigned(2  downto 0);
        reg1, reg2, reg3        : out unsigned(3  downto 0);
        external_constant       : out unsigned(31 downto 0);

        -- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
        shift_amount            : out unsigned(4  downto 0)
    );
end entity;

architecture a_rom_oc_uc of rom_pc_uc is

    component rom is
        port( 
            clk : in std_logic;
            add : in unsigned(15 downto 0);
            
            -- 16/12/24 - Nilton - instrucoes aumentadas para 3 Bytes
            instruction : out unsigned(23 downto 0)
        );
    end component;

    component program_counter is

        port(
    
            clk:    in std_logic;
            rst:    in std_logic;
            wr_en:  in std_logic;

            next_instruction: out unsigned(15 downto 0);
            data_in: in unsigned(15 downto 0);

            jump_en: in std_logic
        );
    end component;

    component uc is

        port(

            clk         : in  std_logic;
            rst         : in  std_logic;
            pc_wr_en    : out std_logic;
            jump_en     : out std_logic;
            instruction : in unsigned(23 downto 0);

            -- 18/12/24 - Nilton - sinais novos

            registers_write_enable  : out std_logic;
            ula_B_src               : out std_logic;
            ula_opcode              : out unsigned(2  downto 0);
            reg1, reg2, reg3        : out unsigned(3  downto 0);
            external_constant       : out unsigned(31 downto 0);

            -- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
            shift_amount            : out unsigned(4  downto 0)
        );
    end component;

    signal s_clk, s_rst, s_wr_en, s_step    : std_logic                 := '0';
    signal s_next_instruction, s_jump_add   : unsigned(15 downto 0)     := x"0000";
    signal s_instruction                    : unsigned(23 downto 0)     := x"000000";
    
    signal s_jump_en : std_logic := '0';

    -- 18/12/24 - Nilton - sinais que precisam ser gerados pela UC e exportados para o microProcessador
    signal s_registers_write_enable     :   std_logic := '0';
    signal s_ula_B_src                  :   std_logic := '0';
    signal s_ula_opcode                 :   unsigned(2 downto 0)    := "000";
    signal s_reg1, s_reg2, s_reg3       :   unsigned(3 downto 0)    := "0000";
    signal s_external_constant          :   unsigned(31 downto 0)   := x"00000000";

    -- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
    signal s_shift_amount               :   unsigned(4 downto 0)    := b"0_0000";

    -- 19/12/2024 - Nilton - novo sinal para filtrar bits para o endereco da rom
    signal s_filter_rom_add             : unsigned(15 downto 0)     := x"0000"; 

    begin

        -- 18/12/24 - Nilton - os 7 sinais fazem o drive das 7 saidas de controle da ULA
        registers_write_enable      <=  s_registers_write_enable; 
        ula_B_src                   <=  s_ula_B_src;
        ula_opcode                  <=  s_ula_opcode;
        reg1                        <=  s_reg1; 
        reg2                        <=  s_reg2;
        reg3                        <=  s_reg3;
        external_constant           <=  s_external_constant;
        shift_amount                <=  s_shift_amount;

        -- 19/12/24 - Nilton - a rom tem 7 bits de address space, mas recebe um endereco de 16, para que possamos usar o overflow desses 7 pra fazer o PC ciclar pela rom o offset18 foi reduzido a 7 bits e concatenado com alguns zeros. Um offset de 128 no espaco de enderecamento do offset18 e na verdade um offset de 0 ja que para 7 bits 128 causa overflow.
        s_filter_rom_add <= b"0_0000_0000" & s_next_instruction(6 downto 0);

        mapa_rom : rom port map(

            clk         => s_clk,
            add         => s_filter_rom_add,
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
        
        -- 19/12/2024 - Nilton - o s_jump_add agora recebe a constante externa que pode ser o offset18
        s_jump_add <= s_external_constant(15 downto 0);

        -- 23         7         3         0
        -- +----------+---------+---------+
        -- |   im16   |   ...   | opcode0 |
        -- +----------+---------+---------+

        -- 16/12/2024 - Nilton - maquina de estados foi integrada na UC (sumiu daqui)

        mapa_UC : uc port map(

            -- 16/12/2024 - Nilton - adicao dos sinais de sync da UC
            clk                 =>      s_clk,
            rst                 =>      s_rst,

            instruction         =>      s_instruction,
            pc_wr_en            =>      s_wr_en,
            jump_en             =>      s_jump_en,

            -- 18/12/2024 - Nilton - o drive dos 7 sinais feito pelas 7 saidas da UC
            registers_write_enable      => s_registers_write_enable,
            ula_B_src                   => s_ula_B_src,
            ula_opcode                  => s_ula_opcode,
            reg1                        => s_reg1,
            reg2                        => s_reg2,
            reg3                        => s_reg3,
            external_constant           => s_external_constant,
            shift_amount                => s_shift_amount
        );

        s_clk   <= clk;
        s_rst   <= rst;

end architecture;
