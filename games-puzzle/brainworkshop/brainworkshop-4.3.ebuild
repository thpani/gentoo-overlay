# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Short-term-memory training \"N-Back\" game."
HOMEPAGE="http://brainworkshop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-python/pyglet"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-4.3-fix-paths.patch"
}

src_install() {
	newgamesbin ${PN}.pyw ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins res/* || die "doins failed"

	dodoc Readme.txt
	dodoc data/Readme-stats.txt

	newicon res/brain.png "${PN}.png"
	make_desktop_entry "${PN}" "Brain Workshop" "${PN}.png"

	prepgamesdirs
}
