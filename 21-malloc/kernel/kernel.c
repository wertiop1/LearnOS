#include "kernel.h"
#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "../libc/mem.h"
#include "../libc/string.h"

void main() {
  clear_screen();
  isr_install();
  irq_install();

  kprint("Type END to halt, CLEAR to clear screen, or PAGE to request a kernel "
         "memory allocation.\n>");
}

void user_input(char *input) {
  if (strcmp(input, "END") == 0) {
    kprint("Ending\n");
    asm volatile("hlt");
  } else if (strcmp(input, "PAGE") == 0) {
    // test kmalloc
    //
    u32 phys_addr;
    u32 page = kmalloc(1000, 1, &phys_addr);
    char page_str[16] = "";
    hex_to_ascii(page, page_str);
    char phys_str[16] = "";
    hex_to_ascii(phys_addr, phys_str);
    kprint("Page: ");
    kprint(page_str);
    kprint(", Physical Address: ");
    kprint(phys_str);
    kprint("\n");
  } else if (strcmp(input, "CLEAR") == 0) {
    clear_screen();
    kprint("\n>");
  }
  kprint("You said: ");
  kprint(input);
  kprint("\n>");
}
