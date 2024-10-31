; Implement a program to perform the summation:
; 
; sum (i = 1 to 10) 0.1
; 
; Compare the results of the summation to the value 1.0 and display
; a message “Are Same” if the summation result equals 1.0 and the message
; “Are Not Same” if the result of the summation does not equal 1.0.
; Use the debugger as needed to debug the program. When working,
; execute the program without the debugger and verify that the expected
; results are displayed to the console.


section     .data

LF                      equ     10
NULL                    equ     0
SUCCESS                 equ     0
SYS_exit                equ     60
SYS_write               equ     1

STDIN                   equ     0
STDOUT                  equ     1
STDERR                  equ     2

msg_eq                  db      "Are Same", LF, NULL
msg_eq_size             dq      9
msg_ne                  db      "Are Not Same", LF, NULL
msg_ne_size             dq      13

dqZero                  dq      0.0
dqVal                   dq      0.1
dqResult                dq      0.0
dqExpectedResult        dq      1.0

section     .text

global _start
_start:

    movsd   xmm0, qword [dqZero]
    mov     rcx, 10
sumLoop:
    addsd   xmm0, qword [dqVal]
    loop sumLoop

    movsd   qword [dqResult], xmm0
    
    mov     rax, SYS_write
    mov     rdi, STDERR

    ucomisd     xmm0, qword [dqExpectedResult]
    jne         notEqual
    jmp         equal
    
notEqual:
    lea     rsi, byte [msg_eq]
    mov     rdx, msg_eq_size

    jmp     printMsg

equal:
    lea     rsi, byte [msg_ne]
    mov     rdx, msg_ne_size
    
printMsg:
    syscall

last:
    mov rax, SYS_exit
    mov rbx, SUCCESS
    syscall
