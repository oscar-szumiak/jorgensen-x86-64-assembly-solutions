;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022 Ed Jorgensen
;

; Implement the second example program fragment to open a new shell.
; Use the debugger to execute the program and display the final results.
; Execute the program without the debugger and verify that a new shell
; is opened.

section .text

global _start
_start:
    xor     rax, rax                    ; clear rax
    push    rax                         ; place NULLs on stack
    mov     rbx, 0x68732f6e69622f2f     ; string -> "//bin/sh"
    push    rbx                         ; put string in memory
    mov     al, 59                      ; call code in rax
    mov     rdi, rsp                    ; rdi = addr of string
    syscall                             ; system call

