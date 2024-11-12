;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

; Implement the floating-point absolute value function as two macros,
; one fAbsf for 32-bit floating-point values and fAbsd for 64-bit
; floating-point values.  Create a simple main program that uses each
; macro three times on various different values. Use the debugger
; to execute the program and verify the results.

; fAbsf <32-bit value>
%macro fAbsf 1

    movss       xmm0, dword [%1]
    ucomiss     xmm0, dword [dZero]
    jae         %%isPos
    mulss       xmm0, dword [dNegOne]
    movss       dword [%1], xmm0

%%isPos:

%endmacro

; fAbsd <64-bit value>
%macro fAbsd 1

    movsd       xmm0, qword [%1]
    ucomisd     xmm0, qword [qZero]
    jae         %%isPos
    mulsd       xmm0, qword [qNegOne]
    movsd       qword [%1], xmm0

%%isPos:

%endmacro


section .data

; -----
; Define constants.

TRUE        equ     1
FALSE       equ     0
SUCCESS     equ     0       ; successful operation
SYS_exit    equ     60      ; call code for terminate

; -----
; Define some test variables.

; 32-bit
dZero        dd      0.0
dNegOne      dd      -1.0

; 64-bit
qZero        dq      0.0
qNegOne      dq      -1.0

; Test values

; 32-bit
fltVal1      dd      -8.25
fltVal2      dd      5.34
fltVal3      dd      -0.3

; 64-bit
dblVal1      dq      -3.56
dblVal2      dq      0.44
dblVal3      dq      10.00

; *********************************************************

section .text

global _start
_start:

    fAbsf   fltVal1
    fAbsf   fltVal2
    fAbsf   fltVal3
    
    fAbsd   dblVal1
    fAbsd   dblVal2
    fAbsd   dblVal3

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit
    mov     rbx, SUCCESS       ; exit w/success
    syscall
