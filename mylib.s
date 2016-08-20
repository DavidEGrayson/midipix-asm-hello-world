# A simple shared library (DSO/DLL) for midipix, written in assembly.

    .file "mylib.s"
    .globl shared_string
    .section .got$shared_string, "r"
    .global __imp_shared_string
__imp_shared_string:
    .quad shared_string
    .linkonce discard
    .data
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
# The midipix implementation lets shared libraries define a function named
# dso_main_routine if they want to run some code when the DLL is loaded.
# The midipix checks if fdwReason equals DLL_PROCESS_ATTACH, and if so,
# calls dso_main_routine, which is a weakly-defined routine that does
# nothing by default.
#
# This function should return TRUE (1) if it succeeds and FALSE (0)
# otherwise.  (The midipix implementation does not handle this
# correctly as far as I can tell.)
    .text
    .globl __so_entry_point
__so_entry_point:
    mov $1, %eax
    ret

# Normally defined in https://github.com/midipix-project/mmglue/blob/main/crt/nt64/crte.s
__dso_main_routine:
    ret

    .section .midipix

# This data structure is normally defined in
# https://github.com/midipix-project/mmglue/blob/main/crt/nt64/crte.s
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
