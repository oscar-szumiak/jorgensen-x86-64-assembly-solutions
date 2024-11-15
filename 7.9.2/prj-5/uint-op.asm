;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2024 Oscar Szumiak
;

; Create a program to complete the following expressions using unsigned
; double-word sized variables. Note, the first letter of the variable name
; denotes the size (d -> double-word and q -> quadword).
; 
; 1.  dAns1 = dNum1 + dNum2
; 2.  dAns2 = dNum1 + dNum3
; 3.  dAns3 = dNum3 + dNum4
; 4.  dAns6 = dNum1 - dNum2
; 5.  dAns7 = dNum1 - dNum3
; 6.  dAns8 = dNum2 - dNum4
; 7.  qAns11 = dNum1 * dNum3
; 8.  qAns12 = dNum2 * dNum2
; 9.  qAns13 = dNum2 * dNum4
; 10. dAns16 = dNum1 / dNum2
; 11. dAns17 = dNum3 / dNum4
; 12. dAns18 = qNum1 / dNum4
; 13. dRem18 = qNum1 % dNum4
; 
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results in both decimal
; and hexadecimal.

section .data

; Constants

SUCCESS     equ     0
SYS_exit    equ     60

; Variables

dNum1		dd		8
dNum2		dd		6
dNum3		dd		5
dNum4		dd		2

dAns1		dd		0
dAns2		dd		0
dAns3		dd		0
dAns6		dd		0
dAns7		dd		0
dAns8		dd		0
qAns11		dq		0
qAns12		dq		0
qAns13		dq		0
dAns16		dd		0
dAns17		dd		0
dAns18		dd		0
dRem18		dd		0

; *********************

section .text

global _start
_start:

; dAns1 = dNum1 + dNum2

    mov     eax, dword [dNum1]
    add     eax, dword [dNum2]
    mov     dword [dAns1], eax

; dAns2 = dNum1 + dNum3

    mov     eax, dword [dNum1]
    add     eax, dword [dNum3]
    mov     dword [dAns2], eax

; dAns3 = dNum3 + dNum4

    mov     eax, dword [dNum3]
    add     eax, dword [dNum4]
    mov     dword [dAns3], eax

; dAns6 = dNum1 - dNum2

    mov     eax, dword [dNum1]
    sub     eax, dword [dNum2]
    mov     dword [dAns6], eax

; dAns7 = dNum1 - dNum3

    mov     eax, dword [dNum1]
    sub     eax, dword [dNum3]
    mov     dword [dAns7], eax

; dAns8 = dNum2 - dNum4

    mov     eax, dword [dNum2]
    sub     eax, dword [dNum4]
    mov     dword [dAns8], eax

; qAns11 = dNum1 * dNum3

    mov     eax, dword [dNum1]
    mul     dword [dNum3]
    mov     dword [qAns11], eax
    mov     dword [qAns11+4], edx

; qAns12 = dNum2 * dNum2

    mov     eax, dword [dNum2]
    mul     eax
    mov     dword [qAns12], eax
    mov     dword [qAns12+4], edx

; qAns13 = dNum2 * dNum4

    mov     eax, dword [dNum2]
    mul     dword [dNum4]
    mov     dword [qAns13], eax
    mov     dword [qAns13+4], edx

; dAns16 = dNum1 / dNum2

    mov     edx, 0
    mov     eax, dword [dNum1]
    div     dword [dNum2]
    mov     dword [dAns16], eax

; dAns17 = dNum3 / dNum4

    mov     edx, 0
    mov     eax, dword [dNum3]
    div     dword [dNum4]
    mov     dword [dAns17], eax

; dAns18 = dNum1 / dNum4

    mov     edx, 0
    mov     eax, dword [dNum1]
    div     dword [dNum4]
    mov     dword [dAns18], eax

; dRem18 = dNum1 % dNum4

    mov     dword [dRem18], edx

last:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall

