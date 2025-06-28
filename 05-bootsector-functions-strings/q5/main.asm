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

call print_newline

mov dx, 0x1fb6
call print_hex


jmp $; hang

;fn 
%include "print_string.asm"; include other file as written
;%include "print_hex.asm"

print_hex:
  pusha
  mov cx, 0; int i =0 

print_loop: 
  cmp cx, 4; while i < 4
  je fin2
  ;;add cx, 1 
  
  ; Relevant Ascii
  ; 0 - 30 
  ; 1 - 31 
  ; 2 - 32 
  ; 3 - 33 
  ; 4 - 34 
  ; 5 - 35 
  ; 6 - 36 
  ; 7 - 37 
  ; 8 - 38 
  ; 9 - 39 
  ; a - 61 
  ; b - 62
  ; c - 63
  ; d - 64
  ; e - 65
  ; f - 66
  mov ax, dx ; put dx into ax
  and ax, 0x000f ; (bitmask)take last digit of dx -> al is 0Y where Y is the value we wnat to print
  add al, 0x30 ; add 0x30 to make them numbers
  cmp al, 0x39 ; if al <= 0x39 than its a number and you dont need to add alphabetical offset 
  jle update_string
  ; 0x3a 0x3f
  ; a = 
  ; b =
  ; c = 
  ; d =
  ; e = 
  ; f = 
  ; g = 
  ; h = 

  add al, 39; lexicon offset 

update_string:
  mov bx, HEX_OUT + 5 ;
  sub bx, cx ;
  mov [bx], al ; 
  shr dx, 4 ; 0x1234->0x0123->0x0012->0x0001
  add cx, 1 ; i++
  jmp print_loop ; 


fin2:
  mov bx, HEX_OUT  
  call print_string
  popa
  ret

; data
HELLO_MSG:
  db 'Hello, World!', 0 

GOODBYE_MSG:
  db 'Goodbye!', 0 

HEX_OUT:
  db '0x0000', 0 

;fin
times 510-($-$$) db 0 
dw 0xaa55


