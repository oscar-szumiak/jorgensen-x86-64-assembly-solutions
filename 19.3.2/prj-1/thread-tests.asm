;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2015-2022	Ed Jorgensen
; Copyright (C) 2024		Oscar Szumiak
;

; Implement the outlined example program and create two thread functions
; where each thread function computes the formula MAX/2 times.
; Set MAX to 1,000,000,000 (one billion).
; 
; 1. Initially, structure the main function to call the first thread function
; and wait until it completes until creating the second thread function
; and waiting until it completes. This will force the threads to execute
; sequentially (not in parallel). Include a function to convert the integer
; into a string and display the result to the console. Use the debugger
; as necessary to debug the program. When working, execute the program without
; the debugger and verify that the displayed results are the same as MAX.
; 
; 2. Use the Unix time command to establish a base execute time. Record
; the total elapsed time.
; 
; 3. Restructure the program so that both threads are created and then waiting
; for both to complete. This will allow the execution of the threads
; to occur in parallel. Use the debugger as necessary to debug the program.
; When working, execute the program without the debugger and note the final
; value of MAX. Ensure a full understanding of why the displayed value
; for MAX is incorrect. Additionally, use the Unix time command
; on the modified program to verify that it uses less elapsed time.


section .data

EXIT_SUCCESS    equ     0               ; Successful operation
SYS_exit        equ     60              ; system call code for terminate
SYS_write       equ     1               ; write
SYS_time        equ     201             ; time
NULL            equ     0
NL              equ     10
STDERR          equ     2

pthreadID0      dd      0, 0, 0, 0, 0
pthreadID1      dd      0, 0, 0, 0, 0

MAX             equ     1000000000
x               dq      1
y               dq      1
myValue         dq      0
startTime       dq      0
endTime         dq      0
elapsedTime     dq      0


section .bss

BUFFER_SIZE             equ     20
asciiNumberBuffer       resb    BUFFER_SIZE
asciiTimeBuffer         resb    BUFFER_SIZE


section .text

extern  pthread_create
extern  pthread_join

global _start
_start:
    ; time(&startTime)
    mov     rax, SYS_time
    lea     rdi, qword [startTime]
    syscall

    ; pthread_create(&pthreadID0, NULL,
    ;                &threadFunction0, NULL);
    mov     rdi, pthreadID0
    mov     rsi, NULL
    mov     rdx, threadFunction0
    mov     rcx, NULL
    call    pthread_create

    ; pthread_create(&pthreadID1, NULL,
    ;                &threadFunction0, NULL);
    mov     rdi, pthreadID1
    mov     rsi, NULL
    mov     rdx, threadFunction0
    mov     rcx, NULL
    call    pthread_create

    ; pthread_join (pthreadID0, NULL);
    mov     rdi, qword [pthreadID0]
    mov     rsi, NULL
    call    pthread_join
    
    ; pthread_join (pthreadID1, NULL);
    mov     rdi, qword [pthreadID1]
    mov     rsi, NULL
    call    pthread_join

    ; time(&endTime)
    mov     rax, SYS_time
    lea     rdi, qword [endTime]
    syscall

    ; calculate elapsed time
    mov     rax, qword [endTime]
    sub     rax, qword [startTime]
    mov     qword [elapsedTime], rax

    ; convert result to ascii
    mov     rdi, qword [myValue]
    mov     rsi, asciiNumberBuffer
    mov     rdx, BUFFER_SIZE
    call    uintToAscii                     ; Convert result to string

    ; print calculated value
    mov     rax, SYS_write
    mov     rdi, STDERR
    mov     rsi, asciiNumberBuffer
    mov     rdx, BUFFER_SIZE
    syscall                                 ; Print number

    ; convert time to ascii
    mov     edi, dword [elapsedTime]
    mov     rsi, asciiTimeBuffer
    mov     rdx, BUFFER_SIZE
    call    uintToAscii                     ; Convert time to string

    ; print elapsed time
    mov     rax, SYS_write
    mov     rdi, STDERR
    mov     rsi, asciiTimeBuffer
    mov     rdx, BUFFER_SIZE
    syscall                                 ; Print number

last:
    mov     rax, SYS_exit
    mov     rbx, EXIT_SUCCESS               ; exit w/success
    syscall


; -----
global threadFunction0
threadFunction0:

; Perform MAX / 2 iterations to update myValue.

    mov     rcx, MAX
    shr     rcx, 1                  ; divide by 2
    mov     r10, qword [x]
    mov     r11, qword [y]
incLoop0:
    ; myValue = (myValue / x) + y
    
    mov     rax, qword [myValue]
    cqo
    div     r10
    add     rax, r11
    mov     qword [myValue], rax
    loop    incLoop0

    ret


; Convert a unsigned integer to an ASCII string
; uintToAscii(number, string, maxLen, maxWidth)
; Arguments:
;   rdi - number, dword value
;   rsi - string, address
;   rdx - maxLen, qword value

global uintToAscii
uintToAscii:
    push    rbx
    push    rbp                             ; prologue
    mov     rbp, rsp

    mov     rax, rdi                        ; get integer
    mov     r8, rsi                         ; get addr of string
    mov     r9, rdx                         ; get maxlen

; -----
; Part A - Successive division

    mov     rdi, 0                          ; idx = 0
    mov     rcx, 0                          ; digitCount = 0
    mov     rbx, 10                         ; set for dividing by 10
divideLoop:
    cqo
    div     rbx                             ; divide number by 10

    push    rdx                             ; push remainder
    inc     rcx                             ; increment digitCount

    cmp     rax, 0                          ; if (result != 0)
    jne     divideLoop                      ; goto divideLoop

; -----
; Part B - Convert remainders and store

popLoop:
    pop     rax                             ; pop intDigit
    add     al, "0"                         ; char = int + "0"
    mov     byte [r8+rdi], al               ; string[idx] = char
    inc     rdi                             ; increment idx
    loop    popLoop                         ; if (digitCount > 0)
                                            ; goto popLoop
    mov     byte [r8+rdi], NL               ; string[idx] = NL
    inc     rdi
    mov     byte [r8+rdi], NULL

    pop     rbp                             ; epilogue
    pop     rbx
    ret

