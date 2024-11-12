;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2024 Oscar Szumiak
;

; Create a function to convert an ASCII string representing a number into
; an integer. The function should read the string and perform appropriate error
; checking. If there is an error, the function should return FALSE
; (a defined constant set to 0). If the string is valid, the function should
; convert the string into an integer. If the conversion is successful,
; the function should return TRUE (a defined constant set to 1). Develop
; a main program to call the function on a series of different integers.
; The main should include the appropriate data declarations and applicable
; the constants. Use the debugger to execute the program and display
; the final results. Create a debugger input file to show the results.

section .data

; -----
; Constants

NULL                equ     0
FALSE               equ     0
TRUE                equ     1
EXIT_SUCCESS        equ     0           ; successful operation
EXIT_FAILURE        equ     1           ; failed operation
SYS_exit            equ     60          ; code for terminate

; -----
; Data

strNum1         db      "+41275"
strLen1         dd      7
exit1           dq      0
strNum2         db      "-3421"
strLen2         dd      6
exit2           dq      0
strNum3         db      "56"
strLen3         dd      3
exit3           dq      0

section .bss

intNum1         resd    1
intNum2         resd    1
intNum3         resd    1

; *********************************************************

section .text

; Convert a signed integer to an ASCII string
;
; asciiToInt(string, strlen, number)
;
; Arguments:
;   string, address - rdi
;   strlen, dword value - esi
;   number, address - rdx

global asciiToInt
asciiToInt:

    push    rbp                             ; Prologue
    mov     rbp, rsp
    push    r12
    
    mov     r10, rdx                        ; Get integer address
    mov     r11d, esi                       ; Get string length
    mov     ecx, r11d                       ; Initialize string index
    dec     ecx

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

    mov     ecx, r11d                       ; Initialize string index
    dec     ecx
    mov     r8d, 10
    mov     esi, 0                          ; Power of char value
    mov     r12d, 0                         ; Initialize result to 0

convertionLoop:
    mov     eax, 0
    mov     al, byte [rdi+rcx-1]            ; Get next char
    cmp     al, "-"
    je      breakNegative
    cmp     al, "+"
    je      exitSuccess
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
    add     r12d, eax                       ; Add value to variable
    inc     esi
    loop    convertionLoop
    jmp     exitSuccess

breakNegative:
    imul    r12d, -1

exitSuccess:
    mov     rax, TRUE                       ; Exit with success
    jmp     exitPoint

exitFailure:
    mov     rax, FALSE                      ; Exit with failure

exitPoint:
    mov     dword [r10], r12d               ; Save calculated integer value

    pop     r12                             ; Epilogue
    pop     rbp
    ret

global _start
_start:

; Call function

   mov      rdi, strNum1
   mov      esi, dword [strLen1]
   mov      rdx, intNum1
   call     asciiToInt
   mov      qword [exit1], rax

   mov      rdi, strNum2
   mov      esi, dword [strLen2]
   mov      rdx, intNum2
   call     asciiToInt
   mov      qword [exit2], rax
   
   mov      rdi, strNum3
   mov      esi, dword [strLen3]
   mov      rdx, intNum3
   call     asciiToInt
   mov      qword [exit3], rax

last:
    mov     rdi, EXIT_SUCCESS               ; return 0
    mov     rax, SYS_exit                   ; call code for exit
    syscall

