#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

file_name := file-read

all:
	yasm -Worphan-labels -g dwarf2 -f elf64 $(file_name).asm -l $(file_name).lst
	ld -g -o $(file_name).out $(file_name).o

clean:
	rm $(file_name).lst $(file_name).o $(file_name).out

