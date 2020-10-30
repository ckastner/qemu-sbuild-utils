#!/usr/bin/make -f
# Author: Christian Kastner <ckk@kvr.at>


BINDIR = $(DESTDIR)/usr/bin
SBINDIR = $(DESTDIR)/usr/sbin
LIBDIR = $(DESTDIR)/usr/lib


build:


install:
	install -m 755 $(BINDIR) $(SBINDIR) $(LIBDIR)/qemu-sbuild-create
	install -m 755 bin/qemu-sbuild bin/qemu-sbuild-update $(BINDIR)/
	install -m 755 sbin/qemu-sbuild-create $(SBINDIR)/
	install -m 755 lib/modscript $(LIBDIR)/qemu-sbuild-create/
