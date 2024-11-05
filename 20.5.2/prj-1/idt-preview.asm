; Write a program to obtain and list the contents of the IDT.
; This will require an integer to ASCII/Hex program in order to display
; the applicable addresses in hex.
; Use the debugger as necessary to debug the program.
; When working, execute the program without the debugger to display results.


section     .data

SYS_exit        equ     60              ; system call code for terminate
SYS_write       equ     1               ; write

EXIT_SUCCESS    equ     0               ; Successful operation
NULL            equ     0
LF              equ     10
STDERR          equ     2

hexValues       db      "0123456789ABCDEF", NULL


section     .bss

BUFFER_SIZE     equ     30

idt_data        resb    10              ; 2 (size) + 8 (start address of IDT)
hexBuffer       resb    BUFFER_SIZE


section     .text


global _start
_start:
    sidt    byte [idt_data]

    mov     rcx, 0
    mov     rbx, qword [idt_data+2]
printLoop:
    lea     rdi, byte [rbx+rcx*16]
    mov     rsi, 16
    lea     rdx, byte [hexBuffer]
    mov     rcx, BUFFER_SIZE-1
    call    intToHex                        ; Get hex representation of data

    mov     r12, rax
    mov     byte [hexBuffer+r12], LF        ; Add newline

    mov     rax, SYS_write
    mov     rdi, STDERR
    lea     rsi, byte [hexBuffer]
    mov     rdx, r12
    syscall                                 ; Print hex representation of data

    cmp     ecx, word [idt_data]
    jb      printLoop

last:
    mov     rax, SYS_exit
    mov     rbx, EXIT_SUCCESS               ; exit w/success
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
;        0 - size of data is equal to zero
;       -1 - hexBuffer size is too small

global intToHex
intToHex:
    cmp     rsi, 0                  ; Check if size of data is zero 
    jne     checkBuffer
    
    mov     rax, 0
    ret

checkBuffer:
    mov     rax, rsi
    mov     r8, 2
    mul     r8                      ; Calculate number of ascii hex bytes
    cmp     rcx, rax                ; and check against hexBuffer size
    jae     convert

    mov     rax, -1
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
    mov     r10d, byte [hexValues+rax]
    mov     byte [r14+r11], r10d
    inc     r11
    
    mov     al, byte [r12+rcx]
    and     rax, 0x000000000000000F         ; Get lower 4 bits
    mov     r10d, byte [hexValues+rax]
    mov     byte [r14+r11], r10d
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

