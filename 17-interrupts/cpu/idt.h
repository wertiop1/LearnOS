#ifndef IDT_H
#define IDT_H

#include "types.h"

#define KERNEL_CS 0x08

// struct describing interrupt gate
typedef struct {
  u16 low_offset;  // lower 16 bits of the address
  u16 sel;         // kernel segment selector
  u8 always0;      // must always be 0
  u8 flags;        //
  u16 high_offset; // upper 16 bits of the address
} __attribute__((packed)) idt_gate_t;

// ptr to the array of interrupts
typedef struct {
  u16 limit;
  u32 base;
} __attribute__((packed)) idt_ptr_t;

#define IDT_ENTRIES 256
idt_gate_t idt[IDT_ENTRIES];
idt_ptr_t idt_ptr;

void set_idt_gate(int n, u32 handler);
void set_idt();

#endif
