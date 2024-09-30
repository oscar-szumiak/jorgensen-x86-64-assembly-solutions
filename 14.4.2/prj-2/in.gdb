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
echo list1: \n
x/5dw &list1
echo sum1: \n
x/dw &sum1
echo avg1: \n
x/dw &avg1
echo list2: \n
x/7dw &list2
echo sum2: \n
x/dw &sum2
echo avg2: \n
x/dw &avg2
echo \n\n
set logging off
quit
