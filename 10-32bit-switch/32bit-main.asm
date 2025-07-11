;
; Bootsector that enters 32bit protected mode
;

[org 0x7c00]

  mov bp, 0x9000 ; set stack
  mov sp, bp

  mov bx, MSG_REAL_MODE
  call print_string
  ;mov bx, MSG_DEBUG
  call switch_to_prot_mode
  
  ;mov bx, MSG_DEBUG ; is not ran
  ;call print_string
  jmp $ ; shouldn't be executed

%include "../05-bootsector-functions-strings/q5/print_string.asm"
%include "../08-32bit-print/32bit-print.asm"
%include "../09-32bit-gdt/32bit-gdt.asm"
%include "32bit-switch.asm"

[bits 32]

BEGIN_PROT_MODE: ; prints in top left corner
  mov ebx, MSG_PROT_MODE
  call print_string_pm
  jmp $

MSG_REAL_MODE db "started in 16 bit real mode", 0 
MSG_PROT_MODE db "Successfully landed in 32 bit protected mode", 0 

MSG_DEBUG db "DEB", 0
times 510-($-$$) db 0 
dw 0xaa55
  
