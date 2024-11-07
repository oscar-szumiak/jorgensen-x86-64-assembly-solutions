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
    mov     r13, qword [idt_data+2]
printLoop:
    mov     rax, r12
    mov     rdi, 16
    mul     rdi
    add     rax, r13
    mov     rdi, rax                        ; lea   rdi, byte [r13+r12*16]

    mov     rsi, 16
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

    inc     r12

    cmp     r12w, word [idt_data]
    jb      printLoop
    
    mov     rdi, EXIT_SUCCESS

last:
    mov     rax, SYS_exit
    syscall

