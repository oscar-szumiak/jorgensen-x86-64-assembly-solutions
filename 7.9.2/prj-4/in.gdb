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
echo Displaying variables: \n
echo \n
echo Data \n
echo &wNum1 \n
x/dh &wNum1
x/xh &wNum1
echo &wNum2 \n
x/dh &wNum2
x/xh &wNum2
echo &wNum3 \n
x/dh &wNum3
x/xh &wNum3
echo &wNum4 \n
x/dh &wNum4
x/xh &wNum4
echo \n
echo Results: \n
echo wAns1 = wNum1 + wNum2 \n
x/dh &wAns1
x/xh &wAns1
echo wAns2 = wNum1 + wNum3 \n
x/dh &wAns2
x/xh &wAns2
echo wAns3 = wNum3 + wNum4 \n
x/dh &wAns3
x/xh &wAns3
echo wAns6 = wNum1 – wNum2 \n
x/dh &wAns6
x/xh &wAns6
echo wAns7 = wNum1 – wNum3 \n
x/dh &wAns7
x/xh &wAns7
echo wAns8 = wNum2 – wNum4 \n
x/dh &wAns8
x/xh &wAns8
echo dAns11 = wNum1 * wNum3 \n
x/dw &dAns11
x/xw &dAns11
echo dAns12 = wNum2 * wNum2 \n
x/dw &dAns12
x/xw &dAns12
echo dAns13 = wNum2 * wNum4 \n
x/dw &dAns13
x/xw &dAns13
echo wAns16 = wNum1 / wNum2 \n
x/dh &wAns16
x/xh &wAns16
echo wAns17 = wNum3 / wNum4 \n
x/dh &wAns17
x/xh &wAns17
echo wAns18 = wNum1 / wNum4 \n
x/dh &wAns18
x/xh &wAns18
echo wRem18 = wNum1 % wNum4 \n
x/dh &wRem18
x/xh &wRem18
echo \n\n
set logging off
quit

