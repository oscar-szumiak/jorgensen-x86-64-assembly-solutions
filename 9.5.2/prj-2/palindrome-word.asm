;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2024 Oscar Szumiak
;

; Create a program to determine if a NULL terminated string representing
; a word is a palindrome.
; A palindrome is a word that reads the same forward or backwards.
; For example, “anna”, “civic”, “hannah”, “kayak”, and “madam” are palindromes.
; This can be accomplished by pushing the characters on the stack one at a time
; and then comparing the stack items to the string starting from the beginning.
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

string          db      "Hello"
len             dd      5

; string          db      "anna"
; len             dd      4

; string          db      "hannah"
; len             dd      6

; string          db      "kayak"
; len             dd      5

; string          db      "madam"
; len             dd      5

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

; Check if word is palindrome

    mov     ecx, dword [len]
    mov     rbx, string
    mov     r12, 0
    mov     rax, 0
popLoop:
    pop     rax
    mov     dl, byte [rbx+r12]
    inc     r12
    cmp     dl, al
    je      continueLoop
    mov     byte [isPalindrome], 1      ; False
continueLoop:
    loop    popLoop

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit               ; call code for exit
    mov     rdi, EXIT_SUCCESS           ; exit with success
    syscall

