;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022 Ed Jorgensen
;

; Implement the example program to find the sum and average for a list
; of floating-point values. Use the debugger to execute the program
; and verify the final results.

; Floating-Point Example Program
; ***********************************************************

section .data

; -----
; Define constants.

NULL            equ 0       ; end of string
TRUE            equ 1
FALSE           equ 0

EXIT_SUCCESS    equ 0       ; Successful operation
SYS_exit        equ 60      ; system call code for terminate

; -----

fltLst      dq  21.34, 6.15, 9.12, 10.05, 7.75
            dq  1.44, 14.50, 3.32, 75.71, 11.87
            dq  17.23, 18.25, 13.65, 24.24, 8.88
length      dd  15

lstSum      dq  0.0
lstAve      dq  0.0

; ***********************************************************

section .text

global _start
_start:

; -----
; Loop to find floating-point sum.

    mov         ecx, [length]
    mov         rbx, fltLst
    mov         rsi, 0
    movsd       xmm1, qword [lstSum]

sumLp:
    movsd       xmm0, qword [rbx+rsi*8]     ; get fltLst[i]
    addsd       xmm1, xmm0                  ; update sum
    inc         rsi                         ; i++
    loop        sumLp
    
    movsd       qword [lstSum], xmm1        ; save sum

; -----
; Compute average of entire list.

    cvtsi2sd    xmm0, dword [length]
    ; cvtsd2si    eax, xmm0
    ; mov         dword [length], eax
    divsd       xmm1, xmm0
    movsd       qword [lstAve], xmm1

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit
    mov     rbx, EXIT_SUCCESS               ; exit w/success
    syscall

