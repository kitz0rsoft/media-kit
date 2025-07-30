# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="The fastest and safest AV1 encoder."
HOMEPAGE="https://github.com/xiph/rav1e"
SRC_URI="https://github.com/xiph/rav1e/tarball/1fe82de02510767539e89b2ee6fa846920ae2686 -> rav1e-0.8.1-1fe82de.tar.gz
https://regen.mordor/3a/24/24/3a2424e8a873bf9b0abf7ceb7d038abab604f29045ddb1c87d7501ea13d5592f1be5df6dc77ad154347dbe8cc8e2117dd7c5c14b942a1d6fe4578811fe29505d -> rav1e-0.8.1-funtoo-crates-bundle-f5e38c27b20d1183ba2abba29a9b6145dbd86488edf2152b80ef5bf26024d64f4c882272bd61f1614261a94f8cce4af5ad5d1d77241b4bbf50275eb99182ce91.tar.gz"

RESTRICT=""
LICENSE="BSD-2 Apache-2.0 MIT Unlicense"
SLOT="0"
KEYWORDS="*"
IUSE="+capi"

ASM_DEP=">=dev-lang/nasm-2.15"
BDEPEND="
	amd64? ( ${ASM_DEP} )
	capi? ( dev-util/cargo-c )
"

src_unpack() {
	default
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/xiph-rav1e-* ${S} || die
}

src_compile() {
	export CARGO_HOME="${ECARGO_HOME}"
	local args=$(usex debug "" --release)

	RUSTFLAGS="-C target-cpu=native" cargo build ${args} \
		|| die "cargo build failed"

	if use capi; then
		RUSTFLAGS="-C target-cpu=native" cargo cbuild ${args} --target-dir="capi" \
			--prefix="/usr" --libdir="/usr/$(get_libdir)" \
			|| die "cargo cbuild failed"
	fi
}

src_install() {
	export CARGO_HOME="${ECARGO_HOME}"
	local args=$(usex debug --debug "")

	if use capi; then
		cargo cinstall $args --target-dir="capi" \
			--prefix="/usr" --libdir="/usr/$(get_libdir)" --destdir="${ED%/}" \
			|| die "cargo cinstall failed"
	fi

	cargo_src_install
}