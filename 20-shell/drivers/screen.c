#include "screen.h"
#include "../cpu/ports.h"
#include "../libc/mem.h"

/* Private Functions */
int get_cursor_offset();
void set_cursor_offset(int offset);
int print_char(char c, int col, int row, char attr);
int get_offset(int col, int row);
int get_offset_row(int offset);
int get_offset_col(int offset);

/* PUBLIC API FUNCTIONS */

/*       Print Message at the specified location   */
/* If col and row are negative use the current offset */
void kprint_at(char *message, int col, int row) {

  // set cursor if its offscreen
  int offset;
  if (col >= 0 && row >= 0) {
    offset = get_cursor_offset();
  } else {
    offset = get_cursor_offset();
    row = get_offset_row(offset);
    col = get_offset_col(offset);
  }
  // set attribute

  /* work on later
  if (!attr) {
    attr = WHITE_ON_BLACK;
  }*/

  /* loop through message and print */
  int i = 0;
  while (message[i] != 0) {
    offset = print_char(message[i], col, row, WHITE_ON_BLACK);

    // set row and col for next iteration
    row = get_offset_row(offset);
    col = get_offset_col(offset);

    ++i; // increment
  }
}

// essentially a wrapper for kprint_at
void kprint(char *message) { kprint_at(message, -1, -1); }

// print backspace

void kprint_backspace() {
  int offset = get_cursor_offset() - 2;
  int row = get_offset_row(row);
  int col = get_offset_col(col);
  print_char(0x08, col, row, WHITE_ON_BLACK);
}

/* PRIVATE FUNCTIONS */

int print_char(char c, int col, int row, char attr) {
  // print character at location

  u8 *vidmem = (u8 *)VIDEO_ADDRESS;

  if (!attr)
    attr = WHITE_ON_BLACK;
  // set text attribute to be WHITE_ON_BLACK if not set

  if (col >= MAX_COLS || row >= MAX_ROWS) { // if the col or row is outside the
                                            // vga screen, print an "E error"
    vidmem[2 * (MAX_COLS) * (MAX_ROWS)-2] = 'E';
    vidmem[2 * (MAX_COLS) * (MAX_ROWS)-1] = RED_ON_WHITE;
    // kprint("ERROR");
    return get_offset(col, row);
  }

  int offset;
  if (col >= 0 && row >= 0)
    offset = get_offset(col, row); // If col and row are within the bounds of
                                   // the screen, use col and row
  else
    offset = get_cursor_offset(); // Otherwise use the cursor location

  if (c == '\n') {
    // new line
    row = get_offset_row(offset);
    offset = get_offset(0, row + 1);
  } else if (c == 0x08) {
    vidmem[offset] = ' ';
    vidmem[offset + 1] = attr;
  } else {
    vidmem[offset] = c;
    vidmem[offset + 1] = attr;
    offset += 2;
  }

  /* scroll if offset is below screen */
  if (offset > MAX_ROWS * MAX_COLS * 2) {
    for (int i = 1; i < MAX_ROWS; i++) {
      memory_copy((char *)(get_offset(0, i) + VIDEO_ADDRESS),
                  (char *)(get_offset(0, i - 1) + VIDEO_ADDRESS), MAX_COLS * 2);

      char *last_line = (char *)(get_offset(0, MAX_ROWS - 1) + VIDEO_ADDRESS);
      for (i = 0; i < MAX_COLS * 2; i++)
        last_line[i] = 0;
      offset -= 2 * MAX_COLS;
    }
  }

  set_cursor_offset(offset);
  return (offset);
}

int get_cursor_offset() {
  /* Use VGA ports to get cursor position */
  port_byte_out(REG_SCREEN_CTRL, 14);
  int offset = port_byte_in(REG_SCREEN_DATA) << 8; // highbyte so leftshift 8;
  port_byte_out(REG_SCREEN_CTRL, 15);
  offset += port_byte_in(REG_SCREEN_DATA);
  return offset * 2; /* position * size */
}

void set_cursor_offset(int offset) {
  /* Write the offset, with cursor location */

  offset /= 2;
  port_byte_out(REG_SCREEN_CTRL, 14);
  port_byte_out(REG_SCREEN_DATA,
                (unsigned char)(offset << 8)); // write high byte , leftshift 8
  port_byte_out(REG_SCREEN_CTRL, 15);
  port_byte_out(
      REG_SCREEN_DATA,
      (unsigned char)(offset & 0xff)); // write low byte , bitmask 0xff to leave
                                       // only last 8 values
}

void clear_screen() {
  int screen_size = MAX_COLS * MAX_ROWS;
  int i;
  char *screen = (char *)VIDEO_ADDRESS;

  for (i = 0; i < screen_size; ++i) {
    screen[i * 2] = ' ';
    screen[i * 2 + 1] = WHITE_ON_BLACK;
  }
  set_cursor_offset(get_offset(0, 0));
}

int get_offset(int col, int row) {
  return 2 * (row * MAX_COLS + col);
} // allow for get_offset_row and get_offset_col to reverse to find row and col
int get_offset_row(int offset) {
  return offset / (2 * MAX_COLS);
} // Int division allows this to work
int get_offset_col(int offset) {
  return (offset - (get_offset_row(offset) * 2 * MAX_COLS)) / 2;
}
