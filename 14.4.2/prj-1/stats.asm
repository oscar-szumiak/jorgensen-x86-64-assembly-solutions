;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

section     .text

; stats(arr, len, sum, ave);
; -----
; Arguments:
; arr, address – rdi
; len, dword value – esi
; sum, address – rdx
; ave, address - rcx

global stats
stats:
    push    r12                     ; prologue

    mov     r12, 0                  ; counter/index
    mov     rax, 0                  ; running sum
sumLoop:
    add     eax, dword [rdi+r12*4]      ; sum += arr[i]
    inc     r12
    cmp     r12, rsi
    jl      sumLoop

    mov     dword [rdx], eax

    cdq
    idiv    esi
    mov     dword [rcx], eax        ; return sum

    pop     r12                     ; epilogue
    ret

