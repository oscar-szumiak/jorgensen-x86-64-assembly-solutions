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
echo list2: \n
x/7dw &list2
echo list3: \n
x/4dw &list3
echo \n\n
set logging off
quit

