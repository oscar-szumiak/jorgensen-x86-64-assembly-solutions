;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

; Implement the console input program from Chapter 13. Remove the code
; for the buffer size check. Execute the program without the debugger
; and ensure the appropriate input is read and that the output is displayed
; to the console. Verify that entering too many characters will crash
; the program.

section .data

LF		        equ		10          ; line feed
NULL		    equ		0           ; end of string

TRUE		    equ		1
FALSE		    equ		0

SYS_read		equ		0           ; read
SYS_write		equ		1           ; write

STDIN	        equ		0           ; standard input
STDOUT	        equ		1           ; standard output
STDERR	        equ		2           ; standard error

EXIT_SUCCESS	equ		0           ; success code
SYS_exit		equ		60          ; exit

STRLEN		    equ		16

prompt          db      "Enter text: ", NULL


section .bss

chr             resb    1
inputLine       resb    STRLEN+2    ; total of 52


section .text

; unsafeReadLine(inputBuffer, bufferLength)
; Arguments:
;   rdi - address of buffer for input string
;   rsi - length of buffer
; Returns:
;   Nothing

global unsafeReadLine
unsafeReadLine:
    push    rbp
    mov     rbp, rsp
    sub     rsp, STRLEN             ; allocated stack buffer of size STRLEN

    push    rbx
    push    r12
    push    r13
    push    r14
 
    mov     r13, rdi
    mov     r14, rsi

    mov     rbx, rbp
    sub     rbx, STRLEN
    mov     r12, 0

readCharacters:
    mov     rax, SYS_read           ; system code for read
    mov     rdi, STDIN              ; standard in
    lea     rsi, byte [chr]         ; address of chr
    mov     rdx, 1                  ; count (how many to read)
    syscall                         ; do syscall
 
    mov     al, byte [chr]          ; get character just read
    cmp     al, LF                  ; if linefeed, input done
    je      readDone
 
    inc     r12                     ; count++

    mov     byte [rbx], al          ; inLine[i] = chr
    inc     rbx                     ; update tmpStr addr

    jmp     readCharacters

readDone:
    mov     byte [rbx], LF          ; add LF
    inc     rbx
    mov     byte [rbx], NULL        ; add NULL termination

    mov     rbx, rbp
    sub     rbx, STRLEN
    mov     r12, r13
stringCopyLoop:                     ; Copy string from buffer to output
    mov     al, byte [rbx]
    mov     byte [r12], al
    inc     rbx
    inc     r12
    cmp     al, NULL
    jne     stringCopyLoop

    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    add     rsp, STRLEN
    pop     rbp
    ret

; printString(string)
; Arguments:
;   rdi - address of string
; Returns:
;   Nothing
global printString
printString:
    push    rbx

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

    mov     rax, SYS_write
    mov     rsi, rdi
    mov     rdi, STDOUT
    syscall

prtDone:
    pop     rbx
    ret

global _start
_start:

; Display prompt

    mov     rdi, prompt
    call    printString

; Call unsafeReadLine function

    mov     rdi, inputLine
    mov     rsi, STRLEN
    call    unsafeReadLine

; Display read input

    mov     rdi, inputLine
    call    printString

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

