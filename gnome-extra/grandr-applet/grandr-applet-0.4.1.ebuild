# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils gnome2

MY_PN=${PN/-/_}

DESCRIPTION="Simple gnome-panel frontend to the xrandr extension"
HOMEPAGE="http://dekorte.homeip.net/download/grandr-applet/"
SRC_URI="http://dekorte.homeip.net/download/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-libs/glib
	>=x11-libs/gtk+-2.6
	>=gnome-base/gnome-panel-2.0
	>=dev-cpp/libgnomeuimm-2.0"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

S=${WORKDIR}/${MY_PN}-${PV}
