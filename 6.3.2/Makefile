#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

file_name := example

all:
	./asm64 $(file_name)

debug:
	gdb $(file_name).out < in.gdb

clean:
	rm $(file_name).lst $(file_name).o $(file_name).out out.txt

