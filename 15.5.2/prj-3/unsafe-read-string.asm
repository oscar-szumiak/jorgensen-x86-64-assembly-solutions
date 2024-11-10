; Using the program from the previous question and the program fragment
; to open a shell, attempt to inject the code into the running program.
; In order to save time, print the value of the rsp at an appropriate
; location to allow the guessing of the target address significantly easier.

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

STRLEN		    equ     40

prompt          db      "Enter text: ", NULL
hexString       db      "0123456789ABCDEF", NULL


section .bss

chr             resb    1
inputLine       resb    STRLEN
rsp_value       resb    20


section .text

; Convert a integer to a hexadecimal ASCII string
; intToHex(number, string)
; Arguments:
;   rdi - number, dword value
;   rsi - string, address

global intToHex
intToHex:
    push    rbp
    mov     rbp, rsp

    mov     rcx, 8
    mov     rax, 0
hexLoop:
    mov     al, dil
    and     rax, 0x000000000000000F         ; alternative: shl al, 4
                                            ;              shr al, 4
    mov     r10b, byte [hexString+rax]
    push    r10
    
    mov     al, dil
    shr     al, 4
    mov     r10b, byte [hexString+rax]
    push    r10

    ror     rdi, 8
    loop    hexLoop

    mov     rcx, 16
popLoop:
    pop     r10
    mov     byte [rsi], r10b
    inc     rsi
    loop    popLoop

    mov     byte [rsi], LF
    inc     rsi
    mov     byte [rsi], NULL

    pop     rbp
    ret

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
    sub     rsp, STRLEN             ; allocate stack buffer of size STRLEN

    mov     r13, rdi
    mov     r14, rsi

    mov     rdi, rsp
    lea     rsi, byte [rsp_value]
    call    intToHex

    lea     rdi, byte [rsp_value]   ; print hex representation of rsp
    call    printString

    push    rbx
    push    r12
    push    r13
    push    r14
 
    mov     rdi, prompt             ; print prompt
    call    printString

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
    mov     rdi, STDERR
    syscall

prtDone:
    pop     rbx
    ret

global _start
_start:

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

