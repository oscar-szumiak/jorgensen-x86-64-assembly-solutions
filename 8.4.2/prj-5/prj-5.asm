;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2024 Oscar Szumiak
;

; Repeat the previous program using signed values and signed operations.
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.

; Write an assembly language program to find the:
; - minimum,
; - middle value,
; - maximum,
; - sum, and
; - integer average
; of a list of numbers.
;
; Additionally, the program should also find the:
; - sum,
; - count, and
; - integer average
; for the negative numbers.
; 
; The program should also find the:
; - sum,
; - count, and
; - integer average
; for the numbers that are evenly divisible by 3.
;
; Unlike the median, the 'middle value' does not require the numbers
; to be sorted. Note, for an odd number of items, the middle value is defined
; as the middle value. For an even number of values, it is the integer average
; of the two middle values. Assume all data is signed. Use the debugger
; to execute the program and display the final results. Create a debugger
; input file to show the results.

section .data

; Constants

EXIT_SUCCESS    equ     0       ; successful operation
SYS_exit        equ     60      ; call code for terminate

; Data

set_A       dd     10,    -14,    13,    -37,    54,     3

len         dd  6

min         dd  0
mid         dd  0
max         dd  0
sum         dd  0
avg         dd  0

negSum      dd  0
negCount    dd  0
negAvg      dd  0

div3Sum     dd  0
div3Count   dd  0
div3Avg     dd  0

section .text
global _start
_start:

; Initialize registers

    mov     ecx, dword [len]                ; Index
    mov     ebx, dword [set_A+4*(ecx-1)]    ; Copy set_A[len-1] ebx
    mov     dword [min], ebx                ; Copy ebx into min
    mov     dword [max], ebx                ; Copy ebx into max
    mov     eax, 0                          ; Sum = 0

sumLoop:
    mov     ebx, dword [set_A+4*(ecx-1)]
    add     eax, ebx
    cmp     dword [min], ebx
    jl      noNewMin
    mov     dword [min], ebx
noNewMin:
    cmp     dword [max], ebx
    jg      noNewMax
    mov     dword [max], ebx
noNewMax:
    mov     esi, eax
    mov     eax, ebx
    cdq
    mov     edi, 3
    idiv    edi
    cmp     edx, 0                          ; Check if divisable by 3
    jne     noDiv3
    inc     dword [div3Count]
    add     dword [div3Sum], ebx
noDiv3:
    mov     eax, ebx
    cmp     ebx, 0
    jg      noNeg
    inc     dword [negCount]
    add     dword [negSum], ebx
noNeg:
    mov     eax, esi
    loop    sumLoop

; Save sum

    mov     dword [sum], eax

; Calculate avg

    cdq
    idiv    dword [len]
    mov     dword [avg], eax

; Calculate div3Avg

    mov     eax, dword [div3Sum]
    cdq
    idiv    dword [div3Count]
    mov     dword [div3Avg], eax

; Calculate div3Avg

    mov     eax, dword [negSum]
    cdq
    idiv    dword [negCount]
    mov     dword [negAvg], eax

; Calculate mid

    mov     eax, dword [len]
    cdq
    mov     ecx, 2
    idiv    ecx
    cmp     edx, 0
    jne     odd

; Calculate average of the two mid values

    mov     ebx, eax
    mov     eax, dword [set_A+4*ebx]
    dec     ebx
    add     eax, dword [set_A+4*ebx]
    cdq
    idiv    ecx
    mov     dword [mid], eax
    jmp     last

; Save the single mid value

odd:
    mov     ecx, dword [set_A+4*eax]
    mov     dword [mid], ecx

last:
    mov rax, SYS_exit           ; call code for exit
    mov rdi, EXIT_SUCCESS       ; exit with success
    syscall

