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
echo taMin: \n
x/dw &taMin
x/xw &taMin
echo taMax  \n
x/dw &taMax 
x/xw &taMax 
echo taSum  \n
x/dw &taSum 
x/xw &taSum 
echo taAve  \n
x/dw &taAve 
x/xw &taAve 
echo volMin \n
x/dw &volMin
x/xw &volMin
echo volMax \n
x/dw &volMax
x/xw &volMax
echo volSum \n
x/dw &volSum
x/xw &volSum
echo volAve \n
x/dw &volAve
x/xw &volAve
echo \n\n
set logging off
quit
