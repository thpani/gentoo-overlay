# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils gnome2

DESCRIPTION="H.323 and SIP VoIP softphone"
HOMEPAGE="http://www.ekiga.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="avahi dbus debug doc eds gconf gnome ldap libnotify xv"

RDEPEND=">=dev-libs/ptlib-2.4.2[debug=,-minimal]
	>=net-libs/opal-3.4.2[debug=]
	>=x11-libs/gtk+-2.12.0:2
	>=dev-libs/glib-2.8.0:2
	dev-libs/libsigc++:2
	dev-libs/libxml2:2
	avahi? ( >=net-dns/avahi-0.6.0 )
	dbus? ( >=dev-libs/dbus-glib-0.36 )
	eds? ( >=gnome-extra/evolution-data-server-1.2 )
	gconf? ( >=gnome-base/gconf-2.6.0:2 )
	gnome? ( >=gnome-base/libgnome-2.14.0
		>=gnome-base/libgnomeui-2.14.0 )
	ldap? ( net-nds/openldap )
	libnotify? ( x11-libs/libnotify )
	xv? ( x11-libs/libXv )"

DEPEND="${RDEPEND}
	>=sys-devel/make-3.81
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.35
	doc? ( app-text/scrollkeeper
		app-text/gnome-doc-utils )"

DOCS="AUTHORS ChangeLog FAQ NEWS README"

pkg_setup() {
	# dbus-service is always enable if dbus is enable, no reason to disable it
	G2CONF="${G2CONF}
		$(use_enable avahi)
		$(use_enable dbus)
		$(use_enable dbus dbus_service)
		$(use_enable debug)
		$(use_enable doc gdu)
		$(use_enable eds)
		$(use_enable gconf)
		$(use_enable gnome)
		$(use_enable ldap)
		$(use_enable libnotify notify)
		$(use_enable xv)"
}

src_unpack() {
	gnome2_src_unpack

	# remove call to gconftool-2 --shutdown
	sed -i -e '/gconftool-2 --shutdown/d' Makefile.in \
		|| die "Patching Makefile.in failed"

	# fix ekiga-helper dbus service .in file
	sed -i -e 's/@PACKAGE_NAME@/ekiga/'\
		src/components/org.ekiga.Helper.service.in \
		|| die "Patching src/components/org.ekiga.Helper.service.in failed"
}

src_configure() {
	# for some reasons, src_configure do not use gnome2_src_configure
	# gnome2_src_configure is called from src_compile, so we have to overwrite
	# this function and make it doing nothing
	# see bug #239123
	:
}

pkg_postinst() {
	gnome2_pkg_postinst

	if ! use gnome; then
		ewarn "USE=-gnome is experimental, some weirdness with the UI and"
		ewarn "config keys should appear."
	fi
}
