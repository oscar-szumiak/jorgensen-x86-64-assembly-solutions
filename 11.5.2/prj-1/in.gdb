#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

echo \n\n
break last
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
echo ave1: \n
x/dw &ave1
echo ave2: \n
x/dw &ave2
echo \n\n
set logging off
quit

