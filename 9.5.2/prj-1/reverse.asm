;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022 Ed Jorgensen
;

; Implement the example program to reverse a list of numbers.
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.

; Simple example demonstrating basic stack operations.

; Reverse a list of numbers - in place.
; Method: Put each number on stack, then pop each number
; back off, and then put back into memory.

; *****************************************************
; Data declarations

section .data

; -----
; Define constants

EXIT_SUCCESS    equ     0       ; successful operation
SYS_exit        equ     60      ; call code for terminate

; -----
; Define Data.

numbers     dq      121, 122, 123, 124, 125
len         dq      5

; ****************************************************

section .text

global _start
_start:

; Loop to put numbers on stack.
    mov     rcx, qword [len]
    mov     rbx, numbers
    mov     r12, 0
    mov     rax, 0

pushLoop:
    push    qword [rbx+r12*8]
    inc     r12
    loop    pushLoop

; -----
; All the numbers are on stack (in reverse order).
; Loop to get them back off. Put them back into
; the original list...

    mov     rcx, qword [len]
    mov     rbx, numbers
    mov     r12, 0
popLoop:
    pop     rax
    mov     qword [rbx+r12*8], rax
    inc     r12
    loop    popLoop

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit               ; call code for exit
    mov     rdi, EXIT_SUCCESS           ; exit with success
    syscall

