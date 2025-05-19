.model small
.stack 100h
.data
fib1 dw 0
fib2 dw 1
fib3 dw ?
space db ' $'
.code
start:
    mov ax, @data
    mov ds, ax
    mov ax, fib1
    call print_number
    call print_space
    mov ax, fib2
    call print_number
    call print_space
    mov cx, 5
fib_loop:
    mov ax, fib1
    add ax, fib2
    mov fib3, ax
    call print_number
    call print_space
    mov ax, fib2
    mov fib1, ax
    mov ax, fib3
    mov fib2, ax
    loop fib_loop
    mov ah, 4Ch
    int 21h
print_number:
    push ax
    push bx
    push cx
    push dx
    mov cx, 0
    mov bx, 10
.next_digit:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne .next_digit
.print_digits:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop .print_digits
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_space:
    mov ah, 9
    lea dx, space
    int 21h
    ret
end start