#include "../cpu/types.h"

void memory_copy(char *source, char *dest, int nbytes) {
  int i;
  for (i = 0; i < nbytes; i++) {
    *(dest + i) = *(source + i);
  }
}

void memory_set(u8 *dest, u8 val, u32 len) {
  u8 *temp = (u8 *)dest;
  for (; len != 0; len--)
    *temp++ = val;
}

int strlen_(char str[]) {
  int cnt = 0;
  while (str[cnt] != '\0')
    ++cnt;
  return cnt;
}

void reverse(char str[]) {
  int c, i, j;
  for (i = 0, j = strlen_(str) - 1; i < j; i++, j--) {
    c = str[i];
    str[i] = str[j];
    str[j] = c;
  }
}

void int_to_ascii(int n, char str[]) {
  int i, sign;
  if ((sign = n) < 0)
    n = -n;
  i = 0;
  do {
    str[i++] = n % 10 + '0';
  } while ((n /= 10) > 0);

  if (sign < 0)
    str[i++] = '-';
  str[i] = '\0';

  reverse(str);
}
