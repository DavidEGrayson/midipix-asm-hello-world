set -ue

LDFLAGS="--subsystem windows --exclude-symbols=__EH_FRAME_BEGIN__,__dso_handle,_init,_fini,__so_entry_point,dso_main_routine"

rm -f *.o *.so *.exe

x86_64-nt64-midipix-dlltool -l user32.dll.a -d user32.def

x86_64-nt64-midipix-as -o mylib.o mylib.s
x86_64-nt64-midipix-ld $LDFLAGS \
  -shared \
  --entry __so_entry_point \
  --enable-auto-image-base \
  -o mylib.so /usr/x86_64-nt64-midipix/lib/crti.o \
  /usr/x86_64-nt64-midipix/lib/crte.o \
  /usr/x86_64-nt64-midipix/lib/crtbeginS.o \
  mylib.o \
  /usr/x86_64-nt64-midipix/lib/crtendS.o \
  /usr/x86_64-nt64-midipix/lib/crtn.o \

x86_64-nt64-midipix-dlltool -l mylib.so.a -d mylib.def

x86_64-nt64-midipix-as -o hello.o hello.s
x86_64-nt64-midipix-as -o crt1.o crt1.s

x86_64-nt64-midipix-ld $LDFLAGS \
  --entry _start \
  --image-base 0x1920000 \
  -o hello.exe \
  crt1.o \
  hello.o \
  user32.dll.a \
  mylib.so.a \
  /usr/x86_64-nt64-midipix/lib/libc.lib.a \
  /usr/x86_64-nt64-midipix/lib/libpsxscl.lib.a \

# x86_64-nt64-midipix-strip hello.exe

sha256sum hello.exe

if [ -n "$DEPLOYDIR" ]; then
  rm -f $DEPLOYDIR/mylib.so $DEPLOYDIR/libpsxscl.so $DEPLOYDIR/libc.so \
    $DEPLOYDIR/hello.exe
  cp /usr/x86_64-nt64-midipix/lib/{libpsxscl,libc}.so mylib.so hello.exe $DEPLOYDIR
fi
