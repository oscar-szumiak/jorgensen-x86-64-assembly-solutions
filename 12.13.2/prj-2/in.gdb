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
echo list1: \n
x/5dw &list1
echo min1: \n
x/dw &min1
echo med11: \n
x/dw &med11
echo med12: \n
x/dw &med12
echo max1: \n
x/dw &max1
echo sum1: \n
x/dw &sum1
echo ave1: \n
x/dw &ave1
echo list2: \n
x/7dw &list2
echo min2: \n
x/dw &min2
echo med21: \n
x/dw &med21
echo med22: \n
x/dw &med22
echo max2: \n
x/dw &max2
echo sum2: \n
x/dw &sum2
echo ave2: \n
x/dw &ave2
echo \n\n
set logging off
quit

