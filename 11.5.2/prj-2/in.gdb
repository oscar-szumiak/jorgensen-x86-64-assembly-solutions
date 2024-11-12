echo \n\n
break last
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
echo ave1: \n
x/dw &ave1
echo min1: \n
x/dw &min1
echo max1: \n
x/dw &max1
echo ave2: \n
x/dw &ave2
echo min2: \n
x/dw &min2
echo max2: \n
x/dw &max2
echo \n\n
set logging off
quit
