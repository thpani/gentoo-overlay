# Copyright 2000-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit gnome.org mono autotools

DESCRIPTION="Tasky is a simple task management app (TODO list) for the Linux Desktop"
HOMEPAGE="http://live.gnome.org/Tasque"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="eds sqlite"

RDEPEND=">=dev-dotnet/gtk-sharp-2.12.7-r5
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/notify-sharp-0.4.0_pre20080912
	>=dev-dotnet/dbus-sharp-0.6
	>=dev-dotnet/dbus-glib-sharp-0.4
	eds? ( >=dev-dotnet/evolution-sharp-0.18.1 )
	sqlite? ( dev-db/sqlite:3 )"

DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-debug-fixup.patch
	eautoreconf
}

src_configure() {
	econf --enable-backend-rtm \
		$(use_enable sqlite backend-sqlite) \
		$(use_enable eds backend-eds) \
		--disable-backend-hiveminder
}

src_install() {
	make DESTDIR="${D}" install || die "emake failed"
	dodoc NEWS TODO README AUTHORS || die "docs installation failed"
}
