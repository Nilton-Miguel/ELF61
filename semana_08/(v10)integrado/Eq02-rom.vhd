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

        -- addi :   imm8_r_s_1100_0010      (r = s + imm8)
        -- add  :   1000_0000_r_s_t_0000    (r = s + t)
        -- sub  :   1100_0000_r_s_t_0000    (r = s - t)
        -- div  :   0111_1010_r_s_t_0000    (r = s / t)
        -- slli :   000e_0001_r_s_dcba_0000 (r = s<< por int(b_edcba))
        -- j    :   off18_00_0110           (pc = pc + 1 + off18)

        -- 16/12/24 - Nilton - codigo de maquina com opcodes comentados

        0  => b"0000_0000_0000_0000_0000_0000",     --  (nop)

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
