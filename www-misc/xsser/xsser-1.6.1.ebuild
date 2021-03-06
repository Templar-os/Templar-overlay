# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="XSSer: automatic tool for pentesting XSS attacks against different applications :"
HOMEPAGE="http://sourceforge.net/xsser"

inherit distutils python

MY_P=xsser_1.6-1


SRC_URI="mirror://sourceforge/xsser/${MY_P}.tar.gz"
SLOT='0'

LICENSE="GPL-3"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86
~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos
~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="gtk"


PYTHON_DEPEND="2"

RDEPEND="dev-python/pycurl
		dev-python/setuptools
	     dev-python/geoip-python
		 gtk? ( >=dev-python/pygtk-2.12.0 ) 
	     >=dev-python/beautifulsoup-3.0.0"

DEPEND="${RDEPEND}"


PYTHON_MODNAME=XSSer

# Import of the io module in python-2.6 raises ImportError for the
# thread module if threading is disabled.

S="${WORKDIR}"/${PN}-public

src_install() {
	distutils_src_install
}
