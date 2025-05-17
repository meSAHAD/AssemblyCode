.model small
.stack 100h

.data
    msg db 'Fahrenheit: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Print the message
    lea dx, msg
    mov ah, 9
    int 21h

    ; Celsius to Fahrenheit: (C * 9 / 5) + 32
    mov al, 20        ; Celsius = 20
    mov bl, 9
    mul bl            ; AX = 20 * 9 = 180

    mov bl, 5
    div bl            ; AX = 180 / 5 = 36, result in AL

    add al, 32        ; AL = 36 + 32 = 68

    ; Show result in AL
    call print_num

    ; Exit
    mov ah, 4ch
    int 21h
main endp

;-----------------------------
; Procedure to Print AL as Decimal
;-----------------------------
print_num proc
    xor ah, ah        ; AX = AL
    mov cx, 0
    mov bx, 10

next_digit:
    xor dx, dx
    div bx            ; AX ÷ 10
    push dx           ; Store remainder
    inc cx
    cmp ax, 0
    jne next_digit

print_loop:
    pop dx
    add dl, '0'       ; Convert to ASCII
    mov ah, 2
    mov dl, dl
    int 21h
    loop print_loop
    ret
print_num endp

end main
