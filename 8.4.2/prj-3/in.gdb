echo \n\n
break last
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
echo taMin: \n
x/uw &taMin
x/xw &taMin
echo taMax  \n
x/uw &taMax 
x/xw &taMax 
echo taSum  \n
x/uw &taSum 
x/xw &taSum 
echo taAve  \n
x/uw &taAve 
x/xw &taAve 
echo volMin \n
x/uw &volMin
x/xw &volMin
echo volMax \n
x/uw &volMax
x/xw &volMax
echo volSum \n
x/uw &volSum
x/xw &volSum
echo volAve \n
x/uw &volAve
x/xw &volAve
echo \n\n
set logging off
quit
