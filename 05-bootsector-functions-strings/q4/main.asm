;
; A boot sector that prints a string using a function
;
[org 0x7c00] ; Define offset

mov bx, HELLO_MSG; Move HELLO_MSG into bx
call print_string; run print function

call print_space

;call print_newline; run print nl function


mov bx, GOODBYE_MSG
call print_string
;Goodbye location is wierd

jmp $; hang

%include "print_string.asm"; include other file as written


; data
HELLO_MSG:
  db 'Hello, World!', 0 

GOODBYE_MSG:
  db 'Goodbye!', 0 


;fin
times 510-($-$$) db 0 
dw 0xaa55


