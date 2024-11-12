;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

; Convert the command line example into a function that will display each
; of the command line arguments to the console. Use the debugger as necessary
; to debug the program. Execute the program without the debugger and verify
; the appropriate output is displayed to the console.

section .data

LF                  equ     10
NULL                equ     0 
EXIT_SUCCESS        equ     0       ; success code

STDIN               equ     0       ; standard input
STDOUT              equ     1       ; standard output
STDERR              equ     2       ; standard error

SYS_write           equ     1       ; write
SYS_exit            equ     60      ; terminate

newLine             db      LF, NULL

; ------------------------------------------------------

section .text

global _start
_start:

; -----
; Get command line arguments and echo to screen.
; Based on the System V AMD64 ABI
; [rsp] = argc (argument count)
; [rsp+8] = argv (starting address of argument vector)

    mov     rdi, qword [rsp]
    mov     rsi, rsp
    add     rsi, 8
    call    printArgs

exampleDone:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall


; Print all command line arguments
; Arguments:
;   rdi, qword value - argc
;   rsi, address - argv

global printArgs
printArgs:
    push    rbx
    push    r12
    push    r13

    mov     r12, rdi 
    mov     r13, rsi 
    mov     rbx, 0
printLoop:
    mov     rdi, qword [r13+rbx*8]
    call    printString

    mov     rdi, newLine
    call    printString

    inc     rbx
    cmp     rbx, r12
    jl      printLoop

    pop     r13
    pop     r12
    pop     rbx
    ret


; **********************************************************
; Generic procedure to display a string to the screen.
; String must be NULL terminated.
; Algorithm:
;   Count characters in string (excluding NULL)
;   Use syscall to output characters
; Arguments:
;   rdi - address, string
; Returns:
;   nothing

global printString
printString:
    push    rbp
    mov     rbp, rsp
    push    rbx

; -----
; Count characters in string.

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

; -----
; Call OS to output string.

    mov     rax, SYS_write          ; code for write()
    mov     rsi, rdi                ; addr of characters
    mov     edi, STDOUT             ; file descriptor
                                    ; count set above
    syscall                         ; system call

; -----
; String printed, return to calling routine.

prtDone:
    pop     rbx
    pop     rbp
    ret

; *******************************************************

