# A simple shared library (DSO/DLL) for midipix, written in assembly.

    .file "mylib.s"

# Define a string in the read-only data section and export it from the
# shared library.
    .text
    .section .rdata, "r"
    .globl shared_string
shared_string:
    .ascii "wootz\0"
    .section .drectve
    .ascii " -export:\"shared_string\",data"

# This is called by Windows when the DSO is loaded or unloaded from a
# process, or when threads are created or destroyed in the process.
#
# When linking the shared library, we tell the linker that this is the entry
# point, which causes it to put an appropriate entry in the PE header so that
# Windows can call this function.
#
# For info about DLL entry points, see:
# https://msdn.microsoft.com/en-us/library/windows/desktop/ms682596.aspx
#
# This routine is normally defined in
# https://github.com/midipix-project/mmglue/blob/main/crt/nt64/crte.s
#
# I don't understand the midipix implementation; it seems wrong to me.
    .text
    .globl __so_entry_point
__so_entry_point:
    mov $1, %eax        # Return TRUE to indicate success.
    ret

# Normally defined in https://github.com/midipix-project/mmglue/blob/main/crt/nt64/crte.s
# I don't think it serves any purpose yet.
__dso_main_routine:
    ret

# This data structure is normally defined in
# https://github.com/midipix-project/mmglue/blob/main/crt/nt64/crti.s
# I don't think it serves any purpose yet.
    .section .midipix
    .ascii "e35ed272"
    .ascii "9e55"
    .ascii "46c1"
    .ascii "8251"
    .ascii "022a59e6c480"
    .long 0
    .long 1
    .long 0
    .long 0
    .quad __CTOR_LIST__
    .quad __DTOR_LIST__
    .quad 0
    .quad 1
    .quad 2
    .quad 3
    .quad 4
    .quad 5
    .quad 6
    .quad 7
    .quad 8
    .quad 9
    .quad 10
    .quad 11
    .quad 12
    .quad 13
    .quad 14
    .quad 15

# This data structure is normally defined in
# https://github.com/midipix-project/mmglue/blob/main/crt/nt64/crte.s
# I don't think it serves any purpose yet.
    .section .midipix
    .quad __so_entry_point
    .quad __dso_main_routine
    .quad 0
    .quad 0
    .quad 0
    .quad 1
    .quad 2
    .quad 3
    .quad 4
    .quad 5
    .quad 6
    .quad 7
    .quad 8
    .quad 9
    .quad 10
    .quad 11
    .quad 12
    .quad 13
    .quad 14
    .quad 15
