echo \n\n
break last
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
echo min: \n
x/uw &min
x/xw &min
echo mid  \n
x/uw &mid 
x/xw &mid 
echo max \n
x/uw &max 
x/xw &max 
echo sum \n
x/uw &sum 
x/xw &sum 
echo avg \n
x/uw &avg
x/xw &avg
echo div3Sum \n
x/uw &div3Sum
x/xw &div3Sum
echo div3Count \n
x/uw &div3Count
x/xw &div3Count
echo div3Avg \n
x/uw &div3Avg
x/xw &div3Avg
echo \n\n
set logging off
quit
