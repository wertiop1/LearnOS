
[extern isr_handler]

isr_common_stub:
  
  ; 1. Save CPU state
  pusha
  mov ax, ds; lower 16 bits of eax <- ds  
  push eax ; save ds
  mov ax, 0x10 ; load the kernel data segment sector
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  ; 2. call isr_handler 
  call isr_handler

  ; 3. reload CPU state 
  pop eax ; reload original data segment descriptor
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  popa 
  add esp, 8 ; cleans the pushed error code and pushed ISR number
  sti
  iret ; pops CS, EIP, EFLAGS, SS, and ESP 


; Setup the ISRs 

global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

; 0: Divide by Zero
isr0:
  cli
  push byte 0 
  push byte 0 
  jmp isr_common_stub

; 1: Debug Exception
isr1:
  cli
  push byte 0 
  push byte 1 
  jmp isr_common_stub

; 2: Non Maskable Interrupt Exception
isr2:
  cli
  push byte 0
  push byte 2
  jmp isr_common_stub

; 3: Int 3 Exception
isr3:
  cli
  push byte 0
  push byte 3
  jmp isr_common_stub

; 4: INTO Exception
isr4:
  cli
  push byte 0
  push byte 4
  jmp isr_common_stub

; 5: Out of Bounds Exception
isr5:
  cli
  push byte 0
  push byte 5
  jmp isr_common_stub

; `6: Invalid Opcode Exception
isr6:
  cli
  push byte 0
  push byte 6
  jmp isr_common_stub

; 7: Coprocessor Not Available Exception
isr7:
  cli
  push byte 0
  push byte 7
  jmp isr_common_stub

; 8: Double Fault Exception (With Error Code!)
isr8:
  cli
  push byte 0
  push byte 8
  jmp isr_common_stub

; 9: Coprocessor Segment Overrun Exception
isr9:
  cli
  push byte 0
  push byte 9
  jmp isr_common_stub

; 10: Bad TSS Exception (With Error Code!)
isr10:
  cli
  push byte 10
  jmp isr_common_stub

; 11: Segment Not Present Exception (With Error Code!)
isr11:
  cli
  push byte 11
  jmp isr_common_stub

; 12: Stack Fault Exception (With Error Code!)
isr12:
  cli
  push byte 12
  jmp isr_common_stub

; 13: General Protection Fault Exception (With Error Code!)
isr13:
  cli
  push byte 13
  jmp isr_common_stub

; 14: Page Fault Exception (With Error Code!)
isr14:
  cli
  push byte 14
  jmp isr_common_stub

; 15: Reserved Exception
isr15:
  cli
  push byte 0
  push byte 15
  jmp isr_common_stub

; 16: Floating Point Exception
isr16:
  cli
  push byte 0
  push byte 16
  jmp isr_common_stub

; 17: Alignment Check Exception
isr17:
  cli
  push byte 0
  push byte 17
  jmp isr_common_stub

; 18: Machine Check Exception
isr18:
  cli
  push byte 0
  push byte 18
  jmp isr_common_stub

; 19: Reserved
isr19:
  cli
  push byte 0
  push byte 19
  jmp isr_common_stub

; 20: Reserved
isr20:
  cli
  push byte 0
  push byte 20
  jmp isr_common_stub

; 21: Reserved
isr21:
  cli
  push byte 0
  push byte 21
  jmp isr_common_stub

; 22: Reserved
isr22:
  cli
  push byte 0
  push byte 22
  jmp isr_common_stub

; 23: Reserved
isr23:
  cli
  push byte 0
  push byte 23
  jmp isr_common_stub

; 24: Reserved
isr24:
  cli
  push byte 0
  push byte 24
  jmp isr_common_stub

; 25: Reserved
isr25:
  cli
  push byte 0
  push byte 25
  jmp isr_common_stub

; 26: Reserved
isr26:
  cli
  push byte 0
  push byte 26
  jmp isr_common_stub

; 27: Reserved
isr27:
  cli
  push byte 0
  push byte 27
  jmp isr_common_stub

; 28: Reserved
isr28:
  cli
  push byte 0
  push byte 28
  jmp isr_common_stub

; 29: Reserved
isr29:
  cli
  push byte 0
  push byte 29
  jmp isr_common_stub

; 30: Reserved
isr30:
  cli
  push byte 0
  push byte 30
  jmp isr_common_stub

; 31: Reserved
isr31:
  cli
  push byte 0
  push byte 31
  jmp isr_common_stub
