# debian-autotools.mk -- Common settings for Autotoolsx
#
#   Copyright
#
#       Copyright (C) 2008-2009 Jari Aalto <jari.aalto@cante.net>
#
#   License
#
#       This program is free software; you can redistribute it and or
#       modify it under the terms of the GNU General Public License as
#       published by the Free Software Foundation; either version 2 of
#       the License, or (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful, but
#       WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#       General Public License for more details at
#       <http://www.gnu.org/copyleft/gpl.html>.
#
#   Description
#
#       This is GNU makefile part, that defines common variables,
#       targets and macros to be used from debian/rules.
#
#	Dealing with packages that have old Autotools config.* files
#       we can: (1) Save package's config.* (2) Copy the latest from
#       Debian (3) restore package's config.* files. This way the
#       DEbian *diff.gz stays clean and understandable to examine.
#
#	To install, add `config-*' macro calls like this:
#
#           config.status: configure
#               dh_testdir
#               ./configure [options]
#               $(config-save)
#               $(config-patch)
#               $(MAKE) $(MAKE_FLAGS)
#
#           binary-arch: build install
#               ...
#               $(config-restore)
#               dh_builddeb

ifneq (,)
    This makefile requires GNU Make.
endif

define config-h-in-save
        # Save original file
        [ -f config.h.in.original ] || cp -v config.h.in config.h.in.original
endef

define config-h-in-restore
        # Restore original file
        [ ! -f config.h.in.original ] || mv -v config.h.in.original config.h.in
endef

define config-configure-save
        # Save original file
        [ -f configure.original ] || cp -v configure configure.original
endef

define config-configure-restore
        # Restore original file
        [ ! -f configure.original ] || mv -v configure.original configure
endef

define config-save
        # Save original files
        [ -f config.sub.original   ] || cp -v config.sub config.sub.original
        [ -f config.guess.original ] || cp -v config.guess config.guess.original
endef

define config-restore
        # Restore original files
        [ ! -f config.sub.original   ] || mv -v config.sub.original config.sub
        [ ! -f config.guess.original ] || mv -v config.guess.original config.guess
endef

define config-delete
        # Delete config files
        rm -f config.sub config.guess
endef

ifneq ($(wildcard /usr/share/misc/config.sub),)
define config-patch-sub
        # Use latest version from Debian
        cp -vf /usr/share/misc/config.sub config.sub
endef
endif

ifneq ($(wildcard /usr/share/misc/config.guess),)
define config-patch-guess
        # Use latest version from Debian
        cp -vf /usr/share/misc/config.guess config.guess
endef
endif

define config-patch
        # config-patch: copy latest
        $(config-patch-sub)
        $(config-patch-guess)
endef

# End of Makefile part
