mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; (base pointer) A bit above 0x7c00 (BIOS)
mov sp, bp ; (stack pointer = base pointer)

push 'A'
push 'B'
push 'C'

; STACK:
; C: 0x7ffa 
; B: 0x7ffc
; A: 0x7ffe 
; bp: 0x8000

mov al, [0x7ffe]; 0x8000 - 2 : A
int 0x10

mov al, [0x7ffc]; 0x8000 - 4 : B
int 0x10

mov al, [0x7ffa]; 0x8000 - 6 : C
int 0x10

mov al, [0x8000]
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

;mov al, [0x7ffe]
;int 0x10

mov al, [0x8000]
int 0x10

jmp $

;
; Fin. 
;

times 510-($-$$) db 0 
dw 0xaa55
