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
        

        -------------------------------------------------------------------------------------------
        -- START
        -------------------------------------------------------------------------------------------

        0   =>  b"0000_0000_0000_0000_0000_0000",        --  (nop)

        -- main
        1   =>  b"0011_1100_0001_0000_1100_0010",        --  (n) r1 = (0) r0 + (60) imm
        2   =>  b"0000_0010_0010_0000_1100_0010",        --  (o) r2 = (0) r0 + (2) imm

        3   =>  b"1100_0000_0000_0010_0001_0000",        --  (dummy) r0 = (o) r2 - (n) r1
        4   =>  b"00_0000_0000_1111_1001_10_1001",       --  goto 126 if o > n

        -- teste de primo
        5   =>  b"0000_0010_0011_0000_1100_0010",        --  (i) r3 = (0) r0 + (2) imm
        6   =>  b"0111_1010_0100_0010_0011_0000",        --  (c) r4 = (o) r2 / (i) r3
        7   =>  b"0000_0001_0100_0100_1100_0010",        --  (c) r4 = (c) r4 + (1) imm

        -- teste divisibilidade
        8   =>  b"0111_1010_0101_0010_0011_0000",        --  (C) r5 = (o) r2 / (i) r3

        -- multiplicacao de (C) r5 por (B) r3
        9   => b"1000_0000_1001_0000_0000_0000",         --  (I) r9  = (0) r0 + (0) r0
        10  => b"1000_0000_1000_0000_0000_0000",         --  (R) r8  = (0) r0 + (0) r0

        11  => b"0000_0001_1001_1001_1100_0010",         --  (I) r9  = (I) r9 + (1) imm
        12  => b"1000_0000_1000_1000_0101_0000",         --  (R) r8  = (R) r8 + (C) r5

        13  => b"1100_0000_0000_1001_0011_0000",         --  (dummy) r0 = (I) r9 - (B) r3
        14  => b"00_0000_0000_0111_1100_00_1001",        --  goto 11 if I < B

        -- teste divisibilidade
        15  =>  b"1100_0000_1000_0010_1000_0000",        --  (D) r8 = (A) r2 - (D) r8
        16  =>  b"1000_0000_0000_0000_1000_0000",        --  (dummy) r0 = (0) r0 + (D) r8 -- nunca set greater

        17  =>  b"00_0000_0000_0000_0011_00_1001",       --  goto 21 if D != 0

        -- teste de primo
        18  =>  b"1100_0000_0000_0011_0010_0000",        --  (dummy) r0 = (i) r3 - (N) r2 -- nunca set greater

        19  =>  b"00_0000_0000_0000_0110_00_1001",       --  goto 26 if N != i
        20  =>  b"00_0000_0000_0000_0011_01_1001",       --  goto 24 if N  = i

        21   =>  b"0000_0001_0011_0011_1100_0010",       --  (i) r3 = (i) r3 + (1) imm
        22   =>  b"1000_0000_0000_0011_0100_0000",       --  (dummy) r0 = (i) r3 + (c) r4 -- nunca set zero

        --23  =>  b"00_0000_0000_0000_0000_10_1001",     --  goto ... if i >  c
        23  =>  b"00_0000_0000_0110_1111_00_1001",       --  goto 8 if i <= c

        -- main
        24   =>  b"0000_0001_0110_0110_1100_0010",       --  (acc)  r6 = (acc) r6 + (1) imm
        25   =>  b"1000_0000_0111_0000_0010_0000",       --  (prod) r7 = (0) r0 + (o) r2
        26   =>  b"0000_0001_0010_0010_1100_0010",       --  (o)    r2 = (o) r2 + (1) imm

        27   =>  b"00_0000_0000_0110_0111_00_0110",      --  goto 3

        126 =>  b"0000_0000_0000_0000_0000_0000",        --  (nop)
        127 =>  b"00_0000_0000_1111_1110_00_0110",       --  goto 126

        -------------------------------------------------------------------------------------------

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
