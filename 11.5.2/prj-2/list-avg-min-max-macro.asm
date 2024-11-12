;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022   Ed Jorgensen
; Copyright (C) 2024        Oscar Szumiak
;

; Update the program from the previous question to include the minimum
; and maximum values. Use the debugger to execute the program and display
; the final results. Create a debugger input file to show the results.

; **************************************************
; Define the macro called with five arguments:
; aver <lst>, <len>, <ave>, <min>, <max>

%macro aver 5
    mov     r12, 0
    lea     rbx, [%1]

    mov     edx, dword [rbx]
    mov     dword [%4], edx
    mov     edx, dword [rbx]
    mov     dword [%5], edx
    
    mov     eax, 0
    mov     ecx, dword [%2]             ; length

%%sumLoop:
    mov     edx, dword [rbx+r12*4]      ; get list[n]

    cmp     edx, dword [%4]
    jg      %%noNewMin

    mov     dword [%4], edx
    jmp     %%noNewMax

%%noNewMin:

    cmp     edx, dword [%5]
    jl      %%noNewMax

    mov     dword [%5], edx

%%noNewMax:

    add     eax, edx                    ; add list[n]
    inc     r12
    loop    %%sumLoop
    
    cdq
    idiv    dword [%2]
    mov     dword [%3], edx

%endmacro

; **************************************************
; Data declarations

section     .data

; -----
; Define constants

EXIT_SUCCESS    equ 0          ; success code
SYS_exit        equ 60         ; code for terminate

; Define Data.

section     .data

list1       dd      4, 5, 2, -3, 1
len1        dd      5
ave1        dd      0
min1        dd      0
max1        dd      0

list2       dd      2, 6, 3, -2, 1, 8, 19
len2        dd      7
ave2        dd      0
min2        dd      0
max2        dd      0

; **************************************************

section     .text
global _start
_start:

; -----
; Use the macro in the program

aver    list1, len1, ave1, min1, max1       ; 1st, data set 1
aver    list2, len2, ave2, min2, max2       ; 2nd, data set 2

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

