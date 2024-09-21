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
echo Before: \n
echo list1: \n
x/5dw &list1
echo list2: \n
x/7dw &list2
echo list3: \n
x/4dw &list3
continue
echo After: \n
echo list1: \n
x/5dw &list1
echo min1: \n
x/dw &min1
echo med11: \n
x/dw &med11
echo med12: \n
x/dw &med12
echo max1: \n
x/dw &max1
echo sum1: \n
x/dw &sum1
echo avg1: \n
x/dw &avg1
echo std1: \n
x/dw &std1
echo list2: \n
x/7dw &list2
echo min2: \n
x/dw &min2
echo med21: \n
x/dw &med22
echo med21: \n
x/dw &med22
echo max2: \n
x/dw &max2
echo sum2: \n
x/dw &sum2
echo avg2: \n
x/dw &avg2
echo std2: \n
x/dw &std2
echo list3: \n
x/4dw &list3
echo min3: \n
x/dw &min3
echo med31: \n
x/dw &med32
echo med31: \n
x/dw &med32
echo max3: \n
x/dw &max3
echo sum3: \n
x/dw &sum3
echo avg3: \n
x/dw &avg3
echo std3: \n
x/dw &std3
echo \n\n
set logging off
quit
