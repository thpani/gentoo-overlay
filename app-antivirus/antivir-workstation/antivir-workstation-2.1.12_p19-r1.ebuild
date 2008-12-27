# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P=${PN}-prof-${PV/_p/-}
DESCRIPTION="AVIRA AntiVir Personal virus scanner"
HOMEPAGE="http://www.avira.com/"
SRC_URI="http://dlpro.antivir.com/down/unix/packages/${MY_P}.tar.gz
http://dlce.antivir.com/down/windows/hbedv.key"
# the workstation personal tarballs are available from
# http://dlce.antivir.com/down/unix/packages/antivir-workstation-pers.tar.gz
# (files are the same, but the tarball is unversioned, so we go with prof)

LICENSE="AVIRA-AntiVir"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="strip"
S="${WORKDIR}/${MY_P}"

AV_PATH="/usr/lib/AntiVir"

pkg_setup() {
	enewgroup antivir
}

src_unpack() {
	unpack ${MY_P}.tar.gz
	cp ${DISTDIR}/hbedv.key ${S}
}

src_install () {
	diropts -gantivir
	insopts -gantivir
	exeopts -gantivir

	exeinto ${AV_PATH}
	insinto ${AV_PATH}

	# command line scanner
	doexe bin/linux_glibc22/antivir
	dosym ${AV_PATH}/antivir /usr/bin/antivir
	doins vdf/*.vdf
	doins hbedv.key
	doexe script/configantivir

	# internet update daemon
	doexe script/avupdater
	insinto /etc
	doins etc/avupdater.conf

	dosym ${AV_PATH}/avupdater /usr/sbin/avupdater
	newinitd ${FILESDIR}/avupdater_initd avupdater

	# docs
	dodoc LICENSE README
	dodoc pgp/antivir.gpg
	newdoc pgp/README README.pgp
}

pkg_postinst() {
	elog "Remember to run avupdate regularly to keep the virus database"
	elog "up to date. You can use cron to run updates automated."
}
