# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes."
HOMEPAGE="https://github.com/hrkfdn/ncspot"
SRC_URI="https://github.com/hrkfdn/ncspot/tarball/31d3d79d6d5fae707cada54b2fc02a2cf8a5bc98 -> ncspot-1.2.2-31d3d79.tar.gz
https://regen.mordor/ce/7d/b1/ce7db1dd3fe95d678d673af0d5de62645e086082f6a463847dbc04a4bf7a88cb97a826b04db7d90b8591efa259fd6da9356b188bc3a99ce3d491140c80d53a91 -> ncspot-1.2.2-funtoo-crates-bundle-e1a0e00c1a9347973bbb324a23fe14cb4657fd352bf3536267095150432e5dafc0c23f41190b5272034367b2bd64f7e58a71ee8a099cc79fe9a3550063f32f2a.tar.gz"

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