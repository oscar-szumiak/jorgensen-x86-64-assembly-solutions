; Convert the integer to ASCII macro from the previous chapter into a void
; function. The function should convert a signed integer into a right-justified
; string of a given length. This will require including any leading blanks,
; a sign (“+” or “-”), the digits, and the NULL.
; The function should accept the value for the integer and the address of where
; to place the NULL terminated string, and the value of the maximum string
; length - in that order.
; Develop a main program to call the function on a series of different integers.
; The main should include the appropriate data declarations.
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.

section .data

; -----
; Define constants

NULL                equ     0
EXIT_SUCCESS        equ     0           ; successful operation
SYS_exit            equ     60          ; code for terminate

; -----
; Define Data.

intNum1          dd      -1786
intNum2          dd      348
intNum3          dd      86

section .bss

strNum1          resb    10
strNum2          resb    10
strNum3          resb    10

; *********************************************************

section .text

; Convert a signed integer to an ASCII string
; intToAscii(number, string, maxlen)
; Arguments:
; number, dword value – edi
; string, address – rsi
; maxlen, qword value – edx

global intToAscii
intToAscii:

    push    rbp                             ; prologue
    mov     rbp, rsp
; -----
; Part A - Successive division

    mov     eax, edi                        ; get integer
    mov     r8, rsi                         ; get addr of string
    mov     r9, rdx                         ; get maxlen

    mov     rdi, 0                          ; idx = 0
    mov     byte [r8+rdi], "+"
    
    cmp     eax, 0
    jg      positive
    
    imul    eax, -1
    mov     byte [r8+rdi], "-"

positive:
    inc     rdi
    mov     rcx, 0                          ; digitCount = 0
    mov     ebx, 10                         ; set for dividing by 10
divideLoop:
    cdq
    idiv    ebx                             ; divide number by 10

    push    rdx                             ; push remainder
    inc     rcx                             ; increment digitCount

    cmp     eax, 0                          ; if (result != 0)
    jne     divideLoop                      ; goto divideLoop

; -----
; Part B - Convert remainders and store

popLoop:
    pop     rax                             ; pop intDigit
    add     al, "0"                         ; char = int + "0"
    mov     byte [r8+rdi], al               ; string[idx] = char
    inc     rdi                             ; increment idx
    loop    popLoop                         ; if (digitCount > 0)
                                            ; goto popLoop
    mov     byte [r8+rdi], NULL             ; string[idx] = NULL

; -----
; Part C - Right justify the result

    inc     rdi
justifyLoop:
    mov     al, byte [r8+rdi-1]
    mov     byte [r8+r9-1], al
    dec     rdi
    dec     r9
    cmp     rdi, 0
    jne     justifyLoop

clearLoop:
    mov     byte [r8+r9-1], " "
    dec     r9
    cmp     r9, 0
    jne     clearLoop

    pop     rbp                             ; epilogue
    ret

global _start
_start:

; Function calls

    mov     edi, dword [intNum1]
    lea     rsi, [strNum1]
    mov     rdx, 10
    call    intToAscii

    mov     edi, dword [intNum2]
    lea     rsi, [strNum2]
    mov     rdx, 10
    call    intToAscii
    
    mov     edi, dword [intNum3]
    lea     rsi, [strNum3]
    mov     rdx, 10
    call    intToAscii

; -----
; Done, terminate program

last:
    mov rax, SYS_exit                       ; call code for exit
    mov rdi, EXIT_SUCCESS                   ; exit with success
    syscall

