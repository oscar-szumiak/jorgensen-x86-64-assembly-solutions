;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2024 Oscar Szumiak
;

; Update the previous program to test if a phrase is a palindrome.
; The general approach using the stack is the same, however,
; spaces and punctuation must be skipped.
; For example, "A man, a plan, a canal - Panama!" is a palindrome.
; The program must ignore the comma, dash, and exclamation point.
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.

section .data

; -----
; Constants

EXIT_SUCCESS    equ     0       ; successful operation
SYS_exit        equ     60      ; call code for terminate

; -----
; Data

isPalindrome    db      0       ; True

string          db      "A man, a plan, a canal - Panama!"
len             dd      32

; ****************************************************

section .text

global _start
_start:

; Loop to put characters on stack

    mov     ecx, dword [len]
    mov     rbx, string
    mov     r12, 0
pushLoop:
    mov     rax, 0
    mov     al, byte [rbx+r12]
    push    rax
    inc     r12
    loop    pushLoop

; Check if sentence is palindrome

    mov     ecx, dword [len]
    mov     rbx, string
    mov     r12, 0
    mov     rax, 0
popLoop:
    pop     rax
    mov     dl, byte [rbx+r12]
    
; Check if comparison is valid
; Both character values in the ranges 65-90 or 97-122

; Check source string character (dl)
    cmp     dl, 97
    jb      isSrcUpper                  ; dl < 97
    cmp     dl, 122
    jbe     srcLower                    ; dl >= 97 && dl <= 122
    jmp     srcNotValid                 ; dl > 122
isSrcUpper:
    cmp     dl, 90
    ja      srcNotValid                 ; dl < 97 && dl > 90
    cmp     dl, 65
    jae     srcUpper                    ; dl <= 90 && dl >= 65
    jmp     srcNotValid                 ; dl < 65
srcNotValid:
    push    rax                         ; Retain stack value
    jmp     continueLoop
srcLower:
    sub     dl, 32                      ; ASCII toUpper
srcUpper:

; Check stack string character (al)
    cmp     al, 97
    jb      isStackUpper                ; al < 97
    cmp     al, 122
    jbe     stackLower                  ; al >= 97 && al <= 122
    jmp     stackNotValid               ; al > 122
isStackUpper:
    cmp     al, 90
    ja      stackNotValid               ; al < 97 && al > 90
    cmp     al, 65
    jae     stackUpper                  ; al <= 90 && al >= 65
    jmp     stackNotValid               ; al < 65
stackLower:
    sub     al, 32                      ; ASCII toUpper
stackUpper:

    cmp     dl, al
    je      continueLoop
    mov     byte [isPalindrome], 1      ; False
    jmp     last

continueLoop:
    inc     r12
stackNotValid:                          ; Retain source string index value
    loop    popLoop

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit               ; call code for exit
    mov     rdi, EXIT_SUCCESS           ; exit with success
    syscall

