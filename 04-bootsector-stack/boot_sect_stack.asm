mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; distant from 0x7c00
mov sp, bp

push 'A'
push 'B'
push 'C'

mov al, [0x7ffe]; 0x8000 - 2
int 0x10

mov al, [0x8000]
int 0x10

pop bx
