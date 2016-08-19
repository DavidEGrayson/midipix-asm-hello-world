#include <stdio.h>
#include <stdint.h>

extern int __stdcall MessageBoxA(void *, char *, char *, uint32_t);

int main() {
  puts("hello world");
  MessageBoxA(NULL, "hello world", "hello", 0);
  puts("hello world!");
  return 42;
}
