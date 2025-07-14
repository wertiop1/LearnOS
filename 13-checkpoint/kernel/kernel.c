
void dummy_test_entrypoint() {}

void main() {
  // pointer to first text cell in video memory
  char *video_memory = (char *)0xb8000; // IM STUPID LMAO

  *video_memory = 'X';
}
