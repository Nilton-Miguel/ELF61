library ieee;
use ieee.std_logic_1164.all;

entity unidade_teste is
end entity;

architecture unit of unidade_teste is

    component decoder_2x4 is
        port(

            ad0, ad1 :        in std_logic;
            s0, s1, s2, s3 : out std_logic
        );
    end component;

    signal adress0, adress1, saida0, saida1, saida2, saida3: std_logic;

begin

    cabeamento : decoder_2x4 port map(

        ad0 => adress0,
        ad1 => adress1,
        s0  => saida0,
        s1  => saida1,
        s2  => saida2,
        s3  => saida3
    );

    -- processo de set manual dos valores do testbench
    process
    begin

        adress1 <= '0';
        adress0 <= '0';
        wait for 100 ns;

        adress1 <= '0';
        adress0 <= '1';
        wait for 100 ns;

        adress1 <= '1';
        adress0 <= '0';
        wait for 100 ns;

        adress1 <= '1';
        adress0 <= '1';
        wait for 100 ns;
        wait;

    end process;

end architecture ;
