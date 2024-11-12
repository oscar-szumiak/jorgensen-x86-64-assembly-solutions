;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

; Based on the example function stats(), split it into two value returning
; functions, lstSum() and lstAverage(). As noted in Chapter 12, Functions,
; value returning functions return their result in the A register.
; Since these are double-words, the result will be returned in eax.
; Ensure that the main and both functions are in two different source files.
; The two functions can be in the same source file. Use the debugger
; to execute the program and display the final results.

section     .data

EXIT_SUCCESS    equ 0
SYS_exit        equ 60 

list1       dd      4, 5, 2, -3, 1
len1        dd      5
sum1        dd      0
avg1        dd      0

list2       dd      2, 6, 3, -2, 1, 8, 19
len2        dd      7
sum2        dd      0
avg2        dd      0

; **************************************************

extern lstSum
extern lstAverage

section     .text

global _start
_start:

; Call functions lstSum and lstAverage for list1

    mov     rdi, list1
    mov     esi, dword [len1]
    call    lstSum

    mov     dword [sum1], eax

    mov     edi, eax
    mov     esi, dword [len1]
    call    lstAverage

    mov     dword [avg1], eax

; Call functions lstSum and lstAverage for list2

    mov     rdi, list2
    mov     esi, dword [len2]
    call    lstSum

    mov     dword [sum2], eax

    mov     edi, eax
    mov     esi, dword [len2]
    call    lstAverage

    mov     dword [avg2], eax

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

