;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2024 Oscar Szumiak
;

section .data

hexValues       db      "0123456789ABCDEF"


section .text

; Convert a given number of bytes to ascii hex representation in a buffer
;
; intToHex(int* data, int nrBytes, char* hexBuffer, int bufferSize)
;
; Arguments:
;   rdi - base address of data
;   rsi - size of data in bytes
;   rdx - address of hexBuffer
;   rcx - size of hexBuffer in bytes
;
; Returns:
;   On success:
;       Size of hex string
;   On failure:
;       -1 - size of data is equal to zero
;       -2 - hexBuffer size is too small

global intToHex
intToHex:
    push    r12
    push    r13
    push    r14
    push    r15
    push    rbp
    mov     rbp, rsp
   
    mov     r12, rdi                ; Save arguments
    mov     r13, rsi
    mov     r14, rdx
    mov     r15, rcx

    cmp     rsi, 0                  ; Check if size of data is zero 
    jne     checkBuffer
    
    mov     rax, -1
    ret

checkBuffer:
    mov     rax, rsi
    mov     r8, 2
    mul     r8                      ; Calculate number of ascii hex bytes
    mov     r11, rax
    cmp     rcx, rax                ; and check against hexBuffer size
    jae     convert

    mov     rax, -2
    ret

convert:
    mov     rcx, 0                  ; Index of input data
    mov     rax, 0                  ; Temporary input byte variable
    mov     r10, 0                  ; Temporary output byte variable
hexLoop:
    mov     al, byte [r12+rcx]
    and     rax, 0x000000000000000F         ; Get lower 4 bits
    mov     r10b, byte [hexValues+rax]
    push    r10

    mov     al, byte [r12+rcx]
    shr     al, 4                           ; Get upper 4 bits
    mov     r10b, byte [hexValues+rax]
    push    r10
    
    inc     rcx

    cmp     rcx, r13
    jb      hexLoop

    mov     rsi, 0
    mov     rcx, r11
popLoop:
    pop     r10
    mov     byte [r14+rsi], r10b
    inc     rsi
    loop    popLoop

    mov     rax, r11

    pop     rbp
    pop     r15
    pop     r14
    pop     r13
    pop     r12

    ret

