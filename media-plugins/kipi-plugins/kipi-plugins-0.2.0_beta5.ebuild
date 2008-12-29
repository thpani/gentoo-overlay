# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_KDE="4.2"
KDE_MINIMAL="4.2"
OPENGL_REQUIRED="optional"
inherit kde4-base

MY_P="${P/_/-}"

DESCRIPTION="Plugins for the KDE Image Plugin Interface (libkipi)."
HOMEPAGE="http://www.kipi-plugins.org"
SRC_URI="mirror://sourceforge/kipi/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="cdr +imgemagick ipod mjpeg redeyes scanner"
SLOT="2"

# TODO: Check deps
DEPEND="
	>=kde-base/libkdcraw-${KDE_MINIMAL}
	>=kde-base/libkexiv2-${KDE_MINIMAL}
	>=kde-base/libkipi-${KDE_MINIMAL}
	media-libs/jpeg
	media-libs/libpng
	>=media-libs/tiff-3.5
	ipod? ( media-libs/libipod )
	redeyes? ( media-libs/opencv )
	scanner? ( media-gfx/sane-backends
		>=kde-base/libksane:${KDE_MINIMAL} )
	"

RDEPEND="${DEPEND}
	cdr? ( app-cdr/k3b )
	imagemagick? ( media-gfx/imagemagick )
	mjpeg? ( media-video/mjpegtools )"

PKG_CONFIG_PATH=":${PKG_CONFIG_PATH}:${KDEDIR}/$(get_libdir)/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_configure() {
	# This Plugin hard depends on libksane, deactivate it if use flag scanner is
	# not set.
	if ! use scanner; then
		sed -i \
			-e '/acquireimages/ s:^:#DONOTCOMPILE :' \
			"${S}"/CMakeLists.txt || die "Sed deactivating scanner support failed."
	fi

	# Fix linking
	sed -i \
		-e '/KDE4_KDEUI_LIBS/ c\\${KDE4_KIO_LIBS}'\
		"${S}"/common/libkipiplugins/CMakeLists.txt \
		|| die "Sed fixing kipi linking failed."

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with OpenGl)
		$(cmake-utils_use_with scanner KSane)
		$(cmake-utils_use_with scanner Sane)"

	kde4-base_src_configure
}
