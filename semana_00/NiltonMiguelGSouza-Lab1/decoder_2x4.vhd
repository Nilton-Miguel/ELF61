library ieee;
use ieee.std_logic_1164.all;

entity decoder_2x4 is
    port(

        ad0, ad1 :        in std_logic;
        s0, s1, s2, s3 : out std_logic
    );
end entity;

architecture decoder_combinacional of decoder_2x4 is

    begin
        -- s1 sendo o msb e s0 o lsb
        
        s0 <= not(ad1 or ad0);   --00
        s1 <= not(ad1) and ad0;  --01
        s2 <= ad1 and not(ad0);  --10
        s3 <= ad1 and ad0;       --11

end architecture;
