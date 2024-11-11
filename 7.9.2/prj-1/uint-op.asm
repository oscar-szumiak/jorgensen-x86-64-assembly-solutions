; Create a program to compute the following expressions using unsigned byte
; variables and unsigned operations. Note, the first letter of the variable
; name denotes the size (b → byte and w → word).
;
; 1.  bAns1 = bNum1 + bNum2
; 2.  bAns2 = bNum1 + bNum3
; 3.  bAns3 = bNum3 + bNum4
; 4.  bAns6 = bNum1 – bNum2
; 5.  bAns7 = bNum1 – bNum3
; 6.  bAns8 = bNum2 – bNum4
; 7.  wAns11 = bNum1 * bNum3
; 8.  wAns12 = bNum2 * bNum2
; 9.  wAns13 = bNum2 * bNum4
; 10. bAns16 = bNum1 / bNum2
; 11. bAns17 = bNum3 / bNum4
; 12. bAns18 = wNum1 / bNum4
; 13. bRem18 = wNum1 % bNum4
;
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results in both decimal
; and hexadecimal.

section .data

; Constants

SUCCESS     equ     0
SYS_exit    equ     60

; Variables

bNum1		db		8
bNum2		db		6
bNum3		db		5
bNum4		db		2

bAns1		db		0
bAns2		db		0
bAns3		db		0
bAns6		db		0
bAns7		db		0
bAns8		db		0
wAns11		dw		0
wAns12		dw		0
wAns13		dw		0
bAns16		db		0
bAns17		db		0
bAns18		db		0
bRem18		db		0

; *********************

section .text
global _start
_start:

; bAns1 = bNum1 + bNum2

    mov     al, byte [bNum1]
    add     al, byte [bNum2]
    mov     byte [bAns1], al

; bAns2 = bNum1 + bNum3

    mov     al, byte [bNum1]
    add     al, byte [bNum3]
    mov     byte [bAns2], al

; bAns3 = bNum3 + bNum4

    mov     al, byte [bNum3]
    add     al, byte [bNum4]
    mov     byte [bAns3], al

; bAns6 = bNum1 – bNum2

    mov     al, byte [bNum1]
    sub     al, byte [bNum2]
    mov     byte [bAns6], al

; bAns7 = bNum1 – bNum3

    mov     al, byte [bNum1]
    sub     al, byte [bNum3]
    mov     byte [bAns7], al

; bAns8 = bNum2 – bNum4

    mov     al, byte [bNum2]
    sub     al, byte [bNum4]
    mov     byte [bAns8], al

; wAns11 = bNum1 * bNum3

    mov     al, byte [bNum1]
    mul     byte [bNum3]
    mov     word [wAns11], ax

; wAns12 = bNum2 * bNum2

    mov     al, byte [bNum2]
    mul     al
    mov     word [wAns12], ax

; wAns13 = bNum2 * bNum4

    mov     al, byte [bNum2]
    mul     byte [bNum4]
    mov     word [wAns13], ax

; bAns16 = bNum1 / bNum2

    mov     al, byte [bNum1]
    mov     ah, 0
    div     byte [bNum2]
    mov     byte [bAns16], al

; bAns17 = bNum3 / bNum4

    mov     al, byte [bNum3]
    mov     ah, 0
    div     byte [bNum4]
    mov     byte [bAns17], al

; bAns18 = wNum1 / bNum4

    mov     al, byte [bNum1]
    mov     ah, 0
    div     byte [bNum4]
    mov     byte [bAns18], al

; bRem18 = wNum1 % bNum4

    mov     byte [bRem18], ah

last:
    mov rax, SYS_exit
    mov rdi, SUCCESS
    syscall

