; Create a program to complete the following expressions using signed word
; sized variables. Note, the first letter of the variable name denotes
; the size (w → word and d → double-word).
; 
; 1.  wAns1 = wNum1 + wNum2
; 2.  wAns2 = wNum1 + wNum3
; 3.  wAns3 = wNum3 + wNum4
; 4.  wAns6 = wNum1 – wNum2
; 5.  wAns7 = wNum1 – wNum3
; 6.  wAns8 = wNum2 – wNum4
; 7.  dAns11 = wNum1 * wNum3
; 8.  dAns12 = wNum2 * wNum2
; 9.  dAns13 = wNum2 * wNum4
; 10. wAns16 = wNum1 / wNum2
; 11. wAns17 = wNum3 / wNum4
; 12. wAns18 = dNum1 / wNum4
; 13. wRem18 = dNum1 % wNum4
; 
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results in both decimal
; and hexadecimal.

section .data

; Constants

SUCCESS     equ     0
SYS_exit    equ     60

; Variables

wNum1		dw		8
wNum2		dw		6
wNum3		dw		5
wNum4		dw		2

wAns1		dw		0
wAns2		dw		0
wAns3		dw		0
wAns6		dw		0
wAns7		dw		0
wAns8		dw		0
dAns11		dd		0
dAns12		dd		0
dAns13		dd		0
wAns16		dw		0
wAns17		dw		0
wAns18		dw		0
wRem18		dw		0

; *********************

section .text
global _start
_start:

; wAns1 = wNum1 + wNum2

    mov     ax, word [wNum1]
    add     ax, word [wNum2]
    mov     word [wAns1], ax

; wAns2 = wNum1 + wNum3

    mov     ax, word [wNum1]
    add     ax, word [wNum3]
    mov     word [wAns2], ax

; wAns3 = wNum3 + wNum4

    mov     ax, word [wNum3]
    add     ax, word [wNum4]
    mov     word [wAns3], ax

; wAns6 = wNum1 – wNum2

    mov     ax, word [wNum1]
    sub     ax, word [wNum2]
    mov     word [wAns6], ax

; wAns7 = wNum1 – wNum3

    mov     ax, word [wNum1]
    sub     ax, word [wNum3]
    mov     word [wAns7], ax

; wAns8 = wNum2 – wNum4

    mov     ax, word [wNum2]
    sub     ax, word [wNum4]
    mov     word [wAns8], ax

; dAns11 = wNum1 * wNum3

    mov     ax, word [wNum1]
    imul    word [wNum3]
    mov     word [dAns11], ax
    mov     word [dAns11+2], dx

; dAns12 = wNum2 * wNum2

    mov     ax, word [wNum2]
    imul    ax
    mov     word [dAns12], ax
    mov     word [dAns12+2], dx

; dAns13 = wNum2 * wNum4

    mov     ax, word [wNum2]
    imul    word [wNum4]
    mov     word [dAns13], ax
    mov     word [dAns13+2], dx

; wAns16 = wNum1 / wNum2

    mov     ax, word [wNum1]
    cwd
    idiv    word [wNum2]
    mov     word [wAns16], ax

; wAns17 = wNum3 / wNum4

    mov     ax, word [wNum3]
    cwd
    idiv    word [wNum4]
    mov     word [wAns17], ax

; wAns18 = dNum1 / wNum4

    mov     ax, word [wNum1]
    cwd
    idiv    word [wNum4]
    mov     word [wAns18], ax

; wRem18 = dNum1 % wNum4

    mov     word [wRem18], dx

last:
    mov rax, SYS_exit
    mov rdi, SUCCESS
    syscall

