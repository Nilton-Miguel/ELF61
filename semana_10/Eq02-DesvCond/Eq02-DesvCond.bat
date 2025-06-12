
ghdl -a Eq02-reg16bits.vhd
ghdl -a Eq02-program_counter.vhd
ghdl -a Eq02-rom.vhd
ghdl -a Eq02-maq_estados.vhd
ghdl -a Eq02-uc.vhd

ghdl -a Eq02-ROM_PC_UC.vhd

ghdl -a Eq02-reg32bits.vhd
ghdl -a Eq02-RegFile.vhd
ghdl -a Eq02-ULA.vhd
ghdl -a Eq02-ULARegs.vhd

ghdl -a Eq02-microProcessador.vhd

ghdl -a temp_tb.vhd
ghdl -r bench --wave=Eq02-DesvCond.ghw --stop-time=13000ns --ieee-asserts=disable-at-0
