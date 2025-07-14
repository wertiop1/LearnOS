print_string:
  pusha
  mov ah, 0x0e
  ; Below is already taken care of :
  ;   print_string moves to loop_print automatically, which jumps to fin which returns
  ;call loop_print
  ;ret

loop_print:  
  mov al, [bx]
  cmp al, 0
  je fin

  int 0x10
  ;forgot to progress forward LMAO

  add bx, 1
  jmp loop_print
  
fin:
  popa
  ret

print_space:
  pusha
  mov ah, 0x0e
  mov al, ' '
  int 0x10
  popa
  ret

print_newline:
  pusha
  mov ah, 0x0e
  mov al, 0x0a
  int 0x10
  popa
  ret
