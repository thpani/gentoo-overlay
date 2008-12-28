# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="A cross-platform windowing and multimedia library in pure Python."
HOMEPAGE="http://www.pyglet.org/"
SRC_URI="http://pyglet.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples ffmpeg gtk openal"

RDEPEND="virtual/opengl
	|| ( dev-python/ctypes >=dev-lang/python-2.5 )
	ffmpeg? ( media-libs/avbin-bin )
	gtk? ( x11-libs/gtk+:2 )
	openal? ( media-libs/openal )"
# ffmpeg	compressed audio & video support
# gtk		image loading support (via GDK)
# openal	audio playing support (ALSA is also supported)

src_install() {
	DOCS="NOTICE"
	distutils_src_install

	use doc && dohtml -A txt,py -r doc/html/*
	
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
