ghdl -a Eq02-rom.vhd
ghdl -a Eq02-maq_estados.vhd
ghdl -a Eq02-program_counter.vhd
ghdl -a Eq02-reg16bits.vhd
ghdl -a Eq02-ROM_PC_UC.vhd
ghdl -a Eq02-uc.vhd

ghdl -a Eq02-ROM_PC_UC_tb.vhd

ghdl -r temp_tb --wave=Eq02-ROM_PC_UC.ghw --stop-time=8000ns