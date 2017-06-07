#wput makefile
PACKAGE     = wput
destdir     = ${DESTDIR}
prefix      = /usr/local
datadir     = $(prefix)/share
mandir	    = ${prefix}/share/man/man1
exec_prefix = ${prefix}
bindir=${exec_prefix}/bin

all clean:
	cd po && $(MAKE) $(MAKEDEFS) $@
	cd src && $(MAKE) $(MAKEDEFS) $@
	cd doc && $(MAKE) $(MAKEDEFS) $@

win-clean:
	cd src && $(MAKE) $(MAKEDEFS) $@

install: all
	cd po && $(MAKE) $(MAKEDEFS) $@
	install -m0755 -d $(destdir)$(bindir)
	install -m0755 -d $(destdir)$(mandir)
	install -m0755 wput $(destdir)$(bindir)
	install -m0644 doc/wput.1.gz $(destdir)$(mandir)
	cd $(destdir)$(bindir) && ln -s wput wdel
	install -m0644 doc/wdel.1.gz $(destdir)$(mandir)
	@echo "----------------"
	@echo "Wput and Wdel installed. See 'wput/wdel -h' or 'man wput/wdel' for"
	@echo "usage information."
	@echo "Further documentation is located in the doc/USAGE.* files."
	@echo 
	@echo "Wput is not perfect, so please report any bugs you notice (see BUGS-section"
	@echo "in the manpage)."
	@echo "----------------"
uninstall:
	rm -f $(destdir)$(bindir)/wput
	rm -f $(destdir)$(bindir)/wdel
	rm -f $(destdir)$(mandir)/wput.1.gz
	rm -f $(destdir)$(mandir)/wdel.1.gz

