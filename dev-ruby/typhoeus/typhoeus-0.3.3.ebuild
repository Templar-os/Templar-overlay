# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby18 ruby19"

inherit multilib ruby-fakegem

DESCRIPTION="Typhoeus runs HTTP requests in parallel while cleanly encapsulating handling logic"
HOMEPAGE="https://rubygems.org/gems/typhoeus"

LICENSE="BSD"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE="hardened"

ruby_add_rdepend "dev-ruby/mime-types"

all_ruby_prepare() {
	#dev-lang/ruby might need the "hardened" flag to enforce the following:
	if use hardened; then
		paxctl -v /usr/bin/ruby19 2>/dev/null | grep MPROTECT | grep disabled || ewarn '!!! Typhoeus may only work if ruby19 is MPROTECT disabled\n  Please disable it if required using paxctl -m /usr/bin/ruby19'
	fi
}

each_ruby_configure() {
	${RUBY} -C ext/typhoeus extconf.rb || die "extconf failed"
}

each_ruby_compile() {
	emake -C ext/typhoeus
	cp ext/typhoeus/native$(get_modname) lib/typhoeus || die "cp failed"
}
