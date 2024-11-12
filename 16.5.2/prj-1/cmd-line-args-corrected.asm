;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022 Ed Jorgensen
;

; Implement the example program to read and display the command line arguments.
; Use the debugger to execute the program and display the final results.
; Execute the program without the debugger and verify the appropriate output
; is displayed to the console.

; Command Line Arguments Example
; -------------------------------------------------------

section .data

; -----
; Define standard constants.

LF                  equ     10      ; line feed
NULL                equ     0       ; end of string
TRUE                equ     1
FALSE               equ     0
EXIT_SUCCESS        equ     0       ; success code
STDIN               equ     0       ; standard input
STDOUT              equ     1       ; standard output
STDERR              equ     2       ; standard error

SYS_read            equ     0       ; read
SYS_write           equ     1       ; write
SYS_open            equ     2       ; file open
SYS_close           equ     3       ; file close
SYS_fork            equ     57      ; fork
SYS_exit            equ     60      ; terminate
SYS_creat           equ     85      ; file open/create
SYS_time            equ     201     ; get time

; -----
; Variables for main.

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

    mov     r12, qword [rsp]        ; save for later use...
    mov     r13, rsp
    add     r13, 8

; -----
; Simple loop to display each argument to the screen.
; Each argument is a NULL terminated string, so can just
; print directly.

printArguments:

    mov     rbx, 0
printLoop:
    mov     rdi, qword [r13+rbx*8]
    call    printString

    mov     rdi, newLine
    call    printString

    inc     rbx
    cmp     rbx, r12
    jl      printLoop

; -----
; Example program done.

exampleDone:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

; **********************************************************
; Generic procedure to display a string to the screen.
; String must be NULL terminated.
; Algorithm:
;   Count characters in string (excluding NULL)
;   Use syscall to output characters
; Arguments:
;   rsi - address, string
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

