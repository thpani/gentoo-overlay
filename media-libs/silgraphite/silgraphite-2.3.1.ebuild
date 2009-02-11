# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

DESCRIPTION="SIL Graphite smart-font engine"
HOMEPAGE="http://scripts.sil.org/RenderingGraphite"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 CPL-0.5 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug trace"

RDEPEND=">=dev-util/pkgconfig-0.14"

S="${WORKDIR}/${P}/engine"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-debug-CFLAGS.patch
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable trace tracing) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README || die "dodoc failed"
	rmdir "${D}"/usr/bin
}
