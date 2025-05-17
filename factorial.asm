.model small
.stack 100h

.data
.code

main proc
    mov ax, @data
    mov ds, ax

    mov cx, 5        ; Number to find factorial of
    mov ax, 1        ; Result starts from 1

fact_loop:
    mul cx           ; AX = AX * CX
    loop fact_loop   ; Decrement CX and repeat if not zero

    ; Now AX has factorial of 5 (120)

    ; Print AX in decimal
    call print_decimal_16

    ; print newline
    mov dl, 0Dh
    mov ah, 02h
    int 21h
    mov dl, 0Ah
    int 21h

    mov ah, 4Ch
    int 21h

;-----------------------------------------
; Print 16-bit number in AX as decimal
;-----------------------------------------
print_decimal_16 proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 0         ; digit count
    mov bx, 10        ; divisor

    mov bx, 10
    mov dx, 0

    ; Use AX as number to print
    mov bx, 10

divide_loop_16:
    xor dx, dx
    div bx            ; divide DX:AX by 10, quotient in AX, remainder in DX
    push dx           ; remainder (digit)
    inc cx
    cmp ax, 0
    jne divide_loop_16

print_digits_16:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_digits_16

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_decimal_16 endp


end main
