; Convert the example program to read input from keyboard into a readString()
; function. The function should accept arguments for the string address
; and maximum string length (in that order). The maximum length should include
; space for the NULL (an extra byte), which means the function must not allow
; more than the maximum minus one characters to be stored in the string.
; If additional characters are entered by the user, they should be cleared
; from the input stream, but not stored. The function should not include
; the newline in the returned string. The function should return the number
; of characters in the string not including the NULL. The printString()
; function from the previous problem should be used unchanged. When done,
; create an appropriate main to test the function. Use the debugger
; as necessary to debug the program. When working correctly, execute
; the program from the command line which will display the final results
; to the console.

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

STRLEN		    equ		50

prompt          db      "Enter text: ", NULL


section .bss

chr             resb    1
inputLine       resb    STRLEN+2    ; total of 52


section .text

; readLine(inputBuffer, bufferLength)
; Arguments:
;   rdi - address of buffer for input string
;   rsi - length of buffer
; Returns:
;   Nothing

global readLine
readLine:
    push    rbx
    push    r12
 
    mov     rbx, rdi
    mov     r8, rsi
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
    cmp     r12, r8                 ; if # chars ≥ STRLEN
    jae     readCharacters          ;   stop placing in buffer

    mov     byte [rbx], al          ; inLine[i] = chr
    inc     rbx                     ; update tmpStr addr

    jmp     readCharacters

readDone:
    mov     byte [rbx], LF          ; add LF
    inc     rbx
    mov     byte [rbx], NULL        ; add NULL termination

    pop     r12
    pop     rbx
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

; Call readLine function

    mov     rdi, inputLine
    mov     rsi, STRLEN
    call    readLine

; Display read input

    mov     rdi, inputLine
    call    printString

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

