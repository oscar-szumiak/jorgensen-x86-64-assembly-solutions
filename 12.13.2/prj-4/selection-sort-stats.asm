; Update the program from the previous question to add a stats function that
; finds the minimum, median, maximum, sum, and average for the sorted list.
; The stats function should be called after the sort function
; to make the minimum and maximum easier to find.
; Use the debugger to execute the program and display the final results.
; Create a debugger input file to show the results.

section .data

; -----
; Define constants

EXIT_SUCCESS    equ 0          ; success code
SYS_exit        equ 60         ; code for terminate

; Define Data.

section     .data

list1       dd      4, 5, 2, -3, 1
len1        dd      5
min1        dd      0
med11       dd      0
med12       dd      0
max1        dd      0
sum1        dd      0
avg1        dd      0

list2       dd      2, 6, 3, -2, 1, 8, 19
len2        dd      7
min2        dd      0
med21       dd      0
med22       dd      0
max2        dd      0
sum2        dd      0
avg2        dd      0

list3       dd      -2, 3, -7, 8
len3        dd      4
min3        dd      0
med31       dd      0
med32       dd      0
max3        dd      0
sum3        dd      0
avg3        dd      0

; **************************************************

section .text

; selectionSort(arr, len)
; Arguments:
; arr, address - rdi
; len, dword value - esi

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

; stats(arr, len, min, med1, med2, max, sum, ave);
; Arguments:
; arr, address – rdi
; len, dword value – esi
; min, address – rdx
; med1, address - rcx
; med2, address - r8
; max, address - r9
; sum, address – stack (rbp+16)
; ave, address – stack (rbp+24)

global stats
stats:
    push    rbp                         ; prologue
    mov     rbp, rsp
    push    r12

; -----
; Get min and max.

    mov     eax, dword [rdi]
    mov     dword [rdx], eax

    mov     r12, rsi
    dec     r12
    mov     eax, dword [rdi+r12*4]
    mov     dword [r9], eax

; -----
; Get medians

    mov     rax, rsi
    mov     rdx, 0
    mov     r12, 2
    div     r12                             ; rax = length/2

    cmp     rdx, 0                          ; even/odd length
    je      evenLength
    
    mov     r12d, dword [rdi+rax*4]         ; get arr[len/2]
    mov     dword [rcx], r12d               ; return med1
    mov     dword [r8], r12d                ; return med2
    jmp     medDone

evenLength:
    mov     r12d, dword [rdi+rax*4]         ; get arr[len/2]
    mov     dword [r8], r12d                ; return med2
    dec     rax
    mov     r12d, dword [rdi+rax*4]         ; get arr[len/2-1]
    mov     dword [rcx], r12d               ; return med1
medDone:

; -----
; Find sum

    mov     r12, 0                          ; counter/index
    mov     rax, 0                          ; running sum

sumLoop:
    add     eax, dword [rdi+r12*4]          ; sum += arr[i]
    inc     r12
    cmp     r12, rsi
    jl      sumLoop

    mov     r12, qword [rbp+16]             ; get sum addr
    mov     dword [r12], eax                ; return sum

; -----
; Calculate average.
    cdq
    idiv    rsi                             ; average = sum/len
    mov     r12, qword [rbp+24]             ; get ave addr
    mov     dword [r12], eax                ; return ave
    
    pop     r12                             ; epilogue
    pop     rbp
    ret

global _start
_start:

; Call function selectionSort for list1

    mov     rdi, list1
    mov     esi, dword [len1]
    call    selectionSort

; Call function stats for list1

    mov     rdi, list1
    mov     esi, dword [len1]
    mov     rdx, min1
    mov     rcx, med11
    mov     r8, med12
    mov     r9, max1
    push    avg1
    push    sum1
    call    stats

; Call function selectionSort for list2

    mov     rdi, list2
    mov     esi, dword [len2]
    call    selectionSort

; Call function stats for list2

    mov     rdi, list2
    mov     esi, dword [len2]
    mov     rdx, min2
    mov     rcx, med21
    mov     r8, med22
    mov     r9, max2
    push    avg2
    push    sum2
    call    stats

; Call function selectionSort for list3

    mov     rdi, list3
    mov     esi, dword [len3]
    call    selectionSort

; Call function stats for list3

    mov     rdi, list3
    mov     esi, dword [len3]
    mov     rdx, min3
    mov     rcx, med31
    mov     r8, med32
    mov     r9, max3
    push    avg3
    push    sum3
    call    stats

; -----
; Done, terminate program.

last:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

