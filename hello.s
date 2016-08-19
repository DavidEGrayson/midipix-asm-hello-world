    .file "hello.s"
    .section .rdata,"r"
.LC0: .ascii "hello world\0"
.LC1: .ascii "hello\0"
.LC2: .ascii "hello world!\0"

    // Equivalent to _start in
    // https://github.com/midipix-project/mmglue/blob/main/crt/nt64/crt1.c
    .section .rdata,"r"
    .balign 4
__disabled:
    .space 4
    .section .got$__crtopt_posix,"r"
    .global __imp___crtopt_posix
__imp___crtopt_posix:
    .quad   __crtopt_posix
    .linkonce discard
    .text
    .weak   __crtopt_posix
    .set    __crtopt_posix,__disabled
    .section .got$__crtopt_ttydbg,"r"
    .global __imp___crtopt_ttydbg
__imp___crtopt_ttydbg:
    .quad   __crtopt_ttydbg
    .linkonce discard
    .text
    .weak   __crtopt_ttydbg
    .set    __crtopt_ttydbg,__disabled
    .text
    .globl _start
_start:
    mov __imp___crtopt_ttydbg(%rip), %rax
    mov __imp___psx_init(%rip), %rdx
    mov __imp_main, %rcx
    mov (%rax), %r8d
    mov __imp___crtopt_posix(%rip), %rax
    or (%rax), %r8d
    mov __imp___libc_entry_routine(%rip), %rax
    rex.W jmpq *%rax

    .text
    .globl main
    .seh_proc main
main:
.LFB0:
    .cfi_startproc
    .seh_pushreg %rbp
    pushq %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset 6, -16
    movq %rsp, %rbp
    .cfi_def_cfa_register 6
    .seh_stackalloc	32
    subq $32, %rsp
    .seh_setframe %rbp, 32
    .seh_endprologue
    leaq .LC0(%rip), %rcx
    movq __imp_puts(%rip), %rax
    call *%rax
    movl $0, %r9d
    leaq .LC1(%rip), %r8
    leaq .LC0(%rip), %rdx
    movl $0, %ecx
    movq __imp_MessageBoxA(%rip), %rax
    call *%rax
    leaq .LC2(%rip), %rcx
    movq __imp_puts(%rip), %rax
    call *%rax
    movl $42, %eax
    addq $32, %rsp
    popq %rbp
    .cfi_def_cfa 7, 8
    .cfi_restore 6
    ret
    .cfi_endproc
.LFE0:
    .seh_endproc
    .section .got$main,"r"
    .global __imp_main
__imp_main:
    .quad main
    .linkonce discard
    .text
