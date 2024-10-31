# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes."
HOMEPAGE="https://github.com/hrkfdn/ncspot"
SRC_URI="https://github.com/hrkfdn/ncspot/tarball/189298b256f42db33c17a8b2cb1da87ad8225ea1 -> ncspot-1.2.1-189298b.tar.gz
https://distfiles.macaronios.org/8e/90/d0/8e90d0a3e678b3c052dd3e9173a7c33c4809347c61a5dc2f4f87a69496c2fe9f93ad0a0bf776210b3037dfd395622963249ec24392af6a35e60d35d6abef395a -> ncspot-1.2.1-funtoo-crates-bundle-fcf4d90aef4a9c18096c101a785ed9b1b5ffd29887f0b0a05c1bcf2d172576eaf797c40f85563d46516f493b96f53df84e5e339d24a883b8a172a71f14171b65.tar.gz"

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