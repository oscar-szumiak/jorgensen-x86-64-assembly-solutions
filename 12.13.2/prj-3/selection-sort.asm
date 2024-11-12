;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2024 Oscar Szumiak
;

; Create a main program and a function that will sort a list of numbers
; in ascending order. Use the following selection sort algorithm:
; 
; begin
;     for i = 0 to len-1
;         small = arr(i)
;         index = i
;         for j = i to len-1
;             if ( arr(j) < small ) then
;                 small = arr(j)
;                 index = j
;             end_if
;         end_for
;         arr(index) = arr(i)
;         arr(i) = small
;     end_for
; end_begin
; 
; The main should call the function on at least three different data sets.
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.

section .data

; -----
; Define constants

EXIT_SUCCESS    equ 0          ; success code
SYS_exit        equ 60         ; code for terminate

; Define Data.

section .data

list1       dd      4, 5, 2, -3, 1
len1        dd      5

list2       dd      2, 6, 3, -2, 1, 8, 19
len2        dd      7

list3       dd      -2, 3, -7, 8
len3        dd      4

; **************************************************

section .text

; selectionSort(arr, len)
;
; Arguments:
;   arr, address - rdi
;   len, dword value - esi

global selectionSort
selectionSort:
    push    rbp                         ; prologue
    mov     rbp, rsp
    push    r12

    mov     r12, rdi                    ; get array address
    mov     eax, 0                      ; i = 0
outerLoop:
    mov     r8d, dword [r12+rax*4]      ; small   
    mov     r9d, eax                    ; index = i
    mov     ecx, eax                    ; j = i

innerLoop:
    cmp     dword [r12+rcx*4], r8d
    jg      noNewSmall
    mov     r8d, dword [r12+rcx*4]      ; small = arr[j]
    mov     r9d, ecx                    ; index = j
noNewSmall:
    inc     ecx
    cmp     ecx, esi
    jl      innerLoop

    mov     r10d, dword [r12+rax*4]     ; tmp = arr[i]
    mov     dword [r12+r9*4], r10d      ; arr[index] = tmp
    mov     dword [r12+rax*4], r8d      ; arr[i] = small
    inc     eax
    cmp     eax, esi
    jl      outerLoop

    pop     r12                         ; epilogue
    pop     rbp
    ret

global _start
_start:

; Call function selectionSort for list1

    mov     rdi, list1
    mov     esi, dword [len1]
    call    selectionSort

; Call function selectionSort for list2

    mov     rdi, list2
    mov     esi, dword [len2]
    call    selectionSort

; Call function selectionSort for list3

    mov     rdi, list3
    mov     esi, dword [len3]
    call    selectionSort

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

