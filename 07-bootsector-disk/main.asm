[org 0x7c00]

mov [BOOT_DRIVE], dl ; boot drive is stored in DL

mov bp, 0x8000 ;Stack setup
mov sp, bp

mov bx, 0x9000
mov dh, 5
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]
call print_hex

mov dx, [0x9000+512]
call print_hex

jmp $


;%include "disk.asm"
%include "../05-bootsector-functions-strings/q5/print_string.asm"
%include "../05-bootsector-functions-strings/q5/print_hex.asm"
%include "disk.asm"

BOOT_DRIVE:
  db 0 

times 510-($-$$) db 0 
dw 0xaa55


;
; 
;


;At least an extra 1025 bytes because we're reading two segments, otherwise fails
times 1025 dw 0xdaad
;times 256 dw 0xdada
;times 256 dw 0xface
