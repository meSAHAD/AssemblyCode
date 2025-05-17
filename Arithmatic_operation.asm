.model small
.stack 100h
.data
    num1 dw 10
    num2 dw 5
    result dw 0

    msgAdd     db 'Addition result: $'
    msgSub     db 13,10,'Subtraction result: $'
    msgMul     db 13,10,'Multiplication result: $'
    msgDiv     db 13,10,'Division result: $'

    buffer db 6 dup(0) ; buffer to hold converted number + '$'

.code
start:
    mov ax, @data
    mov ds, ax

    ; --- Addition ---
    mov ax, num1
    add ax, num2
    mov result, ax
    lea dx, msgAdd
    call PrintString
    mov ax, result
    call PrintNumber

    ; --- Subtraction ---
    mov ax, num1
    sub ax, num2
    mov result, ax
    lea dx, msgSub
    call PrintString
    mov ax, result
    call PrintNumber

    ; --- Multiplication ---
    mov ax, num1
    mov bx, num2
    mul bx            ; DX:AX = AX * BX
    mov result, ax
    lea dx, msgMul
    call PrintString
    mov ax, result
    call PrintNumber

    ; --- Division ---
    mov ax, num1
    cwd               ; extend AX to DX:AX for division
    mov bx, num2
    div bx            ; AX = quotient
    mov result, ax
    lea dx, msgDiv
    call PrintString
    mov ax, result
    call PrintNumber

    ; Exit program
    mov ax, 4c00h
    int 21h

;--------------------------------------------------------
; PrintString: prints a '$' terminated string at DS:DX
PrintString proc
    mov ah, 09h
    int 21h
    ret
PrintString endp

;--------------------------------------------------------
; PrintNumber: converts AX to decimal string and prints it
PrintNumber proc
    mov bx, 10          ; divisor
    lea di, buffer+5    ; buffer end
    mov byte ptr [di], '$'
    dec di

    cmp ax, 0
    jne PrintNumber_loop
    mov byte ptr [di], '0'
    dec di
    jmp PrintNumber_done

PrintNumber_loop:
    xor dx, dx
    div bx
    add dl, '0'
    mov [di], dl
    dec di
    cmp ax, 0
    jne PrintNumber_loop

PrintNumber_done:
    inc di
    mov dx, di
    call PrintString
    ret
PrintNumber endp

end start
