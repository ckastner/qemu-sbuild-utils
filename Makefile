#!/usr/bin/make -f
# Author: Christian Kastner <ckk@kvr.at>


VERSION = 0.1


BINDIR = $(DESTDIR)/usr/bin
SBINDIR = $(DESTDIR)/usr/sbin
LIBDIR = $(DESTDIR)/usr/lib
MANDIR = $(DESTDIR)/usr/share/man/man1


build:
	mkdir -p man/
	help2man \
		--version-string $(VERSION) \
		-n "sbuild using QEMU images" \
		-N \
		-L C.UTF-8 \
		-o man/qemu-sbuild.1 \
		bin/qemu-sbuild
	cat doc/qemu-sbuild.append >> man/qemu-sbuild.1
	help2man \
		--version-string $(VERSION) \
		-n "QEMU image updater" \
		-N \
		-L C.UTF-8 \
		-o man/qemu-sbuild-update.1 \
		bin/qemu-sbuild-update
	cat doc/qemu-sbuild-update.append >> man/qemu-sbuild-update.1
	help2man \
		--version-string $(VERSION) \
		-n "QEMU image creator for sbuild" \
		-N \
		-L C.UTF-8 \
		-o man/qemu-sbuild-create.1 \
		sbin/qemu-sbuild-create
	cat doc/qemu-sbuild-create.append >> man/qemu-sbuild-create.1

install:
	install -m 755 -d $(BINDIR) $(SBINDIR) $(MANDIR)
	install -m 755 -d $(LIBDIR)/qemu-sbuild-create
	install -m 755 bin/qemu-sbuild bin/qemu-sbuild-update $(BINDIR)/
	install -m 755 sbin/qemu-sbuild-create $(SBINDIR)/
	install -m 755 lib/modscript $(LIBDIR)/qemu-sbuild-create/

clean:
	rm -rf man
