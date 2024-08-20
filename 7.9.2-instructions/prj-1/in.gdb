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
echo Data \n
echo &bNum1 \n
x/ub &bNum1
echo &bNum2 \n
x/ub &bNum2
echo &bNum3 \n
x/ub &bNum3
echo &bNum4 \n
x/ub &bNum4
echo \n
echo Results: \n
echo bAns1 = bNum1 + bNum2 \n
x/ub &bAns1
echo bAns2 = bNum1 + bNum3 \n
x/ub &bAns2
echo bAns3 = bNum3 + bNum4 \n
x/ub &bAns3
echo bAns6 = bNum1 – bNum2 \n
x/ub &bAns6
echo bAns7 = bNum1 – bNum3 \n
x/ub &bAns7
echo bAns8 = bNum2 – bNum4 \n
x/ub &bAns8
echo wAns11 = bNum1 * bNum3 \n
x/uh &wAns11
echo wAns12 = bNum2 * bNum2 \n
x/uh &wAns12
echo wAns13 = bNum2 * bNum4 \n
x/uh &wAns13
echo bAns16 = bNum1 / bNum2 \n
x/ub &bAns16
echo bAns17 = bNum3 / bNum4 \n
x/ub &bAns17
echo bAns18 = wNum1 / bNum4 \n
x/ub &bAns18
echo bRem18 = wNum1 % bNum4 \n
x/ub &bRem18
echo \n\n
set logging off
quit
