# meta-terasic-de10-standard
A yocto layer that adds support for Terasic DE10-Standard board

# Info
Tested on Yocto Wrynose release, linux kernel 6.18-lts and U-Boot 2026.04

Depends on the meta-intel-fpga layer!

# Usage
This is the minimal (nodistro) local.conf file you need to use this layer:
```
# Machine
MACHINE ?= "de10-standard"
UBOOT_CONFIG = "de10-standard"
UBOOT_EXTLINUX_FDT:cyclone5 = "/socfpga_cyclone5_de10_standard.dtb"

# Kernel provider — meta-intel-fpga uses linux-socfpga
PREFERRED_PROVIDER_virtual/kernel = "linux-socfpga-lts"
PREFERRED_VERSION_linux-socfpga-lts = "6.18%"

# Dev shell / debugging
EXTRA_IMAGE_FEATURES ?= "allow-empty-password empty-root-password allow-root-login post-install-logging ssh-server-dropbear tools-debug serial-autologin-root"

# Reduce build time: use all cores
BB_NUMBER_THREADS ?= "${@oe.utils.cpu_count()}"
PARALLEL_MAKE ?= "-j ${@oe.utils.cpu_count()}"

# Keep disk usage sane
INHERIT += "rm_work"

USER_CLASSES ?= "buildstats"
PATCHRESOLVE = "noop"

BB_DISKMON_DIRS ??= "\
    STOPTASKS,${TMPDIR},1G,100K \
    STOPTASKS,${DL_DIR},1G,100K \
    STOPTASKS,${SSTATE_DIR},1G,100K \
    STOPTASKS,/tmp,100M,100K \
    HALT,${TMPDIR},100M,1K \
    HALT,${DL_DIR},100M,1K \
    HALT,${SSTATE_DIR},100M,1K \
    HALT,/tmp,10M,1K"

CONF_VERSION = "2"
```


