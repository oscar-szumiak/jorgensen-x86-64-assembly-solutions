section     .data

SYS_exit        equ     60
SYS_write       equ     1

EXIT_SUCCESS    equ     0
EXIT_FAILURE    equ     1

STDOUT          equ     1
STDERR          equ     2

LF              equ     10
NULL            equ     0

testData        dq      0x0123456789ABCDEF

section     .bss

BUFFER_SIZE     equ     40

hexBuffer       resb    BUFFER_SIZE


section     .text

extern intToHex

global _start
_start:
    lea     rdi, byte [testData]
    mov     rsi, 8
    lea     rdx, byte [hexBuffer]
    mov     rcx, BUFFER_SIZE-1
    call    intToHex                        ; Get hex representation of data

    mov     rdi, EXIT_FAILURE
    cmp     rax, 0
    jle     last

    mov     r14, rax
    mov     byte [hexBuffer+r14], LF        ; Add newline

    mov     rax, SYS_write
    mov     rdi, STDERR
    lea     rsi, byte [hexBuffer]
    mov     rdx, r14
    syscall                                 ; Print hex representation of data

last:
    mov     rdi, EXIT_SUCCESS
    mov     rax, SYS_exit
    syscall

