rm -f *.o *.so *.exe

x86_64-nt64-midipix-dlltool -l user32.dll.a -d user32.def

x86_64-nt64-midipix-as -o hello.o hello.s

x86_64-nt64-midipix-ld \
  --entry _start \
  --image-base 0x1920000 \
  --subsystem windows \
  --exclude-symbols=__EH_FRAME_BEGIN__,__dso_handle,_init,_fini,__so_entry_point,dso_main_routine \
  -o hello.exe \
  /usr/x86_64-nt64-midipix/lib/crti.o \
  /usr/x86_64-nt64-midipix/lib/crt1.o \
  /usr/x86_64-nt64-midipix/lib/crtbegin.o \
  -L/usr/x86_64-nt64-midipix/lib \
  -L/usr/lib/gcc/x86_64-nt64-midipix/4.6.4 \
  -L/usr/x86_64-nt64-midipix/lib \
  -L/usr/x86_64-nt64-midipix/lib \
  hello.o \
  user32.dll.a \
  --no-as-needed -lc \
  --as-needed -lpsxscl \
  --no-as-needed -lc \
  /usr/x86_64-nt64-midipix/lib/crtend.o \
  /usr/x86_64-nt64-midipix/lib/crtn.o \
  --no-as-needed -lc \
  --as-needed -lpsxscl



if [ -n "$DEPLOYDIR" ]; then
  rm -fv $DEPLOYDIR/libpsxscl.so
  rm -fv $DEPLOYDIR/libc.so
  rm -fv $DEPLOYDIR/hello.exe
  cp -v /usr/x86_64-nt64-midipix/lib/lib{psxscl,c}.so hello.exe $DEPLOYDIR
fi
