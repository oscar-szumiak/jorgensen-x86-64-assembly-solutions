; Update the previous program to convert strings into integers to include
; error checking on the input string.
; Specifically, the sign must be valid and be the first character
; in the string, each digit must be between “0” and “9”, and the string
; NULL terminated.
; For example, the string “-321” is valid while “1+32” and “+1R3” are both
; invalid.
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.

section .data

; -----
; Constants

NULL                equ     0
EXIT_SUCCESS        equ     0           ; successful operation
EXIT_FAILURE        equ     1           ; failed operation
SYS_exit            equ     60          ; code for terminate

; -----
; Data

strNum          db      "+41275"
strLen          dd      7

section .bss

intNum          resd    1

; *********************************************************

section .text
global _start
_start:

    mov     ecx, dword [strLen]             ; Initialize string index
    dec     ecx
    mov     rdi, strNum                     ; Get address of string

    mov     eax, 0                          ; Check sign
    mov     al, byte [rdi]
    cmp     al, "-"
    je      checkDigitsLoop
    cmp     al, "+"
    jne     exitFailure

checkDigitsLoop:                            ; Check digits
    mov     eax, 0
    mov     al, byte [rdi+rcx-1]
    cmp     al, "0"
    jl      exitFailure
    cmp     al, "9"
    jg      exitFailure
    dec     ecx
    cmp     ecx, 1
    jne     checkDigitsLoop

    mov     ecx, dword [strLen]
    dec     ecx
    mov     r8d, 10
    mov     esi, 0                          ; Power of char value
    mov     dword [intNum], 0               ; Initialize result to 0

convertionLoop:
    mov     eax, 0
    mov     al, byte [rdi+rcx-1]            ; Get next char
    cmp     al, "-"
    je      breakNegative
    cmp     al, "+"
    je      last
    sub     al, "0"
    mov     r9d, esi                        ; Copy value of power
    cmp     r9d, 0
    je      zeroPower

powerLoop:                                  ; Calculate value of char
    imul    eax, r8d
    dec     r9d
    cmp     r9d, 0
    jne     powerLoop

zeroPower:
    add     dword [intNum], eax             ; Add value to variable
    inc     esi
    loop    convertionLoop
    jmp     last

breakNegative:
    mov     eax, dword [intNum]
    imul    eax, -1
    mov     dword [intNum], eax

exitSuccess:
    mov     rdi, EXIT_SUCCESS               ; exit with success
    jmp     last

exitFailure:
    mov     rdi, EXIT_FAILURE               ; exit with failure

last:
    mov rax, SYS_exit                       ; call code for exit
    syscall

