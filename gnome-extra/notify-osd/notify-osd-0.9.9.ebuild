# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit flag-o-matic

DESCRIPTION="Canonical's on-screen-display notification agent."
HOMEPAGE="https://launchpad.net/notify-osd"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/dbus-glib-0.76
	>=dev-libs/glib-2.16.0
	gnome-base/gconf
	>=x11-libs/gtk+-2.6
	x11-libs/libwnck"
RDEPEND=""

src_compile() {
	append-flags -fno-strict-aliasing	# -Werror causes build to fail
	
	econf
	emake || die "emake failed"
}
