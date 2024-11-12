#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

all: thread-tests.out

thread-tests.out: thread-tests.o
	ld -g -o thread-tests.out thread-tests.o -lpthread

thread-tests.o: thread-tests.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 thread-tests.asm -l thread-tests.lst

clean:
	rm *.lst *.o *.out

