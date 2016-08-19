    // This is our entry point, the first place where our code actually starts running.
    // This is roughly equivalent to _start in
    // https://github.com/midipix-project/mmglue/blob/main/crt/nt64/crt1.c
    .text
    .globl _start
_start:
    mov __imp___psx_init(%rip), %rdx
    mov __imp_main(%rip), %rcx
    mov $0, %r8d
    mov __imp___libc_entry_routine(%rip), %rax
    rex.W jmpq *%rax
