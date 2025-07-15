int strlen(char str[]) {
  int cnt = 0;
  while (str[cnt] != '\0')
    ++cnt;
  return cnt;
}

void reverse(char str[]) {
  int c, i, j;
  for (i = 0, j = strlen(str) - 1; i < j; i++, j--) {
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

void append(char str[], char n) {
  int len = strlen(str);
  str[len] = n;
  str[len + 1] = '\0';
}

void backspace(char str[]) {
  int len = strlen(str);
  str[len - 1] = '\0';
}

int strcmp(char s1[], char s2[]) {
  int i;
  for (i = 0; s1[i] == s2[i]; i++) {
    if (s1[i] == '\0')
      return 0;
  }
  return s1[i] - s2[i];
}
