FILESEXTRAPATHS:prepend := "${THISDIR}/dts:${THISDIR}/config:"

SRC_URI:append:de10-standard = " file://socfpga_cyclone5_de10_standard.dts"
SRC_URI:append:de10-standard = " file://de10-standard-extras.cfg"

IMAGE_INSTALL:append:de10-standard = " kernel-modules"

DE10_DTS_DIR = "arch/arm/boot/dts/intel/socfpga"
do_configure:prepend:de10-standard() {
    cp ${UNPACKDIR}/socfpga_cyclone5_de10_standard.dts \
       ${S}/${DE10_DTS_DIR}/

    if ! grep -q 'socfpga_cyclone5_de10_standard.dtb' \
        ${S}/${DE10_DTS_DIR}/Makefile; then
        echo 'dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_cyclone5_de10_standard.dtb' \
            >> ${S}/${DE10_DTS_DIR}/Makefile
    fi
}
