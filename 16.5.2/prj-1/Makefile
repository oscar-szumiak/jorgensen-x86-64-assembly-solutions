#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

all: cmd-line-args.out cmd-line-args-corrected.out

cmd-line-args.out: cmd-line-args.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 cmd-line-args.asm -l cmd-line-args.lst
	gcc -g -no-pie -o cmd-line-args.out cmd-line-args.o

cmd-line-args-corrected.out: cmd-line-args-corrected.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 cmd-line-args-corrected.asm -l cmd-line-args-corrected.lst
	ld -g -o cmd-line-args-corrected.out cmd-line-args-corrected.o

clean:
	rm *.lst *.o *.out

