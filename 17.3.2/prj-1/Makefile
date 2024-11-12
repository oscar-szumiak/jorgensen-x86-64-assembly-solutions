#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

all: buffering.o

buffering.o: buffering.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 buffering.asm -l buffering.lst

clean:
	rm *.lst *.o

