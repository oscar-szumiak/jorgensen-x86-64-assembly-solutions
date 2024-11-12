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
echo intNum1: \n
x/uw &intNum1
echo strNum1: \n
x/s &strNum1
echo intNum2: \n
x/uw &intNum2
echo strNum2: \n
x/s &strNum2
echo intNum3: \n
x/uw &intNum3
echo strNum3: \n
x/s &strNum3
echo \n\n
set logging off
quit

