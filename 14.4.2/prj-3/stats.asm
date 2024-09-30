section     .text

; lstSum(arr, len);
; -----
; Arguments:
;   arr, address – rdi
;   len, dword value – esi
; Returns:
;   sum, dword value - eax

global lstSum
lstSum:
    push    r12

    mov     r12, 0
    mov     rax, 0
sumLoop:
    add     eax, dword [rdi+r12*4]
    inc     r12
    cmp     r12, rsi
    jl      sumLoop

    pop     r12
    ret

; lstAverage(sum, len);
; -----
; Arguments:
;   sum, dword value – edi
;   len, dword value – esi
; Returns:
;   avg, dword value - eax

global lstAverage
lstAverage:
    mov     eax, edi
    cdq
    idiv    esi
    ret

