ghdl -a Eq02-reg16bits.vhd
ghdl -a Eq02-RegFile.vhd
ghdl -a Eq02-ULA.vhd
ghdl -a Eq02-ULARegs.vhd
ghdl -a Eq02-ULARegs_tb.vhd

ghdl -r Eq02_ULARegs_tb --stop-time=600ns --wave=Eq02-ULARegs.ghw --ieee-asserts=disable-at-0
