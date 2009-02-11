# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit eutils autotools multilib

MPN=silgraphite
MP=${MPN}-${PV}
DESCRIPTION="Pango module for Graphite"
HOMEPAGE="http://scripts.sil.org/RenderingGraphite"
SRC_URI="mirror://sourceforge/${MPN}/${MP}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="dev-libs/glib:2
	>=media-libs/fontconfig-2.2.93
	media-libs/freetype:2
	>=media-libs/silgraphite-2.2.0
	x11-libs/pango"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.14"

S="${WORKDIR}/${MP}/wrappers/pangographite"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-check-ftface.patch
	epatch "${FILESDIR}"/${P}-debug-CFLAGS.patch
	epatch "${FILESDIR}"/${P}-fix-locking.patch
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README || die "dodoc failed"
	rmdir "${D}"/usr/bin

	insinto /etc/pango
	local PANGO_MODULES_DIR="$(echo "${D}"/usr/"$(get_libdir)"/pango/*/modules)"
	PANGO_MODULES_DIR=${PANGO_MODULES_DIR#${D}}
	cat >pangorc-graphite <<-EOF
		[Pango]
		ModulesPath=${PANGO_MODULES_DIR}:${PANGO_MODULES_DIR}/graphite
	EOF
	doins pangorc-graphite || die "doins pangorc-graphite failed"

	cat >50pangographite <<-EOF
		PANGO_RC_FILE=/etc/pango/pangorc-graphite
	EOF
	doenvd 50pangographite || die "doenvd failed"
}

# stolen from pango-1.18.4.ebuild

multilib_enabled() {
	has_multilib_profile || ( use x86 && [[ $(get_libdir) == lib32 ]] )
}

pkg_postinst() {
	if [[ "${ROOT}" == / ]] ; then
		einfo "Generating modules listing..."
		local PANGO_CONFDIR=
		if multilib_enabled ; then
			PANGO_CONFDIR=/etc/pango/${CHOST}
		else
			PANGO_CONFDIR=/etc/pango
		fi
		mkdir -p ${PANGO_CONFDIR}

		PANGO_RC_FILE=/etc/pango/pangorc-graphite pango-querymodules >${PANGO_CONFDIR}/pango.modules
	fi
}

pkg_postrm() {
	if [[ "${ROOT}" == / ]] ; then
		einfo "Generating modules listing..."
		local PANGO_CONFDIR=
		if multilib_enabled ; then
			PANGO_CONFDIR=/etc/pango/${CHOST}
		else
			PANGO_CONFDIR=/etc/pango
		fi
		mkdir -p ${PANGO_CONFDIR}

		[ -f $PANGO_RC_FILE ] || unset PANGO_RC_FILE
		pango-querymodules >${PANGO_CONFDIR}/pango.modules
	fi
}
