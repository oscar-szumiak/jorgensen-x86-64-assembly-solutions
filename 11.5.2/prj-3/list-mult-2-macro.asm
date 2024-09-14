; Create a macro to update an existing list by multiplying every element by 2.
; Invoke the macro at least three times of three different data sets.
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.

; **************************************************
; Define the macro called with two arguments:
; double <lst>, <len>

%macro double 2
    mov     r12, 0
    lea     rbx, [%1]

    mov     ecx, dword [%2]             ; length

%%doubleLoop:
    mov     eax, dword [rbx+r12*4]      ; get list[n]
    imul    eax, 2
    mov     dword [rbx+r12*4], eax      ; set list[n]*2
    inc     r12
    loop    %%doubleLoop
    
%endmacro

; **************************************************
; Data declarations

section     .data

; -----
; Define constants

EXIT_SUCCESS    equ 0          ; success code
SYS_exit        equ 60         ; code for terminate

; Define Data.

section     .data

list1       dd      4, 5, 2, -3, 1
len1        dd      5

list2       dd      2, 6, 3, -2, 1, 8, 19
len2        dd      7

list3       dd      17, 18, -10, 4, 2, 35, 3, 23, -21
len3        dd      9

; **************************************************

section     .text
global _start
_start:

; -----
; Use the macro in the program

    double    list1, len1       ; 1st, data set 1
    double    list2, len2       ; 2nd, data set 2
    double    list3, len3       ; 3nd, data set 3

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

