# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgpod/libgpod-0.6.0.ebuild,v 1.10 2008/08/17 16:21:03 maekke Exp $

inherit libtool subversion

ESVN_REPO_URI="https://gtkpod.svn.sourceforge.net/svnroot/gtkpod/libgpod/trunk/"
ESVN_BOOTSTRAP="autogen.sh"

DESCRIPTION="Shared library to access the contents of an iPod"
HOMEPAGE="http://www.gtkpod.org/libgpod.html"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk python doc test"

RDEPEND=">=dev-libs/glib-2.4
	=sys-apps/hal-0.5*
	sys-apps/sg3_utils
	dev-util/gtk-doc
	gtk? ( >=x11-libs/gtk+-2 )
	python? ( >=dev-lang/python-2.3
		>=x11-libs/gtk+-2
		media-libs/mutagen
		gtk? ( >=dev-python/pygobject-2 ) )
	test? ( media-libs/taglib )"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	python? ( >=dev-lang/swig-1.3.24 )
	dev-util/pkgconfig"

src_compile() {

	local myconf

	if use gtk; then
		myconf="--enable-pygobject"
	else
		myconf="--disable-pygobject"
	fi

	econf ${myconf} \
		$(use_enable doc gtk-doc) \
		$(use_enable gtk gdk-pixbuf) \
		$(use_with python) || die "configure failed"

	emake || die "make failed"

}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README TROUBLESHOOTING AUTHORS NEWS README.SysInfo
}

pkg_postinst() {
	einfo "If you use a newer Ipod like the Ipod classic, make sure to read"
	einfo "the information in README.SysInfo in /usr/share/doc/${P}"
	einfo "This is no needed if HAL is installed and works correctly."
}
