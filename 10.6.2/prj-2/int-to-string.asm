; Update the example program to address signed integers.
; This will require including a preceding sign, “+” or “-” in the string.
; For example, -123 10 (0xFFFFFF85) would be “-123” with a NULL
; termination (total of 5 bytes).
; Additionally, the signed divide (IDIV, not DIV) and signed conversions
; (e.g., CDQ) must be used.
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.

section .data

; -----
; Constants

NULL                equ     0
EXIT_SUCCESS        equ     0           ; successful operation
SYS_exit            equ     60          ; code for terminate

; -----
; Data

intNum          dd      -1786

section .bss

strNum          resb    10

; *********************************************************

section .text
global _start
_start:

; Convert an signed integer to an ASCII string

; -----
; Part A - Successive division

    mov     eax, dword [intNum]             ; get integer
    mov     rbp, strNum                     ; get addr of string
    mov     rdi, 0                          ; idx = 0
    mov     byte [rbp+rdi], "+"
    
    cmp     dword [intNum], 0
    jg      positive
    
    imul    eax, -1
    mov     byte [rbp+rdi], "-"

positive:
    add     rdi, 1
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
    mov     byte [rbp+rdi], al              ; string[idx] = char
    inc     rdi                             ; increment idx
    loop    popLoop                         ; if (digitCount > 0)
                                            ; goto popLoop
    mov     byte [rbp+rdi], NULL            ; string[idx] = NULL
    jmp     last

; -----
; Done, terminate program

last:
    mov rax, SYS_exit                       ; call code for exit
    mov rdi, EXIT_SUCCESS                   ; exit with success
    syscall

