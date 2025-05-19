.model small
.stack 100h
.data
    num db 39               
    msg_even db 'The number is even$'
    msg_odd  db 'The number is odd$'
.code
start:
    mov ax, @data
    mov ds, ax
    mov al, num              
    and al, 1                
    jz even_case             
odd_case:
    mov dx, offset msg_odd
    call print_msg
    jmp exit
even_case:
    mov dx, offset msg_even
    call print_msg
    jmp exit
print_msg:
    mov ah, 9
    int 21h
    ret
exit:
    mov ah, 4Ch
    int 21h
end start
