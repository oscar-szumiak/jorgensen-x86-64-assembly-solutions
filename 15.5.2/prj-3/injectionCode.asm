;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

global _start
_start:
    xor     rax, rax
    push    rax
    mov     rbx, 0x68732f6e69622f2f
    push    rbx
    mov     al, 59
    mov     rdi, rsp
    xor     rsi, rsi
    xor     rdx, rdx
    syscall

