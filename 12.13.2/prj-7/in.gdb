echo \n\n
break last
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
echo strNum1: \n
x/s &strNum1
echo intNum1: \n
x/dw &intNum1
echo exit1: \n
x/dg &exit1
echo strNum2: \n
x/s &strNum2
echo intNum2: \n
x/dw &intNum2
echo exit2: \n
x/dg &exit2
echo strNum3: \n
x/s &strNum3
echo intNum3: \n
x/dw &intNum3
echo exit3: \n
x/dg &exit3
echo \n\n
set logging off
quit
