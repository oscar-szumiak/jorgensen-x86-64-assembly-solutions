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
echo strNum: \n
x/s &strNum
echo intNum: \n
x/dw &intNum
echo \n\n
set logging off
quit
