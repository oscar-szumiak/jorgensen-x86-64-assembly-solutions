#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

echo \n\n
break funStart
break funEnd
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
echo rbp: \n
p/x $rbp
echo rsp: \n
p/x $rsp
echo memory segment: \n
x/8xg $rsp
continue
echo rbp: \n
p/x $rbp
echo rsp: \n
p/x $rsp
echo memory segment: \n
x/8xg $rsp
echo \n\n
set logging off
quit

