;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

section .data

; Constants

LF              equ     10          ; line feed
NULL            equ     0           ; end of string
SYS_write       equ     1           ; write

STDIN           equ     0           ; standard input
STDOUT          equ     1           ; standard output
STDERR          equ     2           ; standard error

section .text

; printString(string)
; Arguments:
;   string, address
; Returns:
;   void

global printString
printString:
    push    rbx

    mov     rbx, rdi
    mov     rdx, 0
strCountLoop:
    cmp     byte [rbx], NULL
    je      strCountDone
    inc     rdx
    inc     rbx
    jmp     strCountLoop
strCountDone:
    
    cmp     rdx, 0
    je      prtDone

    mov     rax, SYS_write
    mov     rsi, rdi
    mov     rdi, STDOUT 

    syscall

prtDone:
    pop     rbx
    ret

; intToString(number, string)
; Arguments:
;   number, dword value
;   string, address
; Returns:
;   void
global intToString
intToString:
    push    rbp
    mov     rbp, rsp
    push    r12

    mov     eax, edi
    mov     rbp, rsi
    
    mov     rdi, 0
    mov     byte [rbp+rdi], "+"
    
    cmp     eax, 0
    jg      positive
    
    imul    eax, -1
    mov     byte [rbp+rdi], "-"

positive:
    add     rdi, 1
    mov     rcx, 0
    mov     ebx, 10

divideLoop:
    cdq
    idiv    ebx

    push    rdx
    inc     rcx

    cmp     eax, 0
    jne     divideLoop

popLoop:
    pop     rax
    add     al, "0"
    mov     byte [rbp+rdi], al
    inc     rdi
    loop    popLoop

    mov     byte [rbp+rdi], LF
    inc     rdi
    mov     byte [rbp+rdi], NULL

    pop    r12
    pop    rbp
    ret

