;
; A bootsector that prints the hex value
;
[org 0x7c00]

mov dx, 0x1fb6
call print_hex 

jmp $

print_hex:
  pusha
  mov cx, 0
  ;mov ah, 0x0e; ax is required since dx is too large

print_loop:
  add cx, 1 
  cmp cx, 4; hex addr is 4 numbers long
  je fin

  mov ax, dx; ax required
  and ax, 0x000f; bitmask to remove first 3 digits


  int 0x10

  add bp, 1 
  jmp print_loop
  
fin:
  popa
  ret 


; mov bx, HEX_OUT
;call print_string
;ret


;HEX_OUT: 
;  db '0x0000', 0 

times 510-($-$$) db 0 
dw 0xaa55
