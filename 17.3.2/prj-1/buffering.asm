;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

; Refine the presented algorithm to address maximum text line check
; and possibility that the file size is an even multiple of the buffer size.
; This includes formalizing the variable names and looping constructs
; (many possible choices).

section     .data

TRUE                equ     1
FALSE               equ     0

LF                  equ     10
NULL                equ     0

SYS_read            equ     0       ; read
SYS_write           equ     1       ; write
SYS_open            equ     2       ; file open
SYS_close           equ     3       ; file close

STDIN               equ     0
STDOUT              equ     1
STDERR              equ     2

; Read and line buffer sizes
READ_BUFFER_SIZE    equ     2048
LINE_BUFFER_SIZE    equ     1024

; Index for current location in the read buffer,
; initially set to READ_BUFFER_SIZE
currentIndex        dq      READ_BUFFER_SIZE

; Current maximum size of read buffer, initially set to READ_BUFFER_SIZE
bufferMaximum       dq      READ_BUFFER_SIZE

; Boolean to mark if the end of file has been found, initially set to false
eofFlag             dq      FALSE

msgReadError        db      "A read error has occured", LF, NULL
msgReadErrorSize    dq      25


section     .bss

readBuffer      resb        READ_BUFFER_SIZE
lineBuffer      resb        LINE_BUFFER_SIZE


section     .text

; myGetLine(int fd, char* lineBuffer, int lineBufferSize)
; Args:
;   rdi - value - file descriptor
;   rsi - address - line buffer array
;   rdx - value - line buffer array size
; Returns:
;   TRUE - on full line
;   FALSE - on read error
;
; Algorithm:
; myGetLine(fileDescriptor, lineBuffer, lineBufferSize) {
;     repeat {
;         if currentIndex >= bufferMaximum
;             read readBuffer (READ_BUFFER_SIZE)
;             if error
;                 handle read error
;                 display error message
;                 exit routine (with false)
;             reset pointers
;             if chars read < characters request read
;                 set eofFlag = TRUE
;             if chars read == 0
;                 exit with false
;         if lineIndex >= lineBufferSize
;             exit with false
;         get one character from buffer at currentIndex
;         place character in lineBuffer
;         increment currentIndex
;         if character is LF
;             exit with true
;     }
; }

global myGetLine
myGetLine:
    push    r12
    push    r13
    push    r14
    push    r15

    mov     r12, rdi                            ; file descriptor
    mov     r13, rsi                            ; lineBuffer
    mov     r14, rdx                            ; lineBufferSize

    mov     r15, 0                              ; lineBuffer index
fillBuffer:
    mov     rax, qword [bufferMaximum]
    cmp     qword [currentIndex], rax
    jb      getChar

    mov     rax, SYS_read
    mov     rdi, r12
    mov     rsi, readBuffer
    mov     rdx, READ_BUFFER_SIZE
    syscall

    cmp     rax, 0
    jge     checkRead
    jmp     readError

checkRead:
    cmp     rax, READ_BUFFER_SIZE
    je      resetPointers
    mov     qword [eofFlag], TRUE
    cmp     rax, 0
    je      zeroReadError
resetPointers:
    mov     qword [currentIndex], 0
    mov     qword [bufferMaximum], rax

getChar:
    cmp     r15, r14
    je      lineBufferError
    mov     r10, qword [currentIndex]
    mov     al, byte [readBuffer+r10]
    mov     byte [r13+r15], al
    inc     r15
    inc     qword [currentIndex]
    cmp     al, LF
    je      getLineSuccess
    jmp     fillBuffer

getLineSuccess:
    mov     rax, TRUE
    jmp     getLineExit

readError:
    mov     rax, SYS_write
    mov     rdi, STDERR
    mov     rsi, msgReadError
    mov     rdx, msgReadErrorSize
    syscall
    
zeroReadError:
lineBufferError:

getLineFailure:
    mov     rax, FALSE

getLineExit:
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    ret

