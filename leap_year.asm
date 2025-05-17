.model small
.stack 100h

.data
leap_msg db 'Leap Year$'
notleap_msg db 'Not Leap Year$'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, 2024      ; Load the year into AX
    mov bl, 4         ; Divisor = 4
    xor ah, ah        ; Clear AH before division
    div bl            ; AX / BL ? Quotient in AL, Remainder in AH

    cmp ah, 0         ; Check remainder
    jne not_leap      ; If remainder ? 0, it's not a leap year
    lea dx, leap_msg  ; Load leap year message
    jmp print_result

not_leap:
    lea dx, notleap_msg  ; Load not leap year message

print_result:
    mov ah, 09h       ; DOS print function
    int 21h

    mov ah, 4Ch       ; Exit program
    int 21h
main endp
end main
