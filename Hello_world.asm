.model small           ; Define small memory model
.stack 100h            ; Allocate 256 bytes for stack

.data
msg db 'Hello, World$' ; Define the message to print, '$' marks the end

.code
main proc
    mov ax, @data      ; Load address of data segment into AX
    mov ds, ax         ; Move AX into DS to access variables

    mov ah, 09h        ; DOS function to display string
    lea dx, msg        ; Load address of the message into DX
    int 21h            ; Call interrupt 21h to print the string

    mov ah, 4Ch        ; DOS function to exit program
    int 21h            ; Call interrupt to terminate program
main endp
end main               ; End of the program
