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

entity uc is

    port(

        -- 16/12/24 - Nilton - UC agora e uma unidade sincrona
        clk     : in std_logic;
        rst     : in std_logic;

        -- 16/12/24 - Nilton - remocao do step externo (step : in  std_logic;)
        pc_wr_en    : out std_logic;
        jump_en     : out std_logic;

        -- 16/12/24 - Nilton - instrucao aumentada para 24 Bytes
        instruction : in unsigned(23 downto 0);

        -- 18/12/24 - Nilton - UC agora exporta os 7 sinais de controle da ULA e Banco
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
end entity;

architecture a_uc of uc is

    signal s_pc_wr_en   : std_logic := '0';
    signal s_jump_en    : std_logic := '0';

    -- 16/12/2024 - Nilton - todas as possiveis secoes de uma instrucao e suas larguras de campo

    signal s_opcode0        : unsigned(3  downto 0)     := b"0000";
    signal s_opcode2        : unsigned(3  downto 0)     := b"0000";

    -- 16/12/2024 - Nilton - opcode1 unico campo que nao aparece na mesma posicao em formatos diferentes

    signal s_opcode1_rrr    : unsigned(3  downto 0)     := b"0000";
    signal s_opcode1_rri8   : unsigned(3  downto 0)     := b"0000";

    signal s_t_add          : unsigned(3  downto 0)     := b"0000";
    signal s_s_add          : unsigned(3  downto 0)     := b"0000";
    signal s_r_add          : unsigned(3  downto 0)     := b"0000";

    signal s_n_add          : unsigned(1  downto 0)     := b"00";

    signal s_imm8           : unsigned(7  downto 0)     := b"0000_0000";
    signal s_offset18       : unsigned(17 downto 0)     := b"00_0000_0000_0000_0000";

    -- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
    signal s_shift_amount   : unsigned(4  downto 0)     := b"0_0000";

    -- ------------------------------------------------------------------------------

    -- 16/12/2024 - Nilton - maquina de estados foi integrada na UC

    signal  s_step :    std_logic := '0';
    signal  s_clk:      std_logic := '0';
    signal  s_rst:      std_logic := '0';

    component maq_estados is
        port(
            clk, rst:       in std_logic;
            step:           out std_logic
        );
    end component;

    -- 06/02/2025 - Nilton - importando as flags
    signal s_flags          :   unsigned(15  downto 0)  := x"0000";

begin

    -- 06/02/2025 - Nilton - importando as flags
    s_flags <=  flags;

    ---------------------------------------------------------------------------
    -- 18/12/2024 - Nilton - nesta secao estao todos os particionamentos possiveis da instrucao
    ---------------------------------------------------------------------------

        s_opcode0           <=  instruction(3  downto 0 );
        s_t_add             <=  instruction(7  downto 4 );
        s_opcode1_rri8      <=  instruction(7  downto 4 );
        s_n_add             <=  instruction(5  downto 4 );
        s_s_add             <=  instruction(11 downto 8 );
        s_r_add             <=  instruction(15 downto 12);
        s_opcode1_rrr       <=  instruction(19 downto 16);
        s_opcode2           <=  instruction(23 downto 20);
        s_imm8              <=  instruction(23 downto 16);
        s_offset18          <=  instruction(23 downto 6 );

        -- 19/12/2024 - Nilton - novo sinal para controlar shift na ULA
        s_shift_amount      <=  instruction(20) &   instruction(7  downto 4 );

    ---------------------------------------------------------------------------
    -- 18/12/2024 - Nilton - nesta secao esta o controle de passos da maquina (atualmente trabalhamos com fetch (step 0) e execute (step 1))
    ---------------------------------------------------------------------------

    s_clk <= clk;
    s_rst <= rst;

    state_machine : maq_estados port map(

        clk     =>  s_clk,
        rst     =>  s_rst,
        step    =>  s_step
    );
    ---------------------------------------------------------------------------
    -- 18/12/2024 - Nilton - nesta secao estao os drivers dos sinais de controle do Program Counter
    ---------------------------------------------------------------------------

    s_pc_wr_en              <=  not s_step;
    pc_wr_en                <=  s_pc_wr_en;
    jump_en                 <=  s_jump_en;

    -- 19/12/2024 - Nilton - alteracoes na arquitetura dos saltos

    s_jump_en <=    '1' when ( -- casos de salto

                        (s_opcode0  =   b"0110" and s_n_add =   b"00") or

                        -- 06/02/2025 - Nilton - adicao salto condicional
                        (s_opcode0  =   b"1001" and s_n_add =   s_flags(1 downto 0))

                    ) else
                    '0';
    ----------------------------------------------------------------------------
    -- 18/12/2024 - Nilton - nesta secao estao os drivers da ULA e Banco de Registros
    ----------------------------------------------------------------------------

        ------------------------------------------------------------------------
        -- o imediato de 8 bits contido na instrucao foi extendido para 32 bits para poder ser carregado como operando opcional da ULA
        external_constant       <= b"0000_0000_0000_00" & s_offset18 when( -- casos de salto

                                    -- quando saltos estao habilitados exportamos o offset
                                    (s_jump_en = '1')
                                ) else
                                (x"000000" & s_imm8); -- se nao for salto exportamos o imediato de 8 pra ULA
        ------------------------------------------------------------------------
        -- o registrador de escrita sempre vem do campo r da instrucao
        reg3                    <=  s_r_add;
        ------------------------------------------------------------------------
        ula_opcode              <=  "000" when ( -- casos de soma
                                        -- adicao entre registradores
                                        (s_opcode2 = b"1000" and s_opcode1_rrr = b"0000" and s_opcode0 = b"0000") or
                                        -- adicao com imediato
                                        (s_opcode1_rri8 = b"1100" and s_opcode0 = b"0010")
                                    ) else
                                    "001" when ( -- casos de subtracao
                                        -- subtracao entre registradores
                                        (s_opcode2 = b"1100" and s_opcode1_rrr = b"0000" and s_opcode0 = b"0000")
                                    ) else
                                    "010" when ( -- casos de divisao
                                        -- divisao entre registradores
                                        (s_opcode2 = b"0111" and s_opcode1_rrr = b"1010" and s_opcode0 = b"0000")
                                    ) else
                                    "100" when ( -- casos de shift para a esquerda
                                        -- shift com imediato
                                        (s_opcode2(2 downto 0) = b"000" and s_opcode1_rrr = b"0001" and s_opcode0 = b"0000")
                                    ) else
                                    "000";
        ------------------------------------------------------------------------
        ula_B_src               <=  '1' when (
                                        -- adicao com imediato
                                        (s_opcode1_rri8 = b"1100" and s_opcode0 = b"0010")
                                    ) else
                                    '0';
        ------------------------------------------------------------------------
        -- o primeiro operando vem sempre do campo s da instrucao
        reg1                    <=  s_s_add;
        ------------------------------------------------------------------------
        -- o segundo operando vem sempre do campo t da instrucao (a escolha entre t e imediato e feita no ula_B_src)
        reg2                    <=  s_t_add;
        ------------------------------------------------------------------------
        -- registradores podem ser escritos apenas no (step 1 - execute) e somente em alguma das operacoes aritmeticas sobre registradores
        registers_write_enable  <=  '1' when s_step = '0' and (

            -- 10/02/2025 - Nilton - proibi a maquina de escrever no banco de registradores fora de uma operacao aritmetica, nao basta estar no execute para prevenir mal funcionamento
            
                                (s_opcode2 = b"0111" and s_opcode1_rrr = b"1010" and s_opcode0 = b"0000") or
                                (s_opcode2 = b"1100" and s_opcode1_rrr = b"0000" and s_opcode0 = b"0000") or
                                (s_opcode2 = b"1000" and s_opcode1_rrr = b"0000" and s_opcode0 = b"0000") or
                                (s_opcode1_rri8 = b"1100" and s_opcode0 = b"0010")

                                    )else
                                    '0';
        ----------------------------------------------------------------------------
        -- os bits para shift vem sempre do mesmo campo da instrucao
        shift_amount            <= s_shift_amount;
        ----------------------------------------------------------------------------
        -- o registro de flags deve ser feito somente durante operacoes aritmeticas
        flags_register_wr_enable    <=  '1' when(

                (s_opcode2 = b"0111" and s_opcode1_rrr = b"1010" and s_opcode0 = b"0000") or
                (s_opcode2 = b"1100" and s_opcode1_rrr = b"0000" and s_opcode0 = b"0000") or
                (s_opcode2 = b"1000" and s_opcode1_rrr = b"0000" and s_opcode0 = b"0000") or
                (s_opcode1_rri8 = b"1100" and s_opcode0 = b"0010")

                                        ) else
                                        '0';
        ----------------------------------------------------------------------------
end architecture;
