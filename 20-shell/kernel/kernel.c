#include "kernel.h"
#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "../libc/string.h"

void main() {
  clear_screen();
  isr_install();
  irq_install();

  kprint("Type END to halt.\n>");
}

void user_input(char *input) {
  if (strcmp(input, "END") == 0) {
    kprint("Ending\n");
    asm volatile("hlt");
  }
  kprint("You said: ");
  kprint(input);
  kprint("\n>");
}
