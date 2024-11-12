#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

all: addLine.out

addLine.out: buffering.o addLine.o
	ld -g -o addLine.out addLine.o buffering.o

addLine.o: addLine.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 addLine.asm -l addLine.lst

buffering.o: buffering.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 buffering.asm -l buffering.lst

clean:
	rm *.lst *.o *.out

