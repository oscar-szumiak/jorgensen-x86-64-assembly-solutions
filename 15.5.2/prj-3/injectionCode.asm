global _start
_start:
    xor     rax, rax
    push    rax
    mov     rbx, 0x68732f6e69622f2f
    push    rbx
    mov     al, 59
    mov     rdi, rsp
    syscall

