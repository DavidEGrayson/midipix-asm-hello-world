set -ue

rm -f *.o *.so *.exe

x86_64-nt64-midipix-dlltool -l user32.dll.a -d user32.def

x86_64-nt64-midipix-as -o hello.o hello.s

x86_64-nt64-midipix-ld \
  --entry _start \
  --image-base 0x1920000 \
  --subsystem windows \
  --exclude-symbols=__EH_FRAME_BEGIN__,__dso_handle,_init,_fini,__so_entry_point,dso_main_routine \
  -o hello.exe \
  hello.o \
  user32.dll.a \
  --no-as-needed /usr/x86_64-nt64-midipix/lib/libc.lib.a \
  --as-needed /usr/x86_64-nt64-midipix/lib/libpsxscl.lib.a \
  --no-as-needed /usr/x86_64-nt64-midipix/lib/libc.lib.a \
  --no-as-needed /usr/x86_64-nt64-midipix/lib/libc.lib.a \
  --as-needed /usr/x86_64-nt64-midipix/lib/libpsxscl.lib.a

x86_64-nt64-midipix-strip hello.exe

sha256sum hello.exe

if [ -n "$DEPLOYDIR" ]; then
  rm -f $DEPLOYDIR/libpsxscl.so
  rm -f $DEPLOYDIR/libc.so
  rm -f $DEPLOYDIR/hello.exe
  cp /usr/x86_64-nt64-midipix/lib/lib{psxscl,c}.so hello.exe $DEPLOYDIR
fi
