# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

DESCRIPTION="Language bindings for radare2"
HOMEPAGE="http://www.radare.org"
HOMEPAGE="https://github.com/radare/radare2-bindings"
SRC_URI="https://github.com/radare/radare2-bindings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
	#"ctypes cxx guile java lua node-ffi perl php5 python ruby"
IUSE="+ctypes +cxx guile lua perl php5 python ruby"

RDEPEND="
	cxx? ( sys-devel/gcc[cxx] )
	perl? ( dev-lang/perl )
	guile? ( dev-scheme/guile )
	lua? ( >=dev-lang/lua-5.1.4 )
	php5? ( >=dev-lang/php-5.3.8 )
	ruby? ( >=dev-lang/ruby-1.8.7 )"

DEPEND="${RDEPEND}
	dev-util/radare2
	virtual/pkgconfig
	dev-util/valabind
	dev-lang/swig
	>=dev-lang/vala-0.14"

src_prepare(){
	epatch "${FILESDIR}/01_use_python_2.7.patch"
}

src_configure(){
	#"ctypes cxx guile java lua node-ffi perl php5 python ruby"
	local myconf
	local mylang

	use php5 && myconf="php"

#	FIXME: add python support
#	https://github.com/radare/radare2-bindings/issues/33
	for mylang in ctypes cxx guile lua perl ruby ; do
		if use $mylang; then
			[ -z "$myconf" ] || myconf+=","
			myconf+="$mylang"
		fi
	done

	#not included languages are disabled
	econf --enable="$myconf"
}
