CC = gcc
CFLAGS = -Wall -c `pkg-config --cflags libsbl aravis-0.10`

LDFLAGS = -lm `pkg-config --libs libsbl aravis-0.10`

PREFIX ?= /usr/local

SOURCES = $(wildcard src/*.c)
OBJECTS = $(patsubst src/%.c, build/%.o, $(SOURCES))

all: build build/sbl_cam_daemon

build/sbl_cam_daemon: $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

build:
	mkdir -p build

build/%.o: src/%.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f build/*.o

distclean:
	rm -fr build

install:
	install -D -m 755 build/sbl_cam_daemon  $(DESTDIR)$(PREFIX)/bin/sbl_cam_daemon
	install -D -m 755 scripts/sbl_start_acqui.sh  $(DESTDIR)$(PREFIX)/bin/sbl_start_acqui

.PHONY: all clean distclean install

