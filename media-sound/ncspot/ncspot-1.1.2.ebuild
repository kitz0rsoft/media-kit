# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes."
HOMEPAGE="https://github.com/hrkfdn/ncspot"
SRC_URI="https://github.com/hrkfdn/ncspot/tarball/7ce6e532fca311883bc855b43a83b8e8a7b9e616 -> ncspot-1.1.2-7ce6e53.tar.gz
https://regen.mordor/31/42/63/314263280e5d87eaa30ec036de2e6871d46d8bbcb96c64316cd95f56a6a55d75395aa0c1a4a4dd7d7b1028e375639b40eb786dea7b446b93eb6845d425c49da0 -> ncspot-1.1.2-funtoo-crates-bundle-dbfe11dcf358a640da377515fc30f5ae06d96d76d57457300c801754338fd1f1f8ef70ec79a47eb54fce7389ca01f5a6fe3a4e53af2ddfead49cb3ebe3449df5.tar.gz"

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