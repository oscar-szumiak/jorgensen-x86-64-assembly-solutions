;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022   Ed Jorgensen
; Copyright (C) 2024        Oscar Szumiak
;

; Implement the example program to convert an integer into a string.
; Change the original integer to a different value.
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.

; Simple example program to convert an
; integer into an ASCII string.

; *********************************************************
; Data declarations

section .data

; -----
; Define constants

NULL                equ     0
EXIT_SUCCESS        equ     0           ; successful operation
SYS_exit            equ     60          ; code for terminate

; -----
; Define Data.

intNum          dd      1786

section .bss

strNum          resb    10

; *********************************************************

section .text

global _start
_start:

; Convert an integer to an ASCII string

; -----
; Part A - Successive division

    mov     eax, dword [intNum]             ; get integer
    mov     rcx, 0                          ; digitCount = 0
    mov     ebx, 10                         ; set for dividing by 10
divideLoop:
    mov     edx, 0
    div     ebx                             ; divide number by 10

    push    rdx                             ; push remainder
    inc     rcx                             ; increment digitCount

    cmp     eax, 0                          ; if (result > 0)
    jne     divideLoop                      ; goto divideLoop

; -----
; Part B - Convert remainders and store

    mov     rbx, strNum                     ; get addr of string
    mov     rdi, 0                          ; idx = 0
popLoop:
    pop     rax                             ; pop intDigit
    add     al, "0"                         ; char = int + "0"
    mov     byte [rbx+rdi], al              ; string[idx] = char
    inc     rdi                             ; increment idx
    loop    popLoop                         ; if (digitCount > 0)
                                            ; goto popLoop
    mov     byte [rbx+rdi], NULL            ; string[idx] = NULL

; -----
; Done, terminate program

last:
    mov     rax, SYS_exit                   ; call code for exit
    mov     rdi, EXIT_SUCCESS               ; exit with success
    syscall

