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

entity microProcessador is
    port(

        clk, rst    :   in  std_logic
    );
end entity;

architecture a_microProcessador of microProcessador is

    -----------------------------------------------------
    component rom_pc_uc is
    
        port(

            clk, rst                : in std_logic;

            -- 18/12/24 - Nilton - sinais novos que a UC precisa gerar e exportar até aqui

            registers_write_enable  : out std_logic;
            ula_B_src               : out std_logic;
            ula_opcode              : out unsigned(2  downto 0);
            reg1, reg2, reg3        : out unsigned(3  downto 0);
            external_constant       : out unsigned(31 downto 0);

            -- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
            shift_amount            : out unsigned(4  downto 0);

            -- 06/02/2025 - Nilton - novo sinal para controlar o registro de flags
            flags_register_wr_enable    :   out std_logic;

            -- 06/02/2025 - Nilton - importando as flags
            flags   :   in unsigned(15  downto 0)
        );
    end component;
    -----------------------------------------------------
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
            ula_B_src: 			in std_logic;

            -- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
            shift_amount    :   in unsigned(4  downto 0);

            -- 06/02/2025 - Nilton - as flags agora sao um barramento de 16 bits
		    flags			:	out unsigned(15 downto 0);

            -- 06/02/2025 - Nilton - novo sinal para controlar o registro de flags
		    flags_register_wr_enable	:	in	std_logic
        );
    end component;
    -----------------------------------------------------

    signal s_clk, s_rst                 :   std_logic := '0';

    -- 18/12/24 - Nilton - sinais novos

    signal s_registers_write_enable     :   std_logic := '0';
    signal s_ula_B_src                  :   std_logic := '0';
    signal s_ula_opcode                 :   unsigned(2 downto 0)    := "000";
    signal s_reg1, s_reg2, s_reg3       :   unsigned(3 downto 0)    := "0000";
    signal s_external_constant          :   unsigned(31 downto 0)   := x"00000000";

    -- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
    signal s_shift_amount   :   unsigned(4  downto 0)   := b"0_0000";
    
    -- 06/02/2025 - Nilton - exportei as flags num barramento de 16 bits
    signal s_flags          :   unsigned(15  downto 0)  := x"0000";
    
    -- 06/02/2025 - Nilton - novo sinal para controlar o registro de flags
    signal s_flags_register_wr_enable   :   std_logic   :=  '0';

begin

    -------------------------------------------------------
    mapa_rom_pc_uc: rom_pc_uc port map(

        clk                         =>  s_clk,
        rst                         =>  s_rst,

        -- 18/12/24 - Nilton - mapeados todos os signals novos

        registers_write_enable      => s_registers_write_enable,
        ula_B_src                   => s_ula_B_src,
        ula_opcode                  => s_ula_opcode,
        reg1                        => s_reg1,
        reg2                        => s_reg2,
        reg3                        => s_reg3,
        external_constant           => s_external_constant,

        -- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
        shift_amount                => s_shift_amount,

        -- 06/02/2025 - Nilton - novo sinal para controlar o registro de flags
        flags_register_wr_enable    => s_flags_register_wr_enable,

        -- 06/02/2025 - Nilton - importando as flags
        flags          =>  s_flags
    );
    -------------------------------------------------------
    mapa_ula_regs: Eq02_ULARegs port map(

        clk             =>  s_clk,
        rst             =>  s_rst,

        -- 18/12/24 - Nilton - mapeados todos os signals novos

        wr_en           =>  s_registers_write_enable,
        ula_B_src       =>  s_ula_B_src,
        op              =>  s_ula_opcode,
        a1              =>  s_reg1,
        a2              =>  s_reg2,
        a3              =>  s_reg3,
        external_const  =>  s_external_constant,

        -- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
        shift_amount    =>  s_shift_amount,

        -- 06/02/2025 - Nilton - exportei as flags
        flags          =>  s_flags,

        flags_register_wr_enable    =>  s_flags_register_wr_enable
    );
    -------------------------------------------------------

    s_clk   <=  clk;
    s_rst   <=  rst;

end architecture;
