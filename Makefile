.POSIX:

PREFIX = ~/.local

all:

arc:

install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp arc ${DESTDIR}${PREFIX}/bin/arc

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/arc

.PHONY: all install uninstall
