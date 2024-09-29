; Implement the printString() example void function and a simple main
; to test of a series of strings. Use the debugger to execute the program
; and display the final results. Execute the program without the debugger
; and verify the appropriate output is displayed to the console.

section     .data

; Constants

LF              equ     10          ; line feed
NULL            equ     0           ; end of string

TRUE			equ		1
FALSE			equ		0

SYS_read        equ     0           ; read
SYS_write       equ     1           ; write

STDIN           equ     0           ; standard input
STDOUT          equ     1           ; standard output
STDERR          equ     2           ; standard error

EXIT_SUCCESS    equ     0           ; success code
SYS_exit        equ     60          ; code for terminate

STRLEN          equ     50

; Data.

helloWorld      db      "Hello World!", LF, NULL
prompt          db      "Enter text: ", LF, NULL
errorMessage    db      "An error has occured", LF, NULL


section     .text

; **********************************************************
; Generic procedure to display a string to the screen.
; String must be NULL terminated.
; Algorithm:
;  Count characters in string (excluding NULL)
;  Use syscall to output characters

; Arguments:
; 1) address, string
; Returns:
; nothing

global printString
printString:
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

    mov     rax, SYS_write              ; code for write()
    mov     rsi, rdi                    ; addr of characters
    mov     rdi, STDOUT                 ; file descriptor
                                        ; count set above
    syscall                             ; system call

; -----
; String printed, return to calling routine.

prtDone:
    pop     rbx
    ret

; **********************************************************

global _start
_start:

; -----
; Display prompt.

; Call function printString for prompt

    mov     rdi, helloWorld
    call    printString

; Call function printString for prompt

    mov     rdi, prompt
    call    printString

; Call function printString for prompt

    mov     rdi, errorMessage
    call    printString

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

