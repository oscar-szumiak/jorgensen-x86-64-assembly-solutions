;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

; Implement the assembly language example program to find the sum and average
; for a list of signed integers. Ensure that the main and function
; are in different source files. Use the debugger to execute the program
; and display the final results.

section .data

EXIT_SUCCESS    equ     0
SYS_exit        equ     60

list1           dd      4, 5, 2, -3, 1
len1            dd      5

list2           dd      2, 6, 3, -2, 1, 8, 19
len2            dd      7

section .bss

sum1            resd    1
avg1            resd    1

sum2            resd    1
avg2            resd    1

; **************************************************

section .text

extern stats

global _start
_start:

; Call function stats for list1

    mov     rdi, list1
    mov     esi, dword [len1]
    mov     rdx, sum1
    mov     rcx, avg1
    call    stats

; Call function stats for list1

    mov     rdi, list2
    mov     esi, dword [len2]
    mov     rdx, sum2
    mov     rcx, avg2
    call    stats

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

