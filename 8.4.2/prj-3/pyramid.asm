;  Example assembly language program to calculate the
;  geometric information for each square pyramid in
;  a series of square pyramids.
;  The program calculates the total surface area
;  and volume of each square pyramid.
;  Once the values are computed, the program finds
;  the minimum, maximum, sum, and average for the
;  total surface areas and volumes.

; -----
;  Formulas:
;   totalSurfaceAreas(n) = aSides(n) * (2*aSides(n)*sSides(n))
;   volumes(n) = (aSides(n)^2 * heights(n)) / 3

; *************************************************

section .data

; -----
;  Define constants

EXIT_SUCCESS    equ     0       ; successful operation
SYS_exit        equ     60      ; call code for terminate

; -----
;  Provided Data

aSides      db     10,    14,    13,    37,    54
            db     31,    13,    20,    61,    36
            db     14,    53,    44,    19,    42
            db     27,    41,    53,    62,    10
            db     19,    18,    14,    10,    15
            db     15,    11,    22,    33,    70
            db     15,    23,    15,    63,    26
            db     24,    33,    10,    61,    15
            db     14,    34,    13,    71,    81
            db     38,    13,    29,    17,    93

sSides      dw   1233,  1114,  1773,  1131,  1675
            dw   1164,  1973,  1974,  1123,  1156
            dw   1344,  1752,  1973,  1142,  1456
            dw   1165,  1754,  1273,  1175,  1546
            dw   1153,  1673,  1453,  1567,  1535
            dw   1144,  1579,  1764,  1567,  1334
            dw   1456,  1563,  1564,  1753,  1165
            dw   1646,  1862,  1457,  1167,  1534
            dw   1867,  1864,  1757,  1755,  1453
            dw   1863,  1673,  1275,  1756,  1353

heights     dd  14145, 11134, 15123, 15123, 14123
            dd  18454, 15454, 12156, 12164, 12542
            dd  18453, 18453, 11184, 15142, 12354
            dd  14564, 14134, 12156, 12344, 13142
            dd  11153, 18543, 17156, 12352, 15434
            dd  18455, 14134, 12123, 15324, 13453
            dd  11134, 14134, 15156, 15234, 17142
            dd  19567, 14134, 12134, 17546, 16123
            dd  11134, 14134, 14576, 15457, 17142
            dd  13153, 11153, 12184, 14142, 17134

length		dd	50

taMin		dd	0
taMax		dd	0
taSum		dd	0
taAve		dd	0

volMin		dd	0
volMax		dd	0
volSum		dd	0
volAve		dd	0

; -----
; Additional variables

ddTwo       dd  2
ddThree     dd  3

; -------------------------------------------------
; Uninitialized data

section .bss
totalAreas      resd    50
volumes         resd    50

; *************************************************

section .text
global _start
_start:

;  Calculate volume, lateral and total surface areas

    mov ecx, dword [length]         ; length counter
    mov rsi, 0                      ; index

calculationLoop:

; totalAreas(n) = aSides(n) * (2*aSides(n)*sSides(n))

    movzx r8d, byte [aSides+rsi]        ; aSides[i]
    movzx r9d, word [sSides+rsi*2]      ; sSides[i]
    mov eax, r8d
    mul dword [ddTwo]
    mul r9d
    mul r8d
    mov dword [totalAreas+rsi*4], eax

; volumes(n) = (aSides(n)^2 * heights(n)) / 3

    movzx eax, byte [aSides+rsi]
    mul eax
    mul dword [heights+rsi*4]
    div dword [ddThree]
    mov dword [volumes+rsi*4], eax
    inc rsi
    loop calculationLoop

; -----
;  Find min, max, sum, and average for the total
;  areas and volumes.

    mov eax, dword [totalAreas]
    mov dword [taMin], eax
    mov dword [taMax], eax
    mov eax, dword [volumes]
    mov dword [volMin], eax
    mov dword [volMax], eax
    mov dword [taSum], 0
    mov dword [volSum], 0
    mov ecx, dword [length]
    mov rsi, 0

statsLoop:
    mov eax, dword [totalAreas+rsi*4]
    add dword [taSum], eax
    cmp eax, dword [taMin]
    jae notNewTaMin
    mov dword [taMin], eax

notNewTaMin:
    cmp eax, dword [taMax]
    jbe notNewTaMax
    mov dword [taMax], eax

notNewTaMax:
    mov eax, dword [volumes+rsi*4]
    add dword [volSum], eax
    cmp eax, dword [volMin]
    jae notNewVolMin
    mov dword [volMin], eax

notNewVolMin:
    cmp eax, dword [volMax]
    jbe notNewVolMax
    mov dword [volMax], eax

notNewVolMax:
    inc rsi
    loop statsLoop

; -----
;  Calculate averages.

    mov eax, dword [taSum]
    mov edx, 0
    div dword [length]
    mov dword [taAve], eax
    mov eax, dword [volSum]
    mov edx, 0
    div dword [length]
    mov dword [volAve], eax

; -----
;  Done, terminate program.

last:
    mov rax, SYS_exit           ; call code for exit
    mov rdi, EXIT_SUCCESS       ; exit with success
    syscall

