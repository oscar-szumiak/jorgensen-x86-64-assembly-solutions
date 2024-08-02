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
echo Displaying variables: \n
echo \n
echo 8-bit \n
x/db &bVar1
x/db &bVar2
x/db &bResult
echo \n
echo 16-bit \n
x/dh &wVar1
x/dh &wVar2
x/dh &wResult
echo \n
echo 32-bit \n
x/dw &dVar1
x/dw &dVar2
x/dw &dResult
echo \n
echo 64-bit \n
x/dg &qVar1
x/dg &qVar2
x/dg &qResult
echo \n\n
set logging off
quit
