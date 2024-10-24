; Create a simple main program that will test the myGetLine() function
; by opening a file, calling the myGetLine() function, and displaying
; the lines to the console.  Test the program with a series of different
; size files including ones smaller, larger, and much larger than the selected
; buffer size. Capture the program output and compare the captured output
; to the original file to ensure your program is correct.

section     .data

LF                  equ     10
NULL                equ     0 
TRUE                equ     1
FALSE               equ     0

STDIN               equ     0
STDOUT              equ     1
STDERR              equ     2

SYS_read            equ     0
SYS_write           equ     1
SYS_open            equ     2
SYS_close           equ     3
SYS_exit            equ     60

EXIT_SUCCESS        equ     0
EXIT_FAILURE        equ     1

O_RDONLY            equ     000000q

argCountError           db      "Incorrect number of arguments given", LF, NULL
argCountErrorLength     dq      37

fileOpenError           db      "Failed to open file", LF, NULL
fileOpenErrorLength     dq      21

LINE_BUFFER_SIZE    equ     1024


section     .bss

lineBuffer      resb        LINE_BUFFER_SIZE


section     .text

extern myGetLine

global _start
_start:
    mov     r12, qword [rsp]                ; argc
    lea     r13, qword [rsp+8]              ; argv

    cmp     r12, 2
    jne     argumentError

    mov     rax, SYS_open
    mov     rdi, qword [r13+8]
    mov     rsi, O_RDONLY
    syscall                                 ; Open file

    cmp     rax, 0
    jl      openError

    mov     r14, rax

getLineLoop:
    mov     rdi, r14
    mov     rsi, lineBuffer
    mov     rdx, LINE_BUFFER_SIZE
    call    myGetLine                       ; Get next line from file

    cmp     rax, FALSE
    je      closeFile

    mov     rcx, 1
getLengthLoop:                              ; Get line length
    cmp     byte [lineBuffer+rcx-1], LF
    je      printLine
    inc     rcx
    jmp     getLengthLoop
    
printLine:
    mov     rax, SYS_write
    mov     rdi, STDOUT
    mov     rsi, lineBuffer
    mov     rdx, rcx
    syscall                                 ; Print line

    jmp     getLineLoop

closeFile:
    mov     rax, SYS_close
    mov     rdi, r14
    syscall                                 ; Close file

    jmp     exitSuccess

argumentError:
    mov     rax, SYS_write
    mov     rdi, STDERR
    mov     rsi, argCountError
    mov     rdx, qword [argCountErrorLength]
    syscall

    jmp     exitFailure

openError:
    mov     rax, SYS_write
    mov     rdi, STDERR
    mov     rsi, fileOpenError
    mov     rdx, qword [fileOpenErrorLength]
    syscall
    
exitFailure:
    mov     rdi, EXIT_FAILURE
    jmp     programExit

exitSuccess:
    mov     rdi, EXIT_SUCCESS

programExit:
    mov     rax, SYS_exit
    syscall
    
