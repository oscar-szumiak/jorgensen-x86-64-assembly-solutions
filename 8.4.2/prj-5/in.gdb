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
echo min: \n
x/dw &min
x/xw &min
echo mid  \n
x/dw &mid 
x/xw &mid 
echo max \n
x/dw &max 
x/xw &max 
echo sum \n
x/dw &sum 
x/xw &sum 
echo avg \n
x/dw &avg
x/xw &avg
echo negSum \n
x/dw &negSum
x/xw &negSum
echo negCount \n
x/dw &negCount
x/xw &negCount
echo negAvg \n
x/dw &negAvg
x/xw &negAvg
echo div3Sum \n
x/dw &div3Sum
x/xw &div3Sum
echo div3Count \n
x/dw &div3Count
x/xw &div3Count
echo div3Avg \n
x/dw &div3Avg
x/xw &div3Avg
echo \n\n
set logging off
quit

