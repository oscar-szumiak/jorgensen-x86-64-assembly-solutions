; Create an assembly language program to accept a file name on the command
; line and open the file and display the one line message contained
; in the file. A series of small text file should be created each containing
; one of the very important messages at the start of each chapter of this text.
; The program should perform error checking on the file name, and if valid,
; open the file. If the file opens successfully, the message should be read
; from the file displayed to the console.  Appropriate error messages should
; be displayed if the file cannot be opened or read. The program may assume
; that each message will be < 256 characters. Use the debugger as necessary
; to debug the program. Execute the program without the debugger and verify
; the appropriate output is displayed to the console.

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


argCountError           db      "Incorrect number of arguments given", LF, NULL
argCountErrorLength     dq      37

fileOpenError           db      "Failed to open file", LF, NULL
fileOpenErrorLength     dq      21

fileReadError           db      "Failed to read file", LF, NULL
fileReadErrorLength     dq      21

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section     .bss

read_buffer       resb      BUFFER_SIZE+2
read_size         resq      1    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section     .text

global _start
_start:
    
    mov     r12, qword [rsp]        ; argc
    lea     r13, byte [rsp+8]      ; argv

    cmp     r12, 2
    jne     argumentError

    mov     rdi, qword [r13+8]
    lea     rsi, byte [read_buffer]
    mov     rdx, BUFFER_SIZE
    lea     rcx, qword [read_size]
    call    fileRead

    cmp     rax, 0
    jne     readError

    mov     rax, SYS_write
    mov     rdi, STDOUT
    lea     rsi, byte [read_buffer]
    mov     rdx, qword [read_size]
    syscall

    jmp     exitSuccess

argumentError:
    mov     rax, SYS_write
    mov     rdi, STDOUT
    mov     rsi, argCountError
    mov     rdx, qword [argCountErrorLength]
    syscall

    jmp     exitFailure

readError:
    cmp     rax, 1
    je      openError

    mov     rax, SYS_write
    mov     rdi, STDOUT
    mov     rsi, fileReadError
    mov     rdx, qword [fileReadErrorLength]
    syscall
    
    jmp     exitFailure

openError:
    mov     rax, SYS_write
    mov     rdi, STDOUT
    mov     rsi, fileOpenError
    mov     rdx, qword [fileOpenErrorLength]
    syscall
    
    jmp     exitFailure

exitSuccess:
    mov     rdi, EXIT_SUCCESS
    jmp     programExit

exitFailure:
    mov     rdi, EXIT_FAILURE

programExit:
    mov     rax, SYS_exit
    syscall

; fileRead(file_name, read_buffer, buffer_size, read_size)
; Arguments:
;   rdi - address, file name
;   rsi - address, read buffer
;   rdx - value, buffer size
;   rcx - address, read size
; Returns:
;   0 - success
;   1 - open error
;   2 - read error

global fileRead
fileRead:
    push    r12
    push    r13
    push    r14
    push    r15

    mov     r12, rsi            ; Save read buffer address
    mov     r13, rdx            ; Save buffer size
    mov     r14, rcx            ; Save address of output read size

    mov     rax, SYS_open       ; Open file
    mov     rsi, O_RDONLY
    syscall

    cmp     rax, 0
    jl      fopenError

    mov     r15, rax            ; Save file descriptor

    mov     rax, SYS_read       ; Read from file
    mov     rdi, r15
    mov     rsi, r12
    mov     rdx, r13
    dec     rdx
    syscall

    cmp     rax, 0
    jl      freadError

    mov     qword [r14], rax    ; Save length of read string

    mov     rax, SYS_close      ; Close file
    mov     rdi, r15
    syscall
   
    mov     rax, 0
    jmp     exitFunction

fopenError:
    mov     rax, 1
    jmp     exitFunction

freadError:
    mov     rax, 2
    jmp     exitFunction

exitFunction:
    pop    r15
    pop    r14
    pop    r13
    pop    r12
    ret

