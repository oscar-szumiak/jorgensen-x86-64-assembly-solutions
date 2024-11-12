#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

all: main.out

main.out: buffering.o main.o
	ld -g -o main.out main.o buffering.o

main.o: main.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 main.asm -l main.lst

buffering.o: buffering.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 buffering.asm -l buffering.lst

clean:
	rm *.lst *.o *.out

