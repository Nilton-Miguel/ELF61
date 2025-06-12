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

entity rom is
    port( 
        clk : in std_logic;
        add : in unsigned(15 downto 0);
        
        -- 16/12/24 - Nilton - saida da instrucao aumentada para 3 Bytes
        instruction : out unsigned(23 downto 0) := x"000000"
    );
end entity;

architecture a_rom of rom is

    -- 16/12/24 - Nilton - a ROM agora tem enderecos de 3 Bytes cada
    type mem is array (0 to 127) of unsigned(23 downto 0);
    constant conteudo_rom : mem := (

        -- 18/12/24 - Nilton - lookup table das instrucoes (na ordem de implementacao)

        -- addi     :   imm8_r_s_1100_0010      (r = s + imm8)
        -- add      :   1000_0000_r_s_t_0000    (r = s + t)
        -- sub      :   1100_0000_r_s_t_0000    (r = s - t)
        -- div      :   0111_1010_r_s_t_0000    (r = s / t)
        -- slli     :   000e_0001_r_s_dcba_0000 (r = s<< por int(b_edcba))
        -- j        :   off18_00_0110           (pc = pc + 1 + off18)

        -- 18/12/24 - Nilton - salto condicional implementado
        -- cond j   :   off18_xy_1001           (pc = pc + 1 + off18) se xy == flags(gt,z)
        

        0  => b"0000_0000_0000_0000_0000_0000",     --  (nop)

        -- ----------------------------------------------------------------------------------------------
        -- 06/02/2025 - Nilton - 3 * 5 = 15

        -- carregar as fatores
        1  => b"0000_0101_0100_0000_1100_0010",     --  (a) r4 = r0 + imm(0x05)
        2  => b"0000_0011_0101_0000_1100_0010",     --  (b) r5 = r0 + imm(0x03)

        -- limpar os indices i e r
        3  => b"1000_0000_0110_0000_0000_0000",     --  (i) r6 = r0 + r0
        4  => b"1000_0000_0010_0000_0000_0000",     --  (r) r2 = r0 + r0

        -- soma o fator e incrementa o contador
        5  => b"0000_0001_0110_0110_1100_0010",     --  (i) r6 = r6 + imm(0x01)
        6  => b"1000_0000_0010_0010_0100_0000",     --  (r) r2 = r2 + r4

        7  => b"1100_0000_0000_0110_0101_0000",     --  (dummy) r0 = (i) r6 - (b) r5

        -- enquanto a multiplicacao continua eu espero flags (gt, z) = (0,0)

        8  => b"00_0000_0000_0111_1100_00_1001",     -- se (gt, z) = (0,0) volte 3 posicoes
        -- ----------------------------------------------------------------------------------------------
        -- 06/02/2025 - Nilton - 9 * 2 = 18

        -- carregar as fatores
        10  => b"0000_0010_0100_0000_1100_0010",     --  (a) r4 = r0 + imm(0x02)
        11 => b"0000_1001_0101_0000_1100_0010",     --  (b) r5 = r0 + imm(0x09)

        -- limpar os indices i e r
        12 => b"1000_0000_0110_0000_0000_0000",     --  (i) r6 = r0 + r0
        13 => b"1000_0000_0010_0000_0000_0000",     --  (r) r2 = r0 + r0

        -- soma o fator e incrementa o contador
        14 => b"0000_0001_0110_0110_1100_0010",     --  (i) r6 = r6 + imm(0x01)
        15 => b"1000_0000_0010_0010_0100_0000",     --  (r) r2 = r2 + r4

        16 => b"1100_0000_0000_0110_0101_0000",     --  (dummy) r0 = (i) r6 - (b) r5

        -- enquanto a multiplicacao continua eu espero flags (gt, z) = (0,0)

        17  => b"00_0000_0000_0111_1100_00_1001",     -- se (gt, z) = (0,0) volte 3 posicoes
        -- ----------------------------------------------------------------------------------------------

        others => (others=>'0')
    );

    begin

        process(clk)
        begin
            if(rising_edge(clk)) then
                instruction <= conteudo_rom(to_integer(add));
            end if;
        end process;

end architecture;
