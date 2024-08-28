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
echo \n\n
set logging off
quit
