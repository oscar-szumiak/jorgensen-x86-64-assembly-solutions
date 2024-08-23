#------------------------------------
#  Debugger Input Script
#------------------------------------
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
echo &dNum1 \n
x/dw &dNum1
x/xw &dNum1
echo &dNum2 \n
x/dw &dNum2
x/xw &dNum2
echo &dNum3 \n
x/dw &dNum3
x/xw &dNum3
echo &dNum4 \n
x/dw &dNum4
x/xw &dNum4
echo \n
echo Results: \n
echo wAns1 = dNum1 + dNum2 \n
x/dw &dAns1
x/xw &dAns1
echo wAns2 = dNum1 + dNum3 \n
x/dw &dAns2
x/xw &dAns2
echo wAns3 = dNum3 + dNum4 \n
x/dw &dAns3
x/xw &dAns3
echo wAns6 = dNum1 – dNum2 \n
x/dw &dAns6
x/xw &dAns6
echo wAns7 = dNum1 – dNum3 \n
x/dw &dAns7
x/xw &dAns7
echo wAns8 = dNum2 – dNum4 \n
x/dw &dAns8
x/xw &dAns8
echo dAns11 = dNum1 * dNum3 \n
x/dg &qAns11
x/xg &qAns11
echo dAns12 = dNum2 * dNum2 \n
x/dg &qAns12
x/xg &qAns12
echo dAns13 = dNum2 * dNum4 \n
x/dg &qAns13
x/xg &qAns13
echo wAns16 = dNum1 / dNum2 \n
x/dw &dAns16
x/xw &dAns16
echo wAns17 = dNum3 / dNum4 \n
x/dw &dAns17
x/xw &dAns17
echo wAns18 = dNum1 / dNum4 \n
x/dw &dAns18
x/xw &dAns18
echo wRem18 = dNum1 % dNum4 \n
x/dw &dRem18
x/xw &dRem18
echo \n\n
set logging off
quit
