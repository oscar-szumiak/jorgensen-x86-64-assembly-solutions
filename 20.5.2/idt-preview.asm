;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2024 Oscar Szumiak
;

; Write a program to obtain and list the contents of the IDT.
; This will require an integer to ASCII/Hex program in order to display
; the applicable addresses in hex.
; Use the debugger as necessary to debug the program.
; When working, execute the program without the debugger to display results.


section     .data

SYS_exit        equ     60
SYS_write       equ     1

EXIT_SUCCESS    equ     0
EXIT_FAILURE    equ     1

STDOUT          equ     1
STDERR          equ     2

LF              equ     10
NULL            equ     0

limit           db      "Limit: ", NULL
limitSize       dq      7
address         db      "Base address: ", NULL
addressSize     dq      14

section     .bss

BUFFER_SIZE     equ     40

idt_data        resb    10              ; 2 (size) + 8 (start address of IDT)
hexBuffer       resb    BUFFER_SIZE


section     .text

extern intToHex

global _start
_start:
    sidt    byte [idt_data]

    mov     r12, 0
    mov     r13w, word [idt_data]           ; Limit of IDT
    mov     r14, qword [idt_data+2]         ; Base address of IDT

    mov     rax, SYS_write
    mov     rdi, STDERR
    lea     rsi, byte [limit]
    mov     rdx, qword [limitSize]
    syscall                                 ; Print limit message

    lea     rdi, byte [idt_data]
    mov     rsi, 2
    lea     rdx, byte [hexBuffer]
    mov     rcx, BUFFER_SIZE-1
    call    intToHex                        ; Get hex representation of limit

    mov     rdi, EXIT_FAILURE
    cmp     rax, 0
    jle     last

    mov     r15, rax
    mov     byte [hexBuffer+r15], LF        ; Add newline
    inc     r15

    mov     rax, SYS_write
    mov     rdi, STDERR
    lea     rsi, byte [hexBuffer]
    mov     rdx, r15
    syscall                                 ; Print hex representation of limit

    mov     rax, SYS_write
    mov     rdi, STDERR
    lea     rsi, byte [address]
    mov     rdx, qword [addressSize]
    syscall                                 ; Print address message

    lea     rdi, byte [idt_data+2]
    mov     rsi, 8
    lea     rdx, byte [hexBuffer]
    mov     rcx, BUFFER_SIZE-1
    call    intToHex                        ; Get hex representation
                                            ; of base address

    mov     rdi, EXIT_FAILURE
    cmp     rax, 0
    jle     last

    mov     r15, rax
    mov     byte [hexBuffer+r15], LF        ; Add newline
    inc     r15

    mov     rax, SYS_write
    mov     rdi, STDERR
    lea     rsi, byte [hexBuffer]
    mov     rdx, r15
    syscall                                 ; Print hex representation
                                            ; of base address

; Due to incorrect sidt readouts on Ubunut the following code fails to run

; printLoop:
;     mov     rax, r12
;     mov     rdi, 16
;     mul     rdi
;     add     rax, r14
;     mov     rdi, rax                        ; lea   rdi, byte [r14+r12*16]
; 
;     mov     rsi, 16
;     lea     rdx, byte [hexBuffer]
;     mov     rcx, BUFFER_SIZE-1
;     call    intToHex                        ; Get hex representation of data
; 
;     mov     rdi, EXIT_FAILURE
;     cmp     rax, 0
;     jle     last
; 
;     mov     r15, rax
;     mov     byte [hexBuffer+r15], LF        ; Add newline
;     inc     r15
; 
;     mov     rax, SYS_write
;     mov     rdi, STDERR
;     lea     rsi, byte [hexBuffer]
;     mov     rdx, r15
;     syscall                                 ; Print hex representation
;                                             ; of data
; 
;     inc     r12
; 
;     cmp     r12w, r13w
;     jb      printLoop
    
    mov     rdi, EXIT_SUCCESS

last:
    mov     rax, SYS_exit
    syscall

