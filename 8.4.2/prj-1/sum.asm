;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022 Ed Jorgensen
;

; Implement the example program to sum a list of numbers. Use the debugger
; to execute the program and display the final results. Create a debugger
; input file to show the results.

; *****************************************************
; Data declarations

section .data

; -----
; Define constants

EXIT_SUCCESS    equ 0       ; successful operation
SYS_exit        equ 60      ; call code for terminate

; -----
; Define Data.

section .data

lst     dd      1002, 1004, 1006, 1008, 10010
len     dd      5
sum     dd      0

; ********************************************************

section .text

global _start
_start:

; -----
; Summation loop.

    mov     ecx, dword [len]            ; get length value
    mov     rsi, 0                      ; index=0
sumLoop:
    mov     eax, dword [lst+(rsi*4)]    ; get lst[rsi]
    add     dword [sum], eax            ; update sum
    inc     rsi                         ; next item
    loop    sumLoop

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit               ; call code for exit
    mov     rdi, EXIT_SUCCESS           ; exit with success
    syscall

