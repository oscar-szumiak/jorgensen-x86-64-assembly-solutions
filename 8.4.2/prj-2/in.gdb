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
echo Sum: \n
x/dw &sum
x/xw &sum
echo Min: \n
x/dw &min
x/xw &min
echo Max: \n
x/dw &max
x/xw &max
echo Avg: \n
x/dw &avg
x/xw &avg
echo \n\n
set logging off
quit
