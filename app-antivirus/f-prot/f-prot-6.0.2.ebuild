# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="FRISK Software's F-Prot virus scanner"
HOMEPAGE="http://www.f-prot.com/"
SRC_URI="x86? ( http://files.f-prot.com/files/unix-trial/fp-Linux-i686-ws.tar.gz )
	amd64? ( http://files.f-prot.com/files/unix-trial/fp-Linux-x86_64-ws.tar.gz ) "

LICENSE="F-PROT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="strip"
S=${WORKDIR}/${PN}

FPROT_PATH="/opt/f-prot"

src_install() {
	cd ${S}

	exeinto $FPROT_PATH
	doexe fpscan fpupdate
	dosym ${FPROT_PATH}/fpscan /usr/bin/fpscan
	dosym ${FPROT_PATH}/fpupdate /usr/sbin/fpupdate

	insinto $FPROT_PATH
	newins f-prot.conf.default f-prot.conf
	dosym ${FPROT_PATH}/f-prot.conf /etc/f-prot.conf

	doins *.def license.key product.data.default
	dosym ${FPROT_PATH}/product.data.default ${FPROT_PATH}/product.data

	doman doc/man/*
	dodoc doc/LICENSE* doc/CHANGES README
	dohtml -r doc/html/
}

pkg_postinst() {
	elog "Remember to run fpupdate regularly to keep the virus database"
	elog "up to date. You can use cron to run updates automated."
	elog
	elog "For examples, see /usr/share/doc/${PF}/html/auto_updt.html"
}
