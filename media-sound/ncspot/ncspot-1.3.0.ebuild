# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes."
HOMEPAGE="https://github.com/hrkfdn/ncspot"
SRC_URI="https://github.com/hrkfdn/ncspot/tarball/7c74e4d2f7a41189ea7bd829ef5fc17abaf0daaf -> ncspot-1.3.0-7c74e4d.tar.gz
https://regen.mordor/3d/d5/ad/3dd5ad8adc358fe7ea5838a45a58c218801f5300316b81612533dd6ccee8ade167b9a68b716ac800c2f997f603588009308a182793efe71ffe5cc27d786bb4d0 -> ncspot-1.3.0-funtoo-crates-bundle-5e68d4c7d18847098ad8188d09304671aabe9b4f37e6cb9040e89c4705deedb69dcaad170d98220916683066751208ea6dca32ae507a9aead7918b1b18a78f43.tar.gz"

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