#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

all: idt-preview.out test.out

test.out: intToHex.o test.o
	ld -g -o test.out test.o intToHex.o

idt-preview.out: intToHex.o idt-preview.o
	ld -g -o idt-preview.out idt-preview.o intToHex.o

test.o: test.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 test.asm -l test.lst

idt-preview.o: idt-preview.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 idt-preview.asm -l idt-preview.lst

intToHex.o: intToHex.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 intToHex.asm -l intToHex.lst

clean:
	rm *.lst *.o *.out

