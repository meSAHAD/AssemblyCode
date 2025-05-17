.model small
.stack 100h

.data
    msg db 'Sum is: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Print message
    lea dx, msg
    mov ah, 9
    int 21h

    mov cx, 5       ; N = 5
    xor ax, ax      ; sum = 0

sum_loop:
    add ax, cx
    loop sum_loop

    ; Result is in AX = 15
    ; Now print AX (i.e., 15)
    call print_num

    ; Exit
    mov ah, 4ch
    int 21h
main endp

;-----------------------------
; Print AX as decimal
;-----------------------------
print_num proc
    xor ah, ah
    mov cx, 0
    mov bx, 10

next_digit:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne next_digit

print_loop:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop print_loop
    ret
print_num endp

end main
