# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_NAME=Image-ExifTool
inherit perl-module

DESCRIPTION="Read and write meta information in image, audio and video files"
HOMEPAGE="https://${PN}.org/ https://${PN}.sourceforge.net https://github.com/exiftool/exiftool"
SRC_URI="https://github.com/exiftool/exiftool/tarball/66ad5500e4325a2f6a4f627b4fc052633e99de61 -> exiftool-13.00-66ad550.tar.gz"

SLOT="0"
KEYWORDS="*"
IUSE="doc"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv exiftool-exiftool* "${S}" || die
	fi
}

src_install() {
	perl-module_src_install
	use doc && dodoc -r html/

	insinto /usr/share/${PN}
	doins -r fmt_files config_files arg_files
}