# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Adobe AIR runtime and development kit for Linux"
HOMEPAGE="http://labs.adobe.com/technologies/air/"
SRC_URI="http://airdownload.adobe.com/air/lin/download/latest/air_${PV}_sdk.tbz2"

LICENSE="AdobeAIR"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="strip"

DEPEND="dev-libs/nspr
		dev-libs/nss"
RDEPEND="${DEPEND}
		 virtual/jre"

src_unpack() {
	unpack ${A}
	rm runtimes/air/linux/Adobe\ AIR/Versions/1.0/Resources/nss3/0d/*.so
	rm runtimes/air/linux/Adobe\ AIR/Versions/1.0/Resources/nss3/1d/*.so
	rm runtimes/air/linux/Adobe\ AIR/Versions/1.0/Resources/nss3/None/*.so
	sed -i -e "s|^here=.*|here=/opt/${P}/bin|" bin/adt
}

src_install() {
	insinto /opt/${P}
	doins -r frameworks lib runtimes || die "doins failed"
	exeinto /opt/${P}/bin
	doexe bin/adl || die "installing adl failed"
	doexe bin/adt || die "installing adt failed"
	dosym /opt/${P}/bin/adl /usr/bin/ || die "dosym adl failed"
	dosym /opt/${P}/bin/adt /usr/bin/ || die "dosym adt failed"
	dobin ${FILESDIR}/air-run
}
