#!/bin/sh

# if RE/flex was installed below this directory, then copy its files
if [ -d ../reflex ]; then
echo "Copying updated RE/flex source code files..."
cp -r ../reflex/include/reflex/*.h include/reflex
cp -r ../reflex/unicode/*.cpp lib
cp -r ../reflex/lib/*.cpp lib
fi

# change lib/Makefile.am to use noinst_LIBRARIES
sed -i .bak 's/lib_LIBRARIES/noinst_LIBRARIES/' lib/Makefile.am
rm -f lib/Makefile.am.bak

# run autoconf and automake stuff
aclocal
autoheader
automake --add-missing --foreign
autoconf
automake
touch config.h.in
./configure --enable-color
