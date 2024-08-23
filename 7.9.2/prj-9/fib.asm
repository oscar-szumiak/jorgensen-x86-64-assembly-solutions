; Create a program to iteratively find the nth Fibonacci number.
; The value for n should be set as a parameter
; (e.g., a programmer defined constant).
;
; The formula for computing Fibonacci is as follows:
; F(0) = 0
; F(1) = 1
; F(n) = F(n-2) + F(n-1) for n >= 2
;
; Use the debugger to execute the program and display the final results.
; Test the program for various values of n.
; Create a debugger input file to show the results in both decimal
; and hexadecimal.

;  Data declarations

section .data

; -----
;  Define constants

SUCCESS         equ     0       ; Successful operation
SYS_exit        equ     60      ; call code for terminate

;  Define Data.

n               dd      50
nFib            dq      0

; *******************************************************

section .text
global _start
_start:

; -----
; Count the n-th Fibonacci number

    mov ecx, dword [n]
    dec ecx
    mov rax, 0
    mov rbx, 1
    mov rdx, 0
fibLoop:
    mov rdx, rax
    add rdx, rbx
    mov rax, rbx
    mov rbx, rdx
    loop fibLoop

    mov qword [nFib], rdx

; -----
;  Done, terminate program.

last:
    mov rax, SYS_exit ; call code for exit
    mov rdi, SUCCESS ; exit with success
    syscall

