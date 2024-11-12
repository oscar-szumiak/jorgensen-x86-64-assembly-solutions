;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

; Extend the previous exercise to display the sum and average to the console.
; The printString() example function (from multiple previous examples) should
; be placed in a third source file (which can be used on other exercises).
; This project will require a function to convert an integer to ASCII
; (as outlined in Chapter 10).  Use the debugger as needed to debug
; the program. When working, execute the program without the debugger
; and verify that the correct results are displayed to the console.

section .data

LF          equ     10
NULL        equ     0

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

BUFFER_SIZE     equ     15

msg1        db      "List 1 sum and avg:", LF, NULL
msg2        db      "List 2 sum and avg:", LF, NULL

extern lstSum
extern lstAverage
extern intToString
extern printString

section .bss

sum1Ascii		resb		BUFFER_SIZE
avg1Ascii		resb		BUFFER_SIZE
sum2Ascii		resb		BUFFER_SIZE
avg2Ascii		resb		BUFFER_SIZE

section .text

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

; Get strings of sum1, avg1, sum2, avg2

    mov     edi, dword [sum1]
    mov     rsi, sum1Ascii
    call    intToString

    mov     edi, dword [avg1]
    mov     rsi, avg1Ascii
    call    intToString

    mov     edi, dword [sum2]
    mov     rsi, sum2Ascii
    call    intToString
    
    mov     edi, dword [avg2]
    mov     rsi, avg2Ascii
    call    intToString

; Print results

    mov     rdi, msg1
    call    printString

    mov     rdi, sum1Ascii
    call    printString

    mov     rdi, avg1Ascii
    call    printString
    
    mov     rdi, msg2
    call    printString
    
    mov     rdi, sum2Ascii
    call    printString
    
    mov     rdi, avg2Ascii
    call    printString

; Done, terminate program.

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

