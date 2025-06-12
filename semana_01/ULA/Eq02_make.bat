ghdl --clean
ghdl --remove

ghdl -a Eq02_ULA.vhd
ghdl -a Eq02_ULA_tb.vhd
ghdl -r Eq02_ULA_tb --wave=Eq02_ULA.ghw

gtkwave Eq02_ULA.ghw
