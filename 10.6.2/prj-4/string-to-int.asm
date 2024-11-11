; Update the previous program to address strings with a preceding sign
; (“+” or “-”). This will require including a sign, “+” or “-” in the string.
; You must ensure the final string is NULL terminated. You may assume
; the input strings are valid. Use the debugger to execute the program
; and display the final results. Create a debugger input file to show
; the results.

section .data

; -----
; Constants

NULL                equ     0
EXIT_SUCCESS        equ     0           ; successful operation
SYS_exit            equ     60          ; code for terminate

; -----
; Data

strNum          db      "-41275"
strLen          dd      7

section .bss

intNum          resd    1

; *********************************************************

section .text
global _start
_start:

    mov     ecx, dword [strLen]             ; Initialize string index
    dec     ecx
    mov     r8d, 10
    mov     rdi, strNum                     ; Get address of string
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

last:
    mov rax, SYS_exit                       ; call code for exit
    mov rdi, EXIT_SUCCESS                   ; exit with success
    syscall

