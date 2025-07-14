[bits 16]
switch_to_prot_mode:
  cli ; clear interrupts

  lgdt [gdt_descriptor] ; lead global descriptor table

  ; https://wiki.osdev.org/CPU_Registers_x86#cr0
  ; https://en.wikipedia.org/wiki/Control_register

  mov eax, cr0 ; 
  or eax, 0x1 ; set 32 bit protected mode 
  mov cr0, eax ;

  jmp CODE_SEG:init_prot_mode

[bits 32]
init_prot_mode:

  mov ax, DATA_SEG; set all segments
  mov es, ax
  mov ss, ax
  mov ds, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x9000 ; Set stack position at the top of the free space
  mov esp, ebp;

  call BEGIN_PROT_MODE



