# Copyright 2007-2008 by the individual contributors of the genkdesvn project
# Based in part upon the respective ebuild in Gentoo which is: 
# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

OPENGL_REQUIRED="optional"
inherit kde4-base

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Plugins for the KDE Image Plugin Interface (libkipi)."
HOMEPAGE="http://www.kipi-plugins.org"
SRC_URI="mirror://sourceforge/kipi/${MY_P}.tar.bz2"

SLOT="4.2"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="cdr imagemagick mjpegtools scanner"

# TODO: Check deps
DEPEND="
	kde-base/libkdcraw:${SLOT}
	kde-base/libkexiv2:${SLOT}
	kde-base/libkipi:${SLOT}
	media-libs/jpeg
	media-libs/libpng
	>=media-libs/tiff-3.5
	scanner? ( media-gfx/sane-backends 
		kde-base/libksane:${SLOT} )
	"

# app-cdr/k3b: Burning support
# media-gfx/imagemagick: Handle many image formats
# media-video/mjpegtools: Multi image jpeg support
RDEPEND="${DEPEND}
	cdr? ( app-cdr/k3b )
	imagemagick? ( media-gfx/imagemagick )
	mjpeg? ( media-video/mjpegtools )
"

# Install to KDEDIR to slot the package
PREFIX="${KDEDIR}"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${KDEDIR}/$(get_libdir)/pkgconfig"
RESTRICT="test"

src_compile() {
	# Fix linkage
	sed -e '/KDE4_KDEUI_LIBS/ c\\${KDE4_KIO_LIBS}'\
		-i "${S}"/common/libkipiplugins/CMakeLists.txt \
		|| die "Fixing kipi-plugins linkage failed."
	# Don't build ipod plugin
	sed -e '/ADD_SUBDIRECTORY(ipodexport)/ d' \
		-i "${S}"/CMakeLists.txt \
		|| die "Disabling ipod plugin failed."

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with OpenGl)
		$(cmake-utils_use_with scanner KSane)
		$(cmake-utils_use_with scanner Sane)"

	kde4-base_src_compile
}
