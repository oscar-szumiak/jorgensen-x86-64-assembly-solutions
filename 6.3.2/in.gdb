# After completing the previous problem, create a debugger input file that
# will set the send the output to a text file, set a breakpoint, execute
# the program, and display the results for each variable (based
# on the appropriate variable size).  Execute the debugger and read the source
# file. Review the input file worked correctly and that the program
# calculations are correct based on the results shown in the output file.

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
