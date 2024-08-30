#------------------------------------
#  Debugger Input Script
#------------------------------------
echo \n\n
break _start
break last
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
echo Input \n
x/10uw &lst
continue
echo Output \n
x/10uw &lst
echo \n\n
set logging off
quit
