# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="C++ class library normalising numerous telephony protocols"
HOMEPAGE="http://www.opalvoip.org/"
SRC_URI="mirror://sourceforge/opalvoip/${P}.tar.bz2
	doc? ( mirror://sourceforge/opalvoip/${P}-htmldoc.tar.gz )"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug doc java +wav"

RDEPEND=">=dev-libs/ptlib-2.0.0[debug=]
	>=media-video/ffmpeg-0.4.7
	media-libs/speex
	java? ( virtual/jdk )
	wav? ( dev-libs/ptlib[-minimal] )
	!wav? ( dev-libs/ptlib[minimal] )"

pkg_setup() {
	# opal can't be built with --as-needed
	append-ldflags -Wl,--no-as-needed
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# move files from ${P}-htmldoc.tar.gz
	use doc && mv ../html .

	epatch "${FILESDIR}"/${PN}-lpcini.patch
}

src_compile() {
	local makeopts

	# zrtp doesn't depend on net-libs/libzrtpcpp but on libzrtp from
	# http://zfoneproject.com/ that is not in portage
	econf \
		$(use_enable debug) \
		$(use_enable java) \
		--enable-plugins \
		--disable-localspeex \
		--disable-zrtp \
		|| die "econf failed"

	if use debug; then
		makeopts="debug"
	else
		makeopts="opt"
	fi

	emake ${makeopts} || die "emake failed"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		dohtml -r html/* docs/* || die "doc installation failed"
	fi
}
