ghdl -a Eq02-reg16bits.vhd
ghdl -a Eq02-RegFile.vhd
ghdl -a Eq02-RegFile_tb.vhd

ghdl -r regFile_tb --stop-time=4500ns --wave=Eq02-RegFile.ghw --ieee-asserts=disable-at-0