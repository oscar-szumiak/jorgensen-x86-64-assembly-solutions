; Implement the second example program fragment to open a new shell.
; Use the debugger to execute the program and display the final results.
; Execute the program without the debugger and verify that a new shell
; is opened.

section .text

global _start
_start:
    xor rax, rax                    ; clear rax
    push rax                        ; place NULLs on stack
    mov rbx, 0x68732f6e69622f2f     ; string -> "//bin/sh"
    push rbx                        ; put string in memory
    mov al, 59                      ; call code in rax
    mov rdi, rsp                    ; rdi = addr of string
    syscall                         ; system call

