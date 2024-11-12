;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022   Ed Jorgensen
; Copyright (C) 2024        Oscar Szumiak
;

; Create a program to compute the square of the sum from 1 to n.
; Specifically, compute the sum of integers from 1 to n and then square
; the value. Use the debugger to execute the program and display the final
; results. Create a debugger input file to show the results in both decimal
; and hexadecimal.

;  Data declarations

section .data

; -----
;  Define constants

SUCCESS         equ     0       ; Successful operation
SYS_exit        equ     60      ; call code for terminate

;  Define Data.

n               dd      10
sum             dd      0
squareOfSum     dq      0

; *******************************************************

section .text
global _start
_start:

; -----
; sum = n * (n + 1) / 2

    mov eax, dword [n]
    add eax, 1
    mul dword [n]
    mov ebx, 2
    div ebx
    mov dword [sum], eax

; -----
; squareOfSum = sum * sum

    mov eax, dword [sum]
    mul eax
    mov dword [squareOfSum], eax
    mov dword [squareOfSum+4], edx

; -----
;  Done, terminate program.

last:
    mov rax, SYS_exit ; call code for exit
    mov rdi, SUCCESS ; exit with success
    syscall

