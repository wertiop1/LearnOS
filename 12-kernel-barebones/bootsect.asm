;
; Bootsector that enters 32bit protected mode
; Modification of the bootsector in 10
;

[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; the offset used to link the kernel 
  
  mov [BOOT_DRIVE], dl ; BIOS stores boot drive in dl, in case dl gets overwritten

  ;stack setup
  ;mov bp, 0x9000
  mov sp, 0x9000 ;bp is never used and you can set sp directly, no point in setting bp  

  ;Announce 16 bit boot 
  mov bx, MSG_REAL_MODE 
  call print_string 
  call print_newline

  ; read kernel 
  call load_kernel

  ; disable interrupts, load gdt, jump to BEGIN_PROT_MODE
  call switch_to_prot_mode

  jmp $



%include "../07-bootsector-disk/disk.asm"
%include "../05-bootsector-functions-strings/q5/print_string.asm"
%include "../05-bootsector-functions-strings/q5/print_hex.asm"
%include "../08-32bit-print/32bit-print.asm"
%include "../09-32bit-gdt/32bit-gdt.asm"
%include "../10-32bit-switch/32bit-switch.asm"

[bits 16]
load_kernel:
  mov bx, MSG_LOAD_KERNEL
  call print_string

  mov bx, KERNEL_OFFSET ; 
  mov dh, 15 ; read the first 15 sectors
  mov dl, [BOOT_DRIVE]
  call disk_load

  ret

[bits 32]

BEGIN_PROT_MODE: ; prints in top left corner
  mov ebx, MSG_PROT_MODE
  call print_string_pm
  
  call KERNEL_OFFSET

  jmp $

BOOT_DRIVE db 0 
MSG_REAL_MODE db "started in 16 bit real mode", 0
MSG_PROT_MODE db "Successfully landed in 32 bit protected mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

;MSG_DEBUG db "DEB", 0
times 510-($-$$) db 0
dw 0xaa55
