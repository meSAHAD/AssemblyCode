.model small
.stack 100h

.data
msg1 db 'Area of Rectangle: $'
msg2 db 'Area of Triangle: $'
msg3 db 'Area of Circle: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; -------- Rectangle Area (5*4 = 20) --------
    lea dx, msg1
    mov ah, 9
    int 21h

    mov al, 5
    mov bl, 4
    mul bl            ; AL = 20
    call print_num

    call newline

    ; -------- Triangle Area (1/2 * 6 * 4 = 12) --------
    lea dx, msg2
    mov ah, 9
    int 21h

    mov al, 6
    mov bl, 4
    mul bl            ; AL = 24
    mov bl, 2
    div bl            ; AL = 12
    call print_num

    call newline

    ; -------- Circle Area (p * r^2 ˜ 3 * 3^2 = 27) --------
    lea dx, msg3
    mov ah, 9
    int 21h

    mov al, 3         ; radius
    mov bl, al
    mul bl            ; AL = 9
    mov bl, 3
    mul bl            ; AL = 27
    call print_num

    ; -------- Exit --------
    mov ah, 4Ch
    int 21h
main endp

; -------- Procedure to Print AL as Decimal --------
print_num proc
    mov ah, 0
    mov cx, 0
    mov bx, 10
next:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne next

print_loop:
    pop dx
    add dl, 30h
    mov ah, 2
    int 21h
    loop print_loop
    ret
print_num endp

; -------- Procedure to Print New Line --------
newline proc
    mov ah, 2
    mov dl, 13     ; Carriage return
    int 21h
    mov dl, 10     ; Line feed
    int 21h
    ret
newline endp

end main
