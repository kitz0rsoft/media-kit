# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils autotools gnome2-utils

MY_P="LiVES-${PV}"
DESCRIPTION="LiVES is a Video Editing System"
HOMEPAGE="http://lives-video.com"
SRC_URI="http://lives-video.com/releases/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc libvisual matroska nls ogg theora" #static-libs

RDEPEND=">=media-video/mplayer-0.90-r2[encode,jpeg,png]
	>=media-gfx/imagemagick-5.5.6[jpeg,png]
	>=dev-lang/perl-5.8.0-r12
	x11-libs/gtk+:3
	virtual/jpeg
	x11-libs/gdk-pixbuf
	media-sound/sox
	>=dev-lang/python-2.3.4
	media-libs/libsdl
	media-video/mjpegtools
	virtual/jack
	virtual/ffmpeg
	virtual/cdrtools
	sys-libs/libavc1394
	libvisual? ( media-libs/libvisual )
	matroska? ( media-video/mkvtoolnix
		media-libs/libmatroska )
	ogg? ( media-sound/ogmtools )
	theora? ( media-libs/libtheora )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	sys-devel/libtool:2
	doc? ( app-doc/doxygen )"

src_prepare() {
	# Debian patches.
	eapply "${FILESDIR}"/patches/*
	# sandbox failure fix
	eapply "${FILESDIR}"/${PN}-sandbox-libweed.patch

	# Don't try to detect installed copies wrt #295293
	sed -i -e '/^PKG_CHECK_MODULES(WEED/s:true:false:' configure.ac || die
	sed -i -e '/test/s:sendOSC:dIsAbLeAuToMaGiC:' \
		libOSC/sendOSC/Makefile.am || die

	# Use python 2.x as per reference in plugins
	sed -i \
		-e '/#!.*env/s:python:python2:' \
		lives-plugins/plugins/encoders/multi_encoder* \
		lives-plugins/marcos-encoders/lives_*_encoder* || die

	AT_M4DIR="mk/autoconf" eautoreconf
	default
}

src_configure() {
	econf \
		$(use_enable libvisual) \
		$(use_enable nls) \
		$(use_enable doc doxygen)
}

src_install() {
	emake -j1 DESTDIR="${D}" install

	rm -f "${ED}"usr/bin/lives #384727
	dosym lives-exe /usr/bin/lives

	dodoc AUTHORS BUGS ChangeLog FEATURES GETTING.STARTED NEWS README

	#find "${ED}"usr -name '*.la' -exec rm -f {} +
	#rm -f "${ED}"usr/lib*/libweed-*.a
}
pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
