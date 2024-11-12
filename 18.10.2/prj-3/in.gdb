echo \n\n
break _start
break last
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
continue
echo dqResult: \n
x/fg &dqResult
echo dqExpectedResult: \n
x/fg &dqExpectedResult
echo \n\n
set logging off
quit
