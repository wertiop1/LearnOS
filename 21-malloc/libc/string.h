#ifndef STRINGS_H
#define STRINGS_H

#include "../cpu/types.h"

void int_to_ascii(int n, char str[]);
void hex_to_ascii(int n, char str[]);
void reverse(char str[]);
int strlen(char str[]);
void backspace(char str[]);
void append(char s[], char n);

int strcmp(char s1[], char s2[]);

#endif
