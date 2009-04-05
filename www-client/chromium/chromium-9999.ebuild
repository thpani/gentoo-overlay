# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

EGCLIENT_REPO_URI="http://src.chromium.org/svn/trunk/src/"
EGCLIENT_CONFIG="${FILESDIR}/gclient_conf"

inherit eutils gclient

DESCRIPTION="Chromium is the open-source project behind Google Chrome."
HOMEPAGE="http://code.google.com/chromium/"
SRC_URI=""

LICENSE="BSD"
SLOT="live"
KEYWORDS="~x86"
IUSE=""

DEPEND="
    >=dev-lang/python-2.4
    >=dev-lang/perl-5.0
    >=sys-devel/gcc-4.2
    >=sys-devel/bison-2.3
    >=sys-devel/flex-2.5.34
    >=dev-util/gperf-3.0.3
    >=dev-util/pkgconfig-0.20
    >=dev-libs/nss-3.12
    dev-libs/glib:2
    x11-libs/gtk+:2
    >=dev-libs/nspr-4.7.1
    media-fonts/corefonts
	media-libs/freetype
"
RDEPEND=""

src_compile() {
	cd ${S}/build

	# stable dev-util/scons (1.0.0 atm) doesn't work for me
	# (fails to create ../sconsbuild/{Debug,Release}),
	# so use thirdparty dependency in the meantime.
	python ../third_party/scons/scons.py \
		--site-dir=../site_scons --mode="Release" \
		${MAKEOPTS} app || die "scons build failed"
}

src_install() {
	cd "${S}/sconsbuild/Release"

	exeinto "/opt/${PN}"
	doexe chrome
	insinto "/opt/${PN}"
	doins chrome.pak
	doins -r locales themes

	local cb="${PN}-browser"
	doicon "${S}/chrome/installer/linux/common/${cb}/${cb}.png"
	make_desktop_entry "/opt/${PN}/chrome" "Chromium" "$cb.png"
}
