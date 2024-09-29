; Based on the file read example, create a value returning fileRead()
; function to read a password from a file. The function should accept
; arguments for the address of file name, the address of where to store
; the password string, the maximum length of the password string,
; and the address of where to store the password length. The function
; should open the file, read a string representing a password, close
; the file, and return the number of characters in the password.
; The maximum length should include space for the NULL, which means
; the function read must not store more than the maximum minus one characters
; in the string. The function should return SUCCESS if the operations worked
; correctly or NOSUCCESS if there is a problem. Problems might include
; the file not existing or other read errors. Create an appropriate main
; to test the function.  Use the debugger as necessary to debug the program.
; When working correctly, execute the program from the command line which
; will display the final results to the console.

section     .data

; Constants

LF              equ     10          ; line feed
NULL            equ     0           ; end of string

SUCCESS         equ     0
NOSUCCESS       equ     1

SYS_read        equ		0		    ; write
SYS_write		equ		1		    ; write
SYS_open		equ		2			; file open
SYS_close		equ		3		    ; file close
SYS_fork		equ		57		    ; fork
SYS_exit		equ		60		    ; terminate
SYS_creat		equ		85          ; file open/create
SYS_time		equ		201         ; get time

O_CREAT		    equ		0x40
O_TRUNC		    equ		0x200
O_APPEND		equ		0x400

O_RDONLY		equ		000000q     ; read only
O_WRONLY		equ		000001q     ; write only
O_RDWR	    	equ		000002q     ; read and write

S_IRUSR			equ		00400q
S_IWUSR			equ		00200q
S_IXUSR			equ		00100q

STDIN           equ     0           ; standard input
STDOUT          equ     1           ; standard output
STDERR          equ     2           ; standard error

EXIT_SUCCESS    equ     0           ; success code

BUFFER_SIZE     equ     255

; Data.

fileName        db      "password", NULL


section     .bss

readBuffer      resb    BUFFER_SIZE
readLength      resq    1


section     .text

; fileRead(string, file)
; Arguments:
; 1) address, file name
; 2) address, output string
; 3) value, maximum length of the password string
; 4) address, where to store the password length
; Returns:
; SUCCESS - if succesful
; NOSUCCESS - if not able to create or write to file

global fileRead
fileRead:
    push    rbp
    mov     rbp, rsp
    push    r12
    push    r13
    push    r14
    push    r15

    mov     r12, rsi            ; Save output string address
    mov     r13, rdx            ; Save maximum length of password string
    mov     r14, rcx            ; Save address of output string length

    mov     rax, SYS_open       ; Open file
    mov     rdi, rdi
    mov     rsi, O_RDONLY
    syscall

    cmp     rax, 0
    jl      openError

    mov     r15, rax            ; Save file descriptor

    mov     rax, SYS_read       ; Read from file
    mov     rdi, r15
    mov     rsi, r12
    mov     rdx, r13
    dec     rdx
    syscall

    cmp     rax, 0
    jl      readError

    mov     qword [r14], rax    ; Save length of read string

    mov     rax, SYS_close      ; Close file
    mov     rdi, r15
    syscall
   
    mov     rax, SUCCESS
    jmp     readSuccess

openError:
readError:
    mov     rax, NOSUCCESS

readSuccess:

    pop    r15
    pop    r14
    pop    r13
    pop    r12
    pop    rbp
    ret

global _start
_start:

; Call function fileRead

    mov     rdi, fileName
    mov     rsi, readBuffer
    mov     rdx, BUFFER_SIZE
    lea     rcx, qword [readLength]
    call    fileRead

    mov     rax, SYS_write
    mov     rsi, readBuffer
    mov     rdi, STDOUT
    mov     rdx, qword [readLength]
    syscall

; -----
; Done, terminate program.

last:
    mov     rdi, rax
    mov     rax, SYS_exit
    syscall

