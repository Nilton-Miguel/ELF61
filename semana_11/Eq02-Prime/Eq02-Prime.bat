
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

:: até 150 - 1001 0110 - x96
::ghdl -r bench --wave=Eq02-Prime.ghw --stop-time=100000000ns --ieee-asserts=disable-at-0

:: até 100 - 0110 0100 - x64
::ghdl -r bench --wave=Eq02-Prime.ghw --stop-time=32000000ns --ieee-asserts=disable-at-0

:: até 60  - 0011 1100 - x3C
ghdl -r bench --wave=Eq02-Prime.ghw --stop-time=9000000ns --ieee-asserts=disable-at-0

:: até 30  - 0001 1110 - x1E
::ghdl -r bench --wave=Eq02-Prime.ghw --stop-time=1500000ns --ieee-asserts=disable-at-0
