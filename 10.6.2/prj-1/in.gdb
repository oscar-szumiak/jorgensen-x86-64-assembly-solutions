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
echo intNum: \n
x/uw &intNum
echo strNum: \n
x/s &strNum
echo \n\n
set logging off
quit

