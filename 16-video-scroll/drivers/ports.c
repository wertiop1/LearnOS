unsigned char
port_byte_in(unsigned short port) { // read a byte from the specified port

  unsigned char result; //
  // "=a" <- puts AL register into result
  // "d" <- load EDX with port
  __asm__("in %%dx, %%al" : "=a"(result) : "d"(port));
  return result;
}

void port_byte_out(unsigned short port,
                   unsigned char data) { // print a byte from the specified port
  __asm__("out %%al, %%dx" : : "a"(data), "d"(port));
  // "a" <- load EAX with data
  // "d" <- load EDX with port
}

unsigned short port_word_in(
    unsigned short port) { // read a short (16 bits) from the specified port
  unsigned short result;
  __asm__("in %%dx, %%ax" : "=a"(result) : "d"(port));
  return result;
}

void port_word_out(
    unsigned short port,
    unsigned short data) { // print a short from the specified port
  __asm__("out %%ax, %%dx" : : "a"(data), "d"(port));
}
