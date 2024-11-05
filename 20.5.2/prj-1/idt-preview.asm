; Write a program to obtain and list the contents of the IDT.
; This will require an integer to ASCII/Hex program in order to display
; the applicable addresses in hex.
; Use the debugger as necessary to debug the program.
; When working, execute the program without the debugger to display results.


section     .data

SYS_exit        equ     60
SYS_write       equ     1

EXIT_SUCCESS    equ     0
EXIT_FAILURE    equ     1

STDOUT          equ     1
STDERR          equ     2

LF              equ     10
NULL            equ     0

hexValues       db      "0123456789ABCDEF", NULL


section     .bss

BUFFER_SIZE     equ     40

idt_data        resb    10              ; 2 (size) + 8 (start address of IDT)
hexBuffer       resb    BUFFER_SIZE


section     .text

global _start
_start:
    sidt    byte [idt_data]

    mov     r12, 0
    mov     r13, qword [idt_data+2]
printLoop:
    mov     rax, r12
    mov     rdi, 16
    mul     rdi
    add     rax, r13
    mov     rdi, rax                        ; lea   rdi, byte [r13+r12*16]

    mov     rsi, 16
    lea     rdx, byte [hexBuffer]
    mov     rcx, BUFFER_SIZE-1
    call    intToHex                        ; Get hex representation of data

    mov     rdi, EXIT_FAILURE
    cmp     rax, 0
    jle     last

    mov     r14, rax
    mov     byte [hexBuffer+r14], LF        ; Add newline

    mov     rax, SYS_write
    mov     rdi, STDERR
    lea     rsi, byte [hexBuffer]
    mov     rdx, r14
    syscall                                 ; Print hex representation of data

    inc     r12

    cmp     r12w, word [idt_data]
    jb      printLoop
    
    mov     rdi, EXIT_SUCCESS

last:
    mov     rax, SYS_exit
    syscall


; Convert a given number of bytes to ascii hex representation in a buffer
;
; intToHex(int* data, int nrBytes, char* hexBuffer, int bufferSize)
;
; Arguments:
;   rdi - base address of data
;   rsi - size of data in bytes
;   rdx - address of hexBuffer
;   rcx - size of hexBuffer in bytes
;
; Returns:
;   On success:
;       Size of hex string
;   On failure:
;       -1 - size of data is equal to zero
;       -2 - hexBuffer size is too small

global intToHex
intToHex:
    cmp     rsi, 0                  ; Check if size of data is zero 
    jne     checkBuffer
    
    mov     rax, -1
    ret

checkBuffer:
    mov     rax, rsi
    mov     r8, 2
    mul     r8                      ; Calculate number of ascii hex bytes
    cmp     rcx, rax                ; and check against hexBuffer size
    jae     convert

    mov     rax, -2
    ret

convert:
    push    r12
    push    r13
    push    r14
    push    r15
   
    mov     r12, rdi                ; Save arguments
    mov     r13, rsi
    mov     r14, rdx
    mov     r15, rcx

    mov     rcx, 0                  ; Index of input data
    mov     rax, 0                  ; Temporary input byte variable
    mov     r10, 0                  ; Temporary output byte variable
    mov     r11, 0                  ; Index of hexBuffer
hexLoop:
    mov     al, byte [r12+rcx]
    shr     al, 4                           ; Get upper 4 bits
    mov     r10b, byte [hexValues+rax]
    mov     byte [r14+r11], r10b
    inc     r11
    
    mov     al, byte [r12+rcx]
    and     rax, 0x000000000000000F         ; Get lower 4 bits
    mov     r10b, byte [hexValues+rax]
    mov     byte [r14+r11], r10b
    inc     r11

    inc     rcx

    cmp     rcx, r13
    jb      hexLoop

    mov     rax, r11

    pop     r15
    pop     r14
    pop     r13
    pop     r12

    ret

