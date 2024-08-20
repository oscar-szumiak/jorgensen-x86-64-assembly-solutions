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
x/db &bNum1
echo &bNum2 \n
x/db &bNum2
echo &bNum3 \n
x/db &bNum3
echo &bNum4 \n
x/db &bNum4
echo \n
echo Results: \n
echo bAns1 = bNum1 + bNum2 \n
x/db &bAns1
echo bAns2 = bNum1 + bNum3 \n
x/db &bAns2
echo bAns3 = bNum3 + bNum4 \n
x/db &bAns3
echo bAns6 = bNum1 – bNum2 \n
x/db &bAns6
echo bAns7 = bNum1 – bNum3 \n
x/db &bAns7
echo bAns8 = bNum2 – bNum4 \n
x/db &bAns8
echo wAns11 = bNum1 * bNum3 \n
x/dh &wAns11
echo wAns12 = bNum2 * bNum2 \n
x/dh &wAns12
echo wAns13 = bNum2 * bNum4 \n
x/dh &wAns13
echo bAns16 = bNum1 / bNum2 \n
x/db &bAns16
echo bAns17 = bNum3 / bNum4 \n
x/db &bAns17
echo bAns18 = wNum1 / bNum4 \n
x/db &bAns18
echo bRem18 = wNum1 % bNum4 \n
x/db &bRem18
echo \n\n
set logging off
quit
