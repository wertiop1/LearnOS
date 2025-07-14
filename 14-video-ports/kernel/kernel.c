#include "../drivers/ports.h"

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

#define WHITE_ON_BLACK 0x0f

#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

void main() {
  port_byte_out(REG_SCREEN_CTRL, 14);

  int pos = port_byte_in(REG_SCREEN_DATA);
  pos = pos << 8;

  port_byte_out(REG_SCREEN_CTRL, 15);
  pos += port_byte_in(REG_SCREEN_DATA);

  int offset_from_vga = pos * 2;

  char *vga = (char *)VIDEO_ADDRESS;
  vga[offset_from_vga] = 'X';
  vga[offset_from_vga + 1] = WHITE_ON_BLACK;
}
