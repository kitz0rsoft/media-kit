# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_REQ_USE="xml"
PYTHON_COMPAT=( python3+ )

inherit meson python-any-r1

DESCRIPTION="Reusable library for GPU-accelerated image processing primitives"
HOMEPAGE="https://code.videolan.org/videolan/libplacebo"
SRC_URI="https://distfiles.macaronios.org/3a/85/1e/3a851ece105e14238c23b7bc99e4728cade97213789d3a1dfc64242984b27ef7a355ca99df9b19ea9374bbc8352af74282cd8a547e7e74fa43c4c9e96843f0ca -> libplacebo-7.349.0-with-submodules.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="0/$(ver_cut 2)" # libplacebo.so version
KEYWORDS="*"
IUSE="glslang lcms +opengl +shaderc +vulkan"

REQUIRED_USE="vulkan? ( || ( glslang shaderc ) )"
RESTRICT="test"
S=${WORKDIR}/libplacebo

RDEPEND="glslang? ( dev-util/glslang )
	lcms? ( media-libs/lcms:2 )
	opengl? ( media-libs/libepoxy )
	shaderc? ( >=media-libs/shaderc-2017.2 )
	vulkan? (
		dev-util/vulkan-headers
		media-libs/vulkan-loader
	)"
DEPEND="${RDEPEND}"

BDEPEND="virtual/pkgconfig
	vulkan? (
		${PYTHON_DEPS}
		$(python_gen_any_dep 'dev-python/mako[${PYTHON_USEDEP}]')
	)"

#src_unpack() {
#	cd ${WORKDIR} && tar xf ${DISTDIR}/${A} || die
#}

post_src_unpack() {
	sed -i "s:\(#include <vulkan/vulkan.h>\):\1\n#include <vulkan/vulkan_metal.h>:" "${S}"/src/include/${PN}/vulkan.h || die
}

python_check_deps() {
	has_version -b "dev-python/mako[${PYTHON_USEDEP}]"
}

pkg_setup() {
	use vulkan && python-any-r1_pkg_setup
}

src_configure() {
	local emesonargs=(
		$(meson_feature glslang)
		$(meson_feature lcms)
		$(meson_feature opengl)
		$(meson_feature shaderc)
		$(meson_feature vulkan)
		-Dtests=false
		# hard-code path from dev-util/vulkan-headers
		-Dvulkan-registry=/usr/share/vulkan/registry/vk.xml
	)
	meson_src_configure
}