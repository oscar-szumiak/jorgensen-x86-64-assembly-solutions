; Create a main and implement the stats1 example function.
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.

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
sum1        dd      0
ave1        dd      0

list2       dd      2, 6, 3, -2, 1, 8, 19
len2        dd      7
sum2        dd      0
ave2        dd      0

; **************************************************

section     .text

; Simple example function to find and return
; the sum and average of an array.

; HLL call:
; stats1(arr, len, sum, ave);
; -----
; Arguments:
; arr, address – rdi
; len, dword value – esi
; sum, address – rdx
; ave, address - rcx

global stats1
stats1:
    push    r12                     ; prologue

    mov     r12, 0                  ; counter/index
    mov     rax, 0                  ; running sum
sumLoop:
    add eax, dword [rdi+r12*4]      ; sum += arr[i]
    inc r12
    cmp r12, rsi
    jl sumLoop

    mov dword [rdx], eax

    cdq
    idiv    esi
    mov     dword [rcx], eax        ; return sum

    pop     r12
    ret

global _start
_start:

; Call function stats1 for list1

    mov     rdi, list1
    mov     esi, dword [len1]
    mov     rdx, sum1
    mov     rcx, ave1
    call    stats1

; Call function stats1 for list1

    mov     rdi, list2
    mov     esi, dword [len2]
    mov     rdx, sum2
    mov     rcx, ave2
    call    stats1

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

