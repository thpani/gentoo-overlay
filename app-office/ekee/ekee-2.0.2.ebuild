# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ruby

DESCRIPTION="A small LaTeX editor that produces images, with drag and drop
support."
HOMEPAGE="http://rlehy.free.fr/"
SRC_URI="http://rlehy.free.fr/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-ruby/qt4-qtruby
	|| ( dev-texlive/texlive-fontsrecommended
		 app-text/tetex
		 app-text/ptex )
	app-text/dvipng
	media-gfx/pstoedit
	x11-misc/xdg-utils"

src_install() {
	dobin ekee
}
