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
echo sum: \n
x/dw &sum
x/xw &sum
echo squareOfSum: \n
x/dg &squareOfSum
x/xg &squareOfSum
echo \n\n
set logging off
quit

