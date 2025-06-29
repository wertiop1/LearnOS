mov ah, 0x0e

;control
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

;a1
mov al, [the_secret]
int 0x10

;a2
mov bx, 0x7c0; ds cannot be set with a value directly
mov ds, bx
mov al, [the_secret]
int 0x10

;a3
mov al, [es:the_secret]; use the es segment
int 0x10

mov bx, 0x7c0
mov es, bx
mov al, [es: the_secret]
int 0x10

jmp $

the_secret:
  db "X"

times 510-($-$$) db 0 
dw 0xaa55

