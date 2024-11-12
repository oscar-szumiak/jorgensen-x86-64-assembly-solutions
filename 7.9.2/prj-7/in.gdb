echo \n\n
break last
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
echo Sum: \n
x/dg &sumOfSquares
x/xg &sumOfSquares
echo \n\n
set logging off
quit
