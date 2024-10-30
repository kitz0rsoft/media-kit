# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes."
HOMEPAGE="https://github.com/hrkfdn/ncspot"
SRC_URI="https://github.com/hrkfdn/ncspot/tarball/39c5efcf5c4871ddf10b00cabde9cc81a8a177c6 -> ncspot-1.2.0-39c5efc.tar.gz
https://distfiles.macaronios.org/bc/06/7d/bc067dfb6e326439d174b9670163bbfcd5ca17769f48c68189623b34c9579f2cde15798416d5df22e5f1bd853d3573cfb51040c9a1d59ffc9102ae699b8aca00 -> ncspot-1.2.0-funtoo-crates-bundle-c712ad0d5eedb612de01001d65e280e078afd6f3412bae29a9a70b969a3500168a85dd91796355f373e69e055f79d3b2187f0f2e960bb04b697fc56d39b3e0e9.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND=""
BDEPEND="virtual/rust"

DOCS=( README.md CHANGELOG.md )

QA_FLAGS_IGNORED="/usr/bin/ncspot"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/hrkfdn-ncspot-* ${S} || die
}