.model small
.stack 100h
.data
    num1 db 45         ; Change this value
    num2 db 23         ; Change this value

    max_msg db 'maximum num = $'
    min_msg db 'minimum num = $'
    newline db 13, 10, '$'  ; carriage return + line feed

.code
start:
    mov ax, @data
    mov ds, ax

    ; Load the numbers
    mov al, num1
    mov bl, num2

    ; Compare numbers
    cmp al, bl
    ja first_is_max
    jb second_is_max

    ; Equal case
    ; Print max
    mov dx, offset max_msg
    call print_msg
    mov al, num1
    call print_number
    call new_line

    ; Print min
    mov dx, offset min_msg
    call print_msg
    mov al, num1
    call print_number
    call new_line
    jmp exit

first_is_max:
    ; max = num1, min = num2
    mov dx, offset max_msg
    call print_msg
    mov al, num1
    call print_number
    call new_line

    mov dx, offset min_msg
    call print_msg
    mov al, num2
    call print_number
    call new_line
    jmp exit

second_is_max:
    ; max = num2, min = num1
    mov dx, offset max_msg
    call print_msg
    mov al, num2
    call print_number
    call new_line

    mov dx, offset min_msg
    call print_msg
    mov al, num1
    call print_number
    call new_line
    jmp exit

; --------- Subroutines ---------

print_msg:
    mov ah, 9
    int 21h
    ret

print_number:
    ; Prints value in AL as decimal (0–255)
    aam
    add ax, 3030h       ; convert both digits to ASCII
    mov dl, ah
    mov ah, 2
    int 21h
    mov dl, al
    int 21h
    ret

new_line:
    mov dx, offset newline
    call print_msg
    ret

exit:
    mov ah, 4ch
    int 21h

end start
