; Create an assembly language program that will accept three unsigned integer
; numbers from the command line, add the three numbers, and display each
; of the three original numbers and the sum. If too many or too few command
; line arguments are provided, an error message should be displayed.
; This program will require that each of the ASCII strings be converted
; into integer.  Appropriate error checking should be included. For example,
; “123” is correct while “12a3” is incorrect. The main program should call
; functions as necessary for the ASCII to integer conversion and the output.
; Use the debugger as necessary to debug the program. Execute the program
; without the debugger and verify the appropriate output is displayed
; to the console.

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

O_RDONLY            equ     000000q

BUFFER_SIZE         equ     256


msgArgCountError           db      "Incorrect number of arguments given", LF, NULL
msgArgCountErrorLength     dq      36

newLine         db      LF, NULL
newLineLength   dq      1


section     .text

global _start
_start:
    mov     r12, qword [rsp]        ; argc
    lea     r13, byte [rsp+8]       ; argv

    push    rbp
    mov     rbp, rsp
    sub     rsp, 32             ; 4 x 64-bit variables (val1, val2, val3, sum)
    sub     rsp, BUFFER_SIZE    ; Sum string buffer
    
    cmp     r12, 4
    jne     argCountError

    mov     r14, 1
printLoop:
    mov     rdi, qword [r13+r14*8]
    mov     rsi, 20
    call    strLen

    mov     rdx, rax
    mov     rax, SYS_write
    mov     rdi, STDOUT
    mov     rsi, qword [r13+r14*8]
    syscall

    mov     rax, SYS_write
    mov     rdi, STDOUT
    lea     rsi, byte [newLine]
    mov     rdx, qword [newLineLength]
    syscall

    inc     r14
    cmp     r14, 4
    jb      printLoop

    mov     r14, 1
valueConversionLoop:
    mov     rdi, qword [r13+r14*8]
    lea     rsi, qword [rbp-32+(r14-1)*8]
    call    asciiToInt
    inc     r14
    cmp     r14, 4
    jb      valueConversionLoop

    mov     r14, 1
sumLoop:
    mov     rax, qword [rbp-32+(r14-1)*8]
    add     qword [rbp-8], rax
    inc     r14
    cmp     r14, 4
    jb      sumLoop

    mov     rdi, qword [rbp-8]
    lea     rsi, byte [rbp-32-BUFFER_SIZE]
    mov     rdx, BUFFER_SIZE
    call    intToAscii

    lea     rdi, byte [rbp-32-BUFFER_SIZE]
    mov     rsi, BUFFER_SIZE
    call    strLen

    mov     rdx, rax
    mov     rax, SYS_write
    mov     rdi, STDOUT
    lea     rsi, byte [rbp-32-BUFFER_SIZE]
    syscall

    mov     rax, SYS_write
    mov     rdi, STDOUT
    lea     rsi, byte [newLine]
    mov     rdx, qword [newLineLength]
    syscall

    jmp     exitSuccess

argCountError:
    mov     rax, SYS_write
    mov     rdi, STDOUT
    mov     rsi, msgArgCountError
    mov     rdx, qword [msgArgCountErrorLength]
    syscall
    jmp     exitFailure

exitSuccess:
    mov     rdi, EXIT_SUCCESS
    jmp     programExit

exitFailure:
    mov     rdi, EXIT_FAILURE

programExit:
    add     rsp, BUFFER_SIZE
    add     rsp, 32
    pop     rbp

    mov     rax, SYS_exit
    syscall


; strlen(char* string, int maxSearch)
; Args:
;   rdi - address - null terminated string
;   rsi - value - max string length search
; Returns:
;   Zero if string pointer is null
;   Length of string
;   maxSearch if null is not found in the first maxSearch characters of the string
global strLen
strLen:
    mov     rax, 0
strLenCountLoop:
    cmp     byte [rdi+rax], NULL
    je      strLenExit
    inc     rax
    cmp     rax, rsi
    je      strLenExit
    jmp     strLenCountLoop
    
strLenExit:
    ret


; asciiToInt(char* numString, int num)
; Args:
;   rdi - address - null terminated string representation of a number
;   rsi - address - output integer location
; Returns:
;   0 - On success
;   1 - On failure
global asciiToInt
asciiToInt:
    push    r12
    push    r13
    push    r14

    mov     r12, rdi
    mov     r13, rsi

    mov     rsi, 20
    call    strLen

    mov     r14, rax                        ; Get string length

    mov     rcx, 0                          ; Check sign
    mov     al, byte [r12]
    cmp     al, "-"
    je      withSign
    cmp     al, "+"
    je      withSign
    jmp     checkDigitsLoop

withSign:
    inc     rcx

checkDigitsLoop:                            ; Check digits
    mov     rax, 0
    mov     al, byte [r12+rcx]
    cmp     al, "0"
    jl      asciiToIntFailure
    cmp     al, "9"
    jg      asciiToIntFailure
    inc     rcx
    cmp     rcx, r14
    jb      checkDigitsLoop

    mov     qword [r13], 0                  ; Initialize result to 0
    mov     rcx, r14
    mov     r8, 10
    mov     rsi, 0                          ; Power of char value
convertionLoop:
    mov     rax, 0
    mov     al, byte [r12+rcx-1]            ; Get next char
    
    cmp     al, "-"
    je      breakNegative
    cmp     al, "+"
    je      breakPositive

    sub     al, "0"
    
    mov     r9, rsi                         ; Copy value of power
    cmp     r9, 0
    je      zeroPower
powerLoop:                                  ; Calculate value of char
    imul    rax, r8
    dec     r9
    cmp     r9, 0
    jne     powerLoop
zeroPower:
    add     qword [r13], rax                ; Add value to variable
    inc     rsi
    loop    convertionLoop
    
    jmp     breakPositive

asciiToIntFailure:
    mov     rdi, EXIT_FAILURE
    jmp     last

breakNegative:
    mov     rax, qword [r13]
    imul    rax, -1
    mov     qword [r13], rax

breakPositive:
asciiToIntSuccess:
    mov     rdi, EXIT_SUCCESS

last:
    mov     rax, SYS_exit
    
    pop     r14
    pop     r13
    pop     r12
    ret


; intToAscii(int num, char* numString, int bufferSize)
; Args:
;   rdi - value - input integer
;   rsi - address - output buffer
;   rdx - value - size of output buffer
; Returns:
;   0 - On success
;   1 - On failure
global intToAscii
intToAscii:
    push    rbp
    mov     rbp, rsp

    mov     rax, rdi                        ; input integer
    mov     r8, rsi                         ; address of output buffer
    mov     r9, rdx                         ; output buffer size

    mov     rdi, 0                          ; idx = 0
    cmp     rax, 0
    jge     positive
    
    imul    rax, -1
    mov     byte [r8+rdi], "-"
    inc     rdi

positive:
    mov     rcx, 0                          ; digitCount = 0
    mov     rbx, 10                         ; set for dividing by 10
divideLoop:
    cqo
    idiv    rbx                             ; divide number by 10

    push    rdx                             ; push remainder
    inc     rcx                             ; increment digitCount

    cmp     rax, 0                          ; if (result != 0)
    jne     divideLoop                      ; goto divideLoop

popLoop:
    pop     rax                             ; pop intDigit
    add     al, "0"                         ; char = int + "0"
    mov     byte [r8+rdi], al               ; string[idx] = char
    inc     rdi                             ; increment idx
    cmp     rdi, r9
    je      terminateString
    loop    popLoop                         ; if (digitCount > 0)
                                            ; goto popLoop
terminateString:
    mov     byte [r8+rdi], NULL             ; string[idx] = NULL

    pop     rbp
    ret

