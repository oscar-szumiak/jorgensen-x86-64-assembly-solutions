echo \n\n
break last
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
echo Is string palindrome: \n
x/s &string
echo Answer (0 - True; 1 - False): \n
x/ub &isPalindrome
echo \n\n
set logging off
quit
