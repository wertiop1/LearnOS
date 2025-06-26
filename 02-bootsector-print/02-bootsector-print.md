# 02 Bootsector Print

    mov ah, 0x0e

TTY mode

    mov al, 'H'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'l'
    int 0x10
    int 0x10
    mov al, 'o'
    int 0x10

    mov al, ','
    int 0x10
    mov al, ' '
    int 0x10

    mov al, 'W'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, 'r'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 'd'
    int 0x10

    mov al, '!'
    int 0x10

Print "Hello, World!", int 0x10 invokes screen-related ISR

    times 510-($-$$) db 0
    dw 0xaa55

Fin