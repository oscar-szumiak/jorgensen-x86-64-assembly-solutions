;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022   Ed Jorgensen
; Copyright (C) 2024        Oscar Szumiak
;

; Create a macro from the integer to ASCII conversion example from
; the previous chapter. Invoke the macro at least three times of three
; different data sets. Use the debugger to execute the program and display
; the final results. Create a debugger input file to show the results.

; *********************************************************
; Data declarations

; Convert an integer to an ASCII string
; uint-to-string <int> <string>

%macro uintToString 2

; -----
; Part A - Successive division

    mov     eax, dword [%1]                 ; get integer

    mov     rcx, 0                          ; digitCount = 0
    mov     ebx, 10                         ; set for dividing by 10
%%divideLoop:
    mov     edx, 0
    div     ebx                             ; divide number by 10

    push    rdx                             ; push remainder
    inc     rcx                             ; increment digitCount

    cmp     eax, 0                          ; if (result > 0)
    jne     %%divideLoop                    ; goto divideLoop

; -----
; Part B - Convert remainders and store

    lea     rbx, [%2]                       ; get addr of string
    mov     rdi, 0                          ; idx = 0
%%popLoop:
    pop     rax                             ; pop intDigit
    add     al, "0"                         ; char = int + "0"
    mov     byte [rbx+rdi], al              ; string[idx] = char
    inc     rdi                             ; increment idx
    loop    %%popLoop                       ; if (digitCount > 0)
                                            ; goto popLoop
    mov     byte [rbx+rdi], NULL            ; string[idx] = NULL

%endmacro

section .data

; -----
; Define constants

NULL                equ     0
EXIT_SUCCESS        equ     0           ; successful operation
SYS_exit            equ     60          ; code for terminate

; -----
; Define Data.

intNum1          dd      1786
intNum2          dd      348
intNum3          dd      86

section .bss

strNum1          resb    10
strNum2          resb    10
strNum3          resb    10

; *********************************************************

section .text

global _start
_start:

; Macro calls

    uintToString      intNum1, strNum1
    uintToString      intNum2, strNum2
    uintToString      intNum3, strNum3

; -----
; Done, terminate program

last:
    mov     rax, SYS_exit                       ; call code for exit
    mov     rdi, EXIT_SUCCESS                   ; exit with success
    syscall

