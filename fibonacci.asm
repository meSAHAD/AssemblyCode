.model small
.stack 100h
.data
    fib1 dw 0
    fib2 dw 1
    fib3 dw ?
    count db 6
    space db ' $'     ; space character
.code
start:
    mov ax, @data
    mov ds, ax

    ; Print first Fibonacci number (fib1 = 0)
    mov ax, fib1
    call print_number
    call print_space

    ; Print second Fibonacci number (fib2 = 1)
    mov ax, fib2
    call print_number
    call print_space

    mov cx, 4          ; already printed 2 numbers, 4 remaining

fib_loop:
    mov ax, fib1
    add ax, fib2       ; ax = fib1 + fib2
    mov fib3, ax       ; store result

    call print_number
    call print_space

    ; shift numbers
    mov ax, fib2
    mov fib1, ax

    mov ax, fib3
    mov fib2, ax

    loop fib_loop

    ; Exit to DOS
    mov ah, 4Ch
    int 21h

; ---------------------
; Prints number in AX
; ---------------------
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

; ---------------------
; Print a space
; ---------------------
print_space:
    mov ah, 9
    lea dx, space
    int 21h
    ret

end start
