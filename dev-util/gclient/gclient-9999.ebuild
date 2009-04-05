# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI="http://gclient.googlecode.com/svn/trunk/gclient"

inherit subversion

DESCRIPTION="Manage checkouts and updates from various SCM repositories."
HOMEPAGE="http://code.google.com/p/gclient/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/python-2.4"

src_install() {
	newbin gclient.py gclient
}
