#------------------------------------
#  Debugger Input Script
#------------------------------------
echo \n\n
break 35
break last
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
echo numbers before: \n
x/5ug &numbers
continue
echo numbers after: \n
x/5ug &numbers
echo \n\n
set logging off
quit
