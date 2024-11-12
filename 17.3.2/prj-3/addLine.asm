;
; SPDX-License-Identifier: CC-BY-NC-SA-4.0
;
; Copyright (C) 2024 Oscar Szumiak
;

; Create a program that will read two file names from the command line,
; read lines from the first file, add line numbers, and write the modified
; line (with the line number) to the second file. For example, your add lines
; program might be initiated with:
; 
; ./addLine inFile.txt newFile.txt
; 
; where the inFile.txt exists and contains standard ASCII text.
; If the inFile.txt file does not exist an error should be generated
; and the program terminated. The program should open/create the file
; newFile.txt and write the lines, with the line numbers, to the newFile.txt
; file. The output file should be created, deleting an old version
; if one exists. Use a text editor to verify that the line numbers track
; correctly in the output file.

section     .data

LF                  equ     10
NULL                equ     0 
TRUE                equ     1
FALSE               equ     0

STDIN               equ     0
STDOUT              equ     1
STDERR              equ     2

SYS_read            equ     0
SYS_write           equ     1
SYS_open            equ     2
SYS_close           equ     3
SYS_exit            equ     60

EXIT_SUCCESS        equ     0
EXIT_FAILURE        equ     1

O_CREAT             equ     0x40
O_WRONLY            equ     000001q
O_TRUNC             equ     0x200
O_RDONLY            equ     000000q
O_APPEND            equ     0x400

S_IRUSR             equ     00400q
S_IWUSR             equ     00200q
S_IXUSR             equ     00100q

argCountError               db      "Incorrect number of arguments given", LF, NULL
argCountErrorLength         dq      37

inputFileOpenError          db      "Failed to open input file", LF, NULL
inputFileOpenErrorLength    dq      27

outputFileCreationError           db      "Failed to create output file", LF, NULL
outputfileCreationErrorLength     dq      30

LINE_NUMBER_BUFFER_SIZE     equ     4
LINE_BUFFER_SIZE            equ     1024


section     .bss

lineNumberBuffer        resb        LINE_NUMBER_BUFFER_SIZE
lineBuffer              resb        LINE_BUFFER_SIZE


section     .text

extern myGetLine

global _start
_start:
    mov     r12, qword [rsp]                ; argc
    lea     r13, qword [rsp+8]              ; argv

    cmp     r12, 3
    jne     argumentError

    mov     rax, SYS_open
    mov     rdi, qword [r13+8]
    mov     rsi, O_RDONLY
    syscall                                 ; Open input file

    cmp     rax, 0
    jl      inputOpenError

    mov     r14, rax                        ; Save input file descriptor

    mov     rax, SYS_open
    mov     rdi, qword [r13+16]
    mov     rsi, O_CREAT | O_WRONLY | O_TRUNC | O_APPEND
    mov     rdx, S_IRUSR | S_IWUSR
    syscall                                 ; Open output file
                                            ; Equivalent to SYS_creat

    cmp     rax, 0
    jl      outputCreationError

    mov     r15, rax                        ; Save output file descriptor

    mov     r13, 0                          ; Line number
getLineLoop:
    mov     rdi, r14
    mov     rsi, lineBuffer
    mov     rdx, LINE_BUFFER_SIZE
    call    myGetLine                       ; Get next line from input file

    cmp     rax, FALSE
    je      closeFiles

    inc     r13

    mov     rbx, 1
getLengthLoop:                              ; Get line length
    cmp     byte [lineBuffer+rbx-1], LF
    je      writeLine
    inc     rbx
    jmp     getLengthLoop
    
writeLine:
    mov     rdi, r13
    mov     rsi, lineNumberBuffer
    mov     rdx, LINE_NUMBER_BUFFER_SIZE
    call    uintToAscii                     ; Convert line number to string

    mov     rax, SYS_write
    mov     rdi, r15
    mov     rsi, lineNumberBuffer
    mov     rdx, LINE_NUMBER_BUFFER_SIZE
    syscall                                 ; Write line number to output file

    mov     rax, SYS_write
    mov     rdi, r15
    mov     rsi, lineBuffer
    mov     rdx, rbx
    syscall                                 ; Write line to output file

    jmp     getLineLoop

closeFiles:
    mov     rax, SYS_close
    mov     rdi, r14
    syscall                                 ; Close input file

    mov     rax, SYS_close
    mov     rdi, r15
    syscall                                 ; Close output file
    
    jmp     exitSuccess

argumentError:
    mov     rax, SYS_write
    mov     rdi, STDERR
    mov     rsi, argCountError
    mov     rdx, qword [argCountErrorLength]
    syscall

    jmp     exitFailure

inputOpenError:
    mov     rax, SYS_write
    mov     rdi, STDERR
    mov     rsi, inputFileOpenError
    mov     rdx, qword [inputFileOpenErrorLength]
    syscall

    jmp     exitFailure

outputCreationError:
    mov     rax, SYS_write
    mov     rdi, STDERR
    mov     rsi, outputFileCreationError
    mov     rdx, qword [outputfileCreationErrorLength]
    syscall

exitFailure:
    mov     rdi, EXIT_FAILURE
    jmp     programExit

exitSuccess:
    mov     rdi, EXIT_SUCCESS

programExit:
    mov     rax, SYS_exit
    syscall


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
    mov     byte [r8+rdi], " "              ; string[idx] = NULL

; -----
; Part C - Right justify the result

    inc     rdi
justifyLoop:
    mov     al, byte [r8+rdi-1]
    mov     byte [r8+r9-1], al
    dec     rdi
    dec     r9
    cmp     rdi, 0
    jne     justifyLoop

clearLoop:
    mov     byte [r8+r9-1], " "
    dec     r9
    cmp     r9, 0
    jne     clearLoop

    pop     rbp                             ; epilogue
    pop     rbx
    ret

