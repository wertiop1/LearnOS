; Useful reference:
; https://stanislavs.org/helppc/int_13.html

disk_load:
  pusha
  push dx 
  
  mov ah, 0x02 ; read disk sectors for interrupt 13 
  mov al, dh ; 
  mov ch, 0x00;
  mov dh, 0x00;
  mov cl, 0x02;

  int 0x13

  jc disk_error

  pop dx
  cmp dh, al
  jne sector_error 
  popa
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_string
  call print_newline
  mov dh, ah; https://stanislavs.org/helppc/int_13-1.html
  ;Without enough segments returns 0x0c80, 0x0c is error code, 0x80 is HDD
  call print_hex
  jmp $

sector_error:
  mov bx, SECTOR_ERROR_MSG
  call print_string
  jmp $

DISK_ERROR_MSG:
  db "Disk read error", 0

SECTOR_ERROR_MSG:
  db "Failed to read correct number of sectors", 0
