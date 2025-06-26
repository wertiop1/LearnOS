
mov bx, 60 ; bx = 60
cmp bx, 4 ; compare bx and 4
jle block1 ; if less than or equal to jump to block1
cmp bx, 40 ; compare bx and 40
jl block2 ; if less than jump to block2
mov al, 'C' ; al = C 
jmp the_end ; Jump to the_end

block1:
  mov al, 'A' ; al = A 

block2:
  mov al, 'B' ; al = B

the_end: ; empty

mov ah, 0x0e;
int 0x10; Print al

;
; Fin.
;

jmp $

times 510-($-$$) db 0
dw 0xaa55
