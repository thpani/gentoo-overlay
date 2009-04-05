# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bti/bti-015.ebuild,v 1.1 2009/03/11 20:23:01 gregkh Exp $

inherit bash-completion

DESCRIPTION="A command line twitter/identi.ca client"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/gregkh/bti/"
SRC_URI="mirror://kernel/linux/kernel/people/gregkh/bti/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-misc/curl sys-libs/readline dev-libs/libxml2"
RDEPEND="${DEPEND}"

src_install() {
	doman bti.1 || die "bti.1 could not be installed"
	dobin bti || die "bti could not be installed"
	dobin bti-shrink-urls || die "bti-shrink-urls could not be installed"
	dodoc bti.example README RELEASE-NOTES ||
		die "bti documentation could not be installed"
	dobashcompletion bti-bashcompletion
}
