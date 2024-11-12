#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

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
echo fltVal1: \n
x/fw &fltVal1
echo fltVal2: \n
x/fw &fltVal2
echo fltVal3: \n
x/fw &fltVal3
echo dblVal1: \n
x/fg &dblVal1
echo dblVal2: \n
x/fg &dblVal2
echo dblVal3: \n
x/fg &dblVal3
continue
echo After: \n
echo fltVal1: \n
x/fw &fltVal1
echo fltVal2: \n
x/fw &fltVal2
echo fltVal3: \n
x/fw &fltVal3
echo dblVal1: \n
x/fg &dblVal1
echo dblVal2: \n
x/fg &dblVal2
echo dblVal3: \n
x/fg &dblVal3
echo \n\n
set logging off
quit

