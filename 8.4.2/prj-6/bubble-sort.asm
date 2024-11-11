; Create a program to sort a list of numbers. Use the following bubble sort
; algorithm:
; 
; for ( i = (len-1) to 0 ) {
;     swapped = false
;     for ( j = 0 to i-1 )
;         if ( lst(j) > lst(j+1) ) {
;             tmp = lst(j)
;             lst(j) = lst(j+1)
;             lst(j+1) = tmp
;             swapped = true
;         }
;     if ( swapped = false ) exit
; }
; 
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.


section .data

; Constants

EXIT_SUCCESS    equ     0       ; successful operation
SYS_exit        equ     60      ; call code for terminate

; Data

lst     dd      7,  3,  2,  5,  7,  8,  1,  9,  4,  6
len     dd      10

section .text

global _start
_start:

    mov     eax, dword[len]                     ; Set outer loop index (i)
    dec     eax
outerLoop:
    mov     bl, 1                               ; Set swapped to false
    mov     ecx, 0                              ; Set inner loop index (j)
innerLoop:
    mov     edx, dword [lst+ecx*4]
    cmp     edx, dword [lst+(ecx+1)*4]
    jb      noSwap                              ; lst[j] < lst[j+1]
    mov     esi, dword [lst+(ecx+1)*4]          ; Swap elements
    mov     dword [lst+ecx*4], esi
    mov     dword [lst+(ecx+1)*4], edx
    mov     bl, 0                               ; Set swapped to true
noSwap:
    mov     esi, ecx
    inc     ecx
    cmp     esi, eax
    jb      innerLoop                           ; j < i

    cmp     bl, 0                               ; Check if swapped is false
    jne     last                                ; swapped != true
    
    mov     esi, eax
    dec     eax                                 ; Decrement i
    cmp     esi, 0
    jne     outerLoop                           ; i != 0

last:
    mov rax, SYS_exit           ; call code for exit
    mov rdi, EXIT_SUCCESS       ; exit with success
    syscall

