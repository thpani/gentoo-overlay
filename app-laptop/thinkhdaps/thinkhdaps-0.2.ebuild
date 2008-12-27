# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON="2.5"
inherit python

DESCRIPTION="A disk protection monitor."
HOMEPAGE="http://web.student.tuwien.ac.at/~e0726415/thinkhdaps.html"
SRC_URI="http://web.student.tuwien.ac.at/~e0726415/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pygtk
	dev-python/gnome-python"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS INSTALL NEWS README || die
}

