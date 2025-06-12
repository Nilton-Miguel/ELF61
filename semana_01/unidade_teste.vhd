library ieee;
use ieee.std_logic_1164.all;

entity unidade_teste is
end entity;

architecture unit of unidade_teste is

    component mux2x1 is
        port(

            seletor, entrada0, entrada1, enable : in std_logic;
            saida                               : out std_logic
        );
    end component;

    signal sig_seletor, sig_entrada0, sig_entrada1, sig_enable, sig_saida: std_logic;

begin

    cabeamento: mux2x1 port map(

        seletor  => sig_seletor,
        entrada0 => sig_entrada0,
        entrada1 => sig_entrada1,
        enable   => sig_enable,
        saida    => sig_saida
    );

    -- processo de set manual dos valores do testbench
    process
    begin

        sig_enable   <= '0';
        sig_seletor  <= '0';
        sig_entrada0 <= '0';
        sig_entrada1 <= '0';
        wait for 50 ns;

        sig_enable   <= '0';
        sig_seletor  <= '0';
        sig_entrada0 <= '0';
        sig_entrada1 <= '1';
        wait for 50 ns;

        sig_enable   <= '0';
        sig_seletor  <= '0';
        sig_entrada0 <= '1';
        sig_entrada1 <= '0';
        wait for 50 ns;

        sig_enable   <= '0';
        sig_seletor  <= '0';
        sig_entrada0 <= '1';
        sig_entrada1 <= '1';
        wait for 50 ns;

        sig_enable   <= '0';
        sig_seletor  <= '1';
        sig_entrada0 <= '0';
        sig_entrada1 <= '0';
        wait for 50 ns;

        sig_enable   <= '0';
        sig_seletor  <= '1';
        sig_entrada0 <= '0';
        sig_entrada1 <= '1';
        wait for 50 ns;

        sig_enable   <= '0';
        sig_seletor  <= '1';
        sig_entrada0 <= '1';
        sig_entrada1 <= '0';
        wait for 50 ns;

        sig_enable   <= '0';
        sig_seletor  <= '1';
        sig_entrada0 <= '1';
        sig_entrada1 <= '1';
        wait for 50 ns;

        sig_enable   <= '1';
        sig_seletor  <= '0';
        sig_entrada0 <= '0';
        sig_entrada1 <= '0';
        wait for 50 ns;

        sig_enable   <= '1';
        sig_seletor  <= '0';
        sig_entrada0 <= '0';
        sig_entrada1 <= '1';
        wait for 50 ns;

        sig_enable   <= '1';
        sig_seletor  <= '0';
        sig_entrada0 <= '1';
        sig_entrada1 <= '0';
        wait for 50 ns;

        sig_enable   <= '1';
        sig_seletor  <= '0';
        sig_entrada0 <= '1';
        sig_entrada1 <= '1';
        wait for 50 ns;

        sig_enable   <= '1';
        sig_seletor  <= '1';
        sig_entrada0 <= '0';
        sig_entrada1 <= '0';
        wait for 50 ns;

        sig_enable   <= '1';
        sig_seletor  <= '1';
        sig_entrada0 <= '0';
        sig_entrada1 <= '1';
        wait for 50 ns;

        sig_enable   <= '1';
        sig_seletor  <= '1';
        sig_entrada0 <= '1';
        sig_entrada1 <= '0';
        wait for 50 ns;

        sig_enable   <= '1';
        sig_seletor  <= '1';
        sig_entrada0 <= '1';
        sig_entrada1 <= '1';
        wait for 50 ns;

        wait;
    end process;

end architecture ;
