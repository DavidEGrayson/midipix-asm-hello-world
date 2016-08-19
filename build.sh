x86_64-nt64-midipix-dlltool -l user32.dll.a -d user32.def
x86_64-nt64-midipix-gcc hello.c user32.dll.a -o hello.exe

if [ -n "$DEPLOYDIR" ]; then
  rm -f $DEPLOYDIR/libpsxscl.so
  rm -f $DEPLOYDIR/libc.so
  rm -f $DEPLOYDIR/hello.exe
  cp /usr/x86_64-nt64-midipix/lib/lib{psxscl,c}.so hello.exe $DEPLOYDIR
fi
