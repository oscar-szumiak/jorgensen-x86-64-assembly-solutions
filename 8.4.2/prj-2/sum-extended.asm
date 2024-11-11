; Update the example program from the previous question to find the maximum,
; minimum, and average for the list of numbers. Use the debugger to execute
; the program and display the final results. Create a debugger input file
; to show the results.

; *****************************************************
; Data declarations

section     .data
; -----
; Define constants

EXIT_SUCCESS    equ 0       ; successful operation
SYS_exit        equ 60      ; call code for terminate

; -----
; Define Data.

section     .data

lst     dd      1002, 1004, 1006, 1008, 10010
len     dd      5
sum     dd      0
max     dd      0
min     dd      0
avg     dd      0

; ********************************************************
section     .text
global _start
_start:

    mov     eax, dword [lst]
    mov     dword [max], eax
    mov     dword [min], eax

; -----
; Summation loop.

    mov     ecx, dword [len]            ; get length value
    mov     rsi, 0                      ; index=0
sumLoop:
    mov     eax, dword [lst+(rsi*4)]    ; get lst[rsi]
    add     dword [sum], eax            ; update sum
    cmp     eax, dword [min]            ; check if new min
    jg      noNewMin
    mov     dword [min], eax
noNewMin:
    cmp     eax, dword [max]            ; check if new max
    jl      noNewMax
    mov     dword [max], eax
noNewMax:
    inc     rsi                         ; next item
    loop    sumLoop

    mov     eax, dword [sum]            ; calculate avg
    div     dword [len]
    mov     dword [avg], eax

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit               ; call code for exit
    mov     rdi, EXIT_SUCCESS           ; exit with success
    syscall

