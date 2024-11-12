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
x/uh &wNum1
x/xh &wNum1
echo &wNum2 \n
x/uh &wNum2
x/xh &wNum2
echo &wNum3 \n
x/uh &wNum3
x/xh &wNum3
echo &wNum4 \n
x/uh &wNum4
x/xh &wNum4
echo \n
echo Results: \n
echo wAns1 = wNum1 + wNum2 \n
x/uh &wAns1
x/xh &wAns1
echo wAns2 = wNum1 + wNum3 \n
x/uh &wAns2
x/xh &wAns2
echo wAns3 = wNum3 + wNum4 \n
x/uh &wAns3
x/xh &wAns3
echo wAns6 = wNum1 – wNum2 \n
x/uh &wAns6
x/xh &wAns6
echo wAns7 = wNum1 – wNum3 \n
x/uh &wAns7
x/xh &wAns7
echo wAns8 = wNum2 – wNum4 \n
x/uh &wAns8
x/xh &wAns8
echo dAns11 = wNum1 * wNum3 \n
x/uw &dAns11
x/xw &dAns11
echo dAns12 = wNum2 * wNum2 \n
x/uw &dAns12
x/xw &dAns12
echo dAns13 = wNum2 * wNum4 \n
x/uw &dAns13
x/xw &dAns13
echo wAns16 = wNum1 / wNum2 \n
x/uh &wAns16
x/xh &wAns16
echo wAns17 = wNum3 / wNum4 \n
x/uh &wAns17
x/xh &wAns17
echo wAns18 = wNum1 / wNum4 \n
x/uh &wAns18
x/xh &wAns18
echo wRem18 = wNum1 % wNum4 \n
x/uh &wRem18
x/xh &wRem18
echo \n\n
set logging off
quit
