;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

; Based on the file write example, create a value returning fileWrite()
; function to write a password to a file. The function should accept arguments
; for the address of the file name and the address of the NULL terminated
; password string. The file should be created, opened, the password string
; written to the file, and the file closed. The function should return SUCCESS
; if the operations worked correctly or NOSUCCESS if there is a problem.
; Problems might include not being able to create the file or not being able
; to write to the file. Create an appropriate main to test the function.
; Use the debugger as necessary to debug the program.
; When working correctly, execute the program from the command line which
; will display the final results to the console.

section     .data

; Constants

LF              equ     10          ; line feed
NULL            equ     0           ; end of string

SUCCESS         equ     0
NOSUCCESS       equ     1

SYS_write		equ		1		    ; write
SYS_open		equ		2			; file open
SYS_close		equ		3		    ; file close
SYS_fork		equ		57		    ; fork
SYS_exit		equ		60		    ; terminate
SYS_creat		equ		85          ; file open/create
SYS_time		equ		201         ; get time

O_CREAT		    equ		0x40
O_TRUNC		    equ		0x200
O_APPEND		equ		0x400

O_RDONLY		equ		000000q     ; read only
O_WRONLY		equ		000001q     ; write only
O_RDWR	    	equ		000002q     ; read and write

S_IRUSR			equ		00400q
S_IWUSR			equ		00200q
S_IXUSR			equ		00100q

STDIN           equ     0           ; standard input
STDOUT          equ     1           ; standard output
STDERR          equ     2           ; standard error

EXIT_SUCCESS    equ     0           ; success code

; Data.

password        db      "Hello World!", LF, NULL
fileName        db      "password", NULL


section     .text

; fileWrite(string, file)
; Arguments:
; 1) address, password string
; 2) address, file name
; Returns:
; SUCCESS - if succesful
; NOSUCCESS - if not able to create or write to file

global fileWrite
fileWrite:
    mov     r8, rdi             ; Save password string address
    mov     r9, rsi             ; Save file name string address

    mov     rax, SYS_creat
    mov     rdi, r9
    mov     rsi, S_IRUSR | S_IWUSR
    syscall

    cmp     rax, 0
    jl      errorOnOpen

    mov     r10, rax            ; Save file descriptor

; Count characters in password string

    mov     rbx, r8
    mov     rdx, 0
strCountLoop:
    cmp     byte [rbx], NULL
    je      strCountDone
    inc     rdx
    inc     rbx
    jmp     strCountLoop

strCountDone:    
    cmp     rdx, 0
    je      zeroLengthString

    mov     rax, SYS_write
    mov     rdi, r10
    mov     rsi, r8
    syscall

    cmp     rax, 0
    jl      errorOnWrite

    mov     rax, SYS_close
    mov     rdi, r10
    syscall
    
    mov     rax, SUCCESS
    jmp     writeSuccess

errorOnOpen:
zeroLengthString:
errorOnWrite:
    mov     rax, NOSUCCESS

writeSuccess:
    ret

global _start
_start:

; Call function fileWrite

    mov     rdi, password
    mov     rsi, fileName
    call    fileWrite

; -----
; Done, terminate program.

last:
    mov     rdi, rax
    mov     rax, SYS_exit
    syscall

