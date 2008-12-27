# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib

DESCRIPTION="A thin wrapper around FFmpeg"
HOMEPAGE="http://code.google.com/p/avbin/"
SRC_URI="amd64? ( http://avbin.googlecode.com/files/avbin-linux-x86-64-${PV}.tar.gz )
	x86? ( http://avbin.googlecode.com/files/avbin-linux-x86-32-${PV}.tar.gz )"

LICENSE="|| ( GPL-3 LGPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

if use amd64 ; then
	S="${WORKDIR}/avbin-linux-x86-64-${PV}"
elif use x86 ; then
	S="${WORKDIR}/avbin-linux-x86-32-${PV}"
fi

src_install() {
	libdir=/usr/$(get_libdir)

	exeinto ${libdir}
	doexe libavbin.so.${PV}

	dosym ${libdir}/libavbin.so.${PV} ${libdir}/libavbin.so
}
