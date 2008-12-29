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
IUSE="alsa doc examples ffmpeg gtk +openal"

RDEPEND="virtual/opengl
	|| ( dev-python/ctypes >=dev-lang/python-2.5 )
	alsa? ( media-libs/alsa-lib )
	ffmpeg? ( media-libs/avbin-bin )
	gtk? ( x11-libs/gtk+:2 )
	openal? ( media-libs/openal )"
# alsa		audio playing support w/ ALSA
# ffmpeg	compressed audio & video support
# gtk		image loading support (via GDK)
# openal	audio playing support w/ OpenAL

pkg_setup() {
	# upstream bug #378: http://code.google.com/p/pyglet/issues/detail?id=378
	if use alsa && ! built_with_use -a media-libs/alsa-lib alisp midi ; then
		eerror "ALSA support in pyglet needs the USE flags"
		eerror "alisp and midi enabled for media-libs/alsa-lib."
		eerror "Either rebuild alsa-lib with these flags enabled, or"
		eerror "disable the alsa flag for pyglet."
		elog "(To still get sound support you can enable the openal flag.)"
		die "Missing USE flags on media-libs/alsa-lib."
	fi
}

src_install() {
	DOCS="NOTICE"
	distutils_src_install

	use doc && dohtml -A txt,py -r doc/html/*
	
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
