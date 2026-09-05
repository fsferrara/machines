#! /usr/bin/env sh

set -e
set -u


##########
# CONFIG #
##########
CMD_METAPACKAGES_LIST='apt search "^" | grep -i -B1 "metapackage\|meta-package"'
CMD_METAPACKAGE_INFO="apt show metapackage-name"


########
# EXEC #
########
printf '\n\n🔌 Executing...\n'
eval "${CMD_METAPACKAGES_LIST}"


########
# DONE #
########
printf '\n\n⚠️ The list may be incomplete since it is a grep-based command filtering the descriptions\n'
printf '\n\n✅ To know what is inside a metapackage use:\n\t %s\n' "$CMD_METAPACKAGE_INFO"
exit 0;


# WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

# 389-ds/questing,questing 3.1.2+dfsg1-1 all
#   389 Directory Server suite - metapackage
# --
# apertium-all-dev/questing,questing 3.8.1-3 all
#   Metapackage for all tools required for Apertium development
# --
# aspell-pt/questing,questing 1.10 all
#   Portuguese dictionaries for GNU Aspell (metapackage)
# --
# bacula/questing,questing 15.0.3-3ubuntu2 all
#   network backup service - metapackage
# --
# bacula-client/questing,questing 15.0.3-3ubuntu2 all
#   network backup service - client metapackage
# --
# bacula-server/questing,questing 15.0.3-3ubuntu2 all
#   network backup service - server metapackage
# --
# bandit/questing,questing 1.7.10-2 all
#   Security oriented static analyzer for Python code - Metapackage
# --
# baresip/questing,questing 1.1.0-3 all
#   portable and modular SIP user-agent - metapackage
# --
# bilibop/questing,questing 0.6.5 all
#   run Debian GNU/Linux from external media - metapackage
# --
# biosyntax/questing,questing 1.0.0b-6 all
#   Syntax Highlighting for Computational Biology (metapackage)
# --
# blends-dev/questing,questing 0.7.10 all
#   Debian Pure Blends common files for developing metapackages
# --
# bluetooth/questing,questing 5.83-1~exp1 all
#   Bluetooth support (metapackage)
# --
# boinc/questing,questing 8.2.5+dfsg-1 all
#   metapackage for the BOINC client and the manager
# --
# boinc-client-nvidia-cuda/questing 8.2.5+dfsg-1 amd64
#   metapackage for CUDA-savvy BOINC client and manager
# --
# boinc-client-opencl/questing 8.2.5+dfsg-1 amd64
#   metapackage for AMD/ATI OpenCL-savvy BOINC client and manager
# --
# boinc-virtualbox/questing 8.2.5+dfsg-1 amd64
#   metapackage for virtualbox-savvy projects
# --
# breeze/questing 4:6.4.5-0ubuntu1 amd64
#   Default Plasma theme (Metapackage)
# --
# cairo-dock/questing 3.5.1-2build1 amd64
#   Metapackage for cairo-dock
# --
# cg3-dev/questing,questing 1.5.1-1 all
#   Metapackage providing both CG-3 CLI dev tools and dev library
# --
# charliecloud/questing,questing 0.38-3 all
#   user-defined software stacks (UDSS) for HPC centers (metapackage)
# --
# cloud-utils/questing,questing 0.33-1 all
#   metapackage for installation of upstream cloud-utils source
# --
# cuda-drivers-fabricmanager-535/questing 535.261.03-0ubuntu2 amd64
#   Meta-package for FM and Driver
# --
# cuda-drivers-fabricmanager-550/questing 550.163.01-0ubuntu3 amd64
#   Meta-package for FM and Driver
# --
# cuda-drivers-fabricmanager-570/questing 570.172.08-0ubuntu1 amd64
#   Meta-package for FM and Driver
# --
# cuda-drivers-fabricmanager-580/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   Meta-package for FM and Driver
# --
# debian-reference/questing,questing 2.128 all
#   metapackage to install (all) translations of Debian Reference
# --
# default-d-compiler/questing 0.6.10 amd64
#   Default D compiler (metapackage)
# --
# default-libmysqlclient-dev/questing 1.1.1ubuntu1 amd64
#   MySQL database development files (metapackage)
# --
# default-mysql-client/questing,questing 1.1.1ubuntu1 all
#   MySQL database client binaries (metapackage)
# --
# default-mysql-client-core/questing,questing 1.1.1ubuntu1 all
#   MySQL database core client binaries (metapackage)
# --
# default-mysql-server/questing,questing 1.1.1ubuntu1 all
#   MySQL database server binaries and system database setup (metapackage)
# --
# default-mysql-server-core/questing,questing 1.1.1ubuntu1 all
#   MySQL database server binaries (metapackage)
# --
# deluge/questing,questing 2.2.0-1 all
#   multi-interface BitTorrent client (metapackage)
# --
# designate/questing,questing 1:21.0.0-0ubuntu1 all
#   OpenStack DNS as a Service - metapackage
# --
# doc-rfc/questing,questing 20230121-1 all
#   RFC documents metapackage
# --
# dpf-plugins/questing 1.7+ds-3 amd64
#   Audio plugin collection from DISTRHO (metapackage)
# --
# dragonfly-reverb/questing,questing 3.2.10-3build1 all
#   Reverb effect plugins - metapackage
# --
# eiskaltdcpp/questing,questing 2.4.2-1.3 all
#   file sharing program using Direct Connect protocols (metapackage)
# --
# ejabberd-contrib/questing,questing 0.2025.01.11~dfsg0-2 all
#   user-contributed modules for ejabberd (metapackage)
# --
# emacs/questing,questing 1:30.1+1-9ubuntu1 all
#   GNU Emacs editor (metapackage)
# --
# evolution-data-server-dev/questing 3.56.2-3 amd64
#   Development files for evolution-data-server (metapackage)
# --
# exim4/questing,questing 4.98.2-1ubuntu2 all
#   metapackage to ease Exim MTA (v4) installation
# --
# fcitx-frontend-all/questing,questing 1:4.2.9.9-2build3 all
#   Flexible Input Method Framework - frontends metapackage
# --
# fcitx-libs/questing,questing 1:4.2.9.9-2build3 all
#   Flexible Input Method Framework - metapackage for libraries
# --
# fcitx-table-all/questing,questing 1:4.2.9.9-2build3 all
#   Flexible Input Method Framework - tables metapackage
# --
# fcitx5-chinese-addons/questing,questing 5.1.9-1 all
#   Chinese-related addon for fcitx5 (metapackage)
# --
# fcitx5-frontend-all/questing,questing 5.1.14-1 all
#   Fcitx Input Method Framework v5 (Frontend IM Module metapackage)
# --
# fis-gtm/questing 7.0-005-2.1 amd64
#   metapackage for the latest version of FIS-GT.M database
# --
# fonts-beng/questing,questing 2:1.3 all
#   Metapackage to install Bengali and Assamese fonts
# --
# fonts-dejavu/questing,questing 2.37-8 all
#   metapackage to pull in fonts-dejavu-core, -mono and -extra
# --
# fonts-noto/questing,questing 20201225-2 all
#   metapackage to pull in all Noto fonts
# --
# fonts-noto-hinted/questing,questing 20201225-2 all
#   obsolete metapackage to pull in a subset of Noto fonts
# --
# fonts-roboto/questing,questing 2:0~20170802-5 all
#   metapackage to pull in Roboto fonts
# --
# fonts-smc/questing,questing 1:7.5 all
#   Metapackage for various TrueType fonts for Malayalam Language
# --
# fonts-thai-tlwg/questing,questing 1:0.7.3-1 all
#   Thai fonts maintained by TLWG (metapackage)
# --
# fonts-thai-tlwg-otf/questing,questing 1:0.7.3-1 all
#   Thai OpenType fonts maintained by TLWG (metapackage)
# --
# fonts-thai-tlwg-ttf/questing,questing 1:0.7.3-1 all
#   Thai TrueType fonts maintained by TLWG (metapackage)
# --
# forensics-all/questing,questing 3.61 all
#   Debian Forensics Environment - essential components (metapackage)
# --
# forensics-all-gui/questing,questing 3.61 all
#   Debian Forensics Environment - GUI components (metapackage)
# --
# forensics-extra/questing,questing 2.58 all
#   Forensics Environment - extra console components (metapackage)
# --
# forensics-extra-gui/questing,questing 2.58 all
#   Forensics Environment - extra GUI components (metapackage)
# --
# forensics-full/questing,questing 2.58 all
#   Full forensics station (metapackage)
# --
# forensics-samples-all/questing,questing 1.1.4-5 all
#   Set of files to help learn/test forensics tools and techniques (metapackage)
# --
# freediameter/questing,questing 1.5.0-2 all
#   Implementation of the freeDiameter protocol - metapackage
# --
# freenect/questing 1:0.5.3-3.2build1 amd64
#   library for accessing Kinect device -- metapackage
# --
# gftp/questing,questing 2.9.1~beta-5 all
#   FTP client (metapackage)
# --
# gmtsar/questing,questing 6.5+ds-3 all
#   InSAR processing system based on Generic Mapping Tools - metapackage
# --
# gnokii/questing,questing 0.6.31+dfsg-5.1ubuntu4 all
#   Datasuite for mobile phone management (metapackage)
# --
# golang/questing 2:1.24~2 amd64
#   Go programming language compiler - metapackage
# --
# golang-1.23/questing-updates,questing-updates,questing-security,questing-security 1.23.10-1ubuntu0.2 all
#   Go programming language compiler - metapackage
# --
# golang-1.24/questing,questing 1.24.4-1ubuntu1 all
#   Go programming language compiler - metapackage
# --
# golang-1.25/questing,questing 1.25.0-0ubuntu1 all
#   Go programming language compiler - metapackage
# --
# gr-framework/questing 0.73.14+dfsg-1 amd64
#   Universal framework of Graphical Kernel System (GKS) and OpenGL (metapackage)
# --
# gr-framework-plugin-full/questing 0.73.14+dfsg-1 amd64
#   All plugins for Graphical Kernel System (GKS) and OpenGL (metapackage)
# --
# groonga/questing 15.1.5+dfsg-2 amd64
#   Fulltext search engine (metapackage for library use)
# --
# groonga-server-common/questing,questing 15.1.5+dfsg-2 all
#   Fulltext search engine (metapackage for server use)
# --
# groonga-server-gqtp/questing,questing 15.1.5+dfsg-2 all
#   Fulltext search engine (metapackage for GQTP server use)
# --
# groonga-server-http/questing,questing 15.1.5+dfsg-2 all
#   Fulltext search engine (metapackage for HTTP server use)
# --
# gvm/questing,questing 25.04.0 all
#   remote network security auditor - metapackage and useful scripts
# --
# i3/questing 4.24-1 amd64
#   metapackage (i3 window manager, screen locker, menu, statusbar)
# --
# ibus-table-cangjie/questing,questing 1.8.12-2 all
#   ibus-table input method: CangJie (metapackage)
# --
# icingaweb2-module-recommended/questing,questing 20210209-2 all
#   Metapackage to install icingaweb2 modules
# --
# idzebra-2.0/questing 2.2.8-1build1 amd64
#   IDZebra metapackage (the works)
# --
# init/questing,now 1.68 amd64 [installed]
#   metapackage ensuring an init system is installed
# --
# input-remapper/questing,questing 2.1.1-1 all
#   Input device button mapping tool (metapackage)
# --
# jenkins-job-builder/questing,questing 6.4.2-3 all
#   Configure Jenkins using YAML files - metapackage
# --
# jitterdebugger-all/questing 0.3.1+git20200117.b90ff3a-5 amd64
#   Real time response measurement tool - metapackage
# --
# jupyter/questing,questing 5.7.2-5 all
#   Interactive computing environment (metapackage)
# --
# kde-baseapps/questing 4:25.04.0+5.162ubuntu4 amd64
#   base applications from the official KDE release (metapackage)
# --
# libavcodec-extra/questing-updates,questing-security 7:7.1.1-1ubuntu4.1 amd64
#   FFmpeg library with extra codecs (metapackage)
# --
# libavfilter-extra/questing-updates,questing-security 7:7.1.1-1ubuntu4.1 amd64
#   FFmpeg library with extra filters (metapackage)
# --
# libavformat-extra/questing-updates,questing-security 7:7.1.1-1ubuntu4.1 amd64
#   FFmpeg library with extra (de)muxers (metapackage)
# --
# libcatalyst-modules-extra-perl/questing,questing 10 all
#   extra modules for Catalyst (metapackage)
# --
# libcatalyst-modules-perl/questing,questing 49 all
#   modules for Catalyst (metapackage)
# --
# libglib2.0-dev/questing 2.86.0-2 amd64
#   Development metapackage for the GLib family of libraries
# --
# libheif-plugins-all/questing 1.20.2-1 amd64
#   HEIF and AVIF file format decoder and encoder - plugins metapackage
# --
# libmkl-meta-cluster/questing 2020.4.304-6 amd64
#   Metapackage for Intel-MKL: Shared Object for Cluster
# --
# libmkl-meta-computational/questing 2020.4.304-6 amd64
#   Metapackage of intel-MKL: Shared Objects for Computaional Layer
# --
# libmkl-meta-interface/questing 2020.4.304-6 amd64
#   Metapackage of intel-MKL: Shared Objects of Interface Layer
# --
# libmkl-meta-threading/questing 2020.4.304-6 amd64
#   Metapackage of intel-MKL: Shared Objects of Threading Layer
# --
# libmono-i18n4.0-all/questing,questing 6.12.0.199+dfsg-6 all
#   Mono I18N libraries metapackage (for CLI 4.0)
# --
# libosmocore/questing 1.11.0-2 amd64
#   Open Source MObile COMmunications CORE library (metapackage)
# --
# libreoffice/questing-updates 4:25.8.2-0ubuntu0.25.10.1 amd64
#   office productivity suite (metapackage)
# --
# libreoffice-nogui/questing-updates 4:25.8.2-0ubuntu0.25.10.1 amd64
#   office productivity suite (metapackage, no GUI)
# --
# libtask-kensho-all-perl/questing,questing 0.41-2 all
#   provides all Task::Kensho tasks (metapackage)
# --
# libxine2/questing 1.2.13+hg20240723-3build1 amd64
#   xine media player library – metapackage
# --
# libxine2-all-plugins/questing,questing 1.2.13+hg20240723-3build1 all
#   xine video/media player library ‒ metapackage for all plugins
# --
# libxine2-plugins/questing,questing 1.2.13+hg20240723-3build1 all
#   xine video/media player library ‒ metapackage for commonly-used plugins
# --
# lilypond-doc/questing,questing 2.24.4-5 all
#   LilyPond Documentation in info format (and metapackage)
# --
# live-manual/questing,questing 2:20250226 all
#   Debian Live Documentation (metapackage)
# --
# lsp-plugins/questing 1.2.23-0ubuntu1 amd64
#   LSP (Linux Studio Plugins) audio-plugins (metapackage)
# --
# lxde/questing,questing 13.0 all
#   metapackage for LXDE
# --
# lxde-core/questing,questing 13.0 all
#   metapackage for the LXDE core
# --
# lxqt/questing 32ubuntu1 amd64
#   Metapackage for LXQt
# --
# lxqt-core/questing,questing 32ubuntu1 all
#   Metapackage for the LXQt core
# --
# mailman3-full/questing,questing 3.3.10-0ubuntu3 all
#   Full Mailman3 mailing list management suite (metapackage)
# --
# mate-desktop-environment/questing,questing 1.26.0+2 all
#   MATE Desktop Environment (metapackage)
# --
# mate-desktop-environment-core/questing,questing 1.26.0+2 all
#   MATE Desktop Environment (essential components, metapackage)
# --
# mate-desktop-environment-extras/questing,questing 1.26.0+2 all
#   MATE Desktop Environment (extra components, metapackage)
# --
# mir-graphics-drivers-desktop/questing 2.20.2-2ubuntu4 amd64
#   Mir Display Server - desktop driver metapackage
# --
# mir-graphics-drivers-nvidia/questing 2.20.2-2ubuntu4 amd64
#   Mir Display Server - Nvidia driver metapackage
# --
# mir-platform-graphics-atomic-kms/questing 2.20.2-2ubuntu4 amd64
#   Mir Display Server - atomic-kms driver metapackage
# --
# mir-platform-graphics-eglstream-kms/questing 2.20.2-2ubuntu4 amd64
#   Mir Display Server - eglstream-kms driver metapackage
# --
# mir-platform-graphics-gbm-kms/questing 2.20.2-2ubuntu4 amd64
#   Mir Display Server - gbm-kms driver metapackage
# --
# mir-platform-graphics-virtual/questing 2.20.2-2ubuntu4 amd64
#   Mir Display Server - virtual display provider metapackage
# --
# mir-platform-graphics-wayland/questing 2.20.2-2ubuntu4 amd64
#   Mir Display Server - wayland driver metapackage
# --
# mir-platform-graphics-x/questing 2.20.2-2ubuntu4 amd64
#   Mir Display Server - x driver metapackage
# --
# mir-platform-rendering-egl-generic/questing 2.20.2-2ubuntu4 amd64
#   Mir Display Server - EGL rendering provider metapackage
# --
# monitoring-plugins/questing,questing 2.4.0-1ubuntu1 all
#   Plugins for nagios compatible monitoring systems (metapackage)
# --
# mpi-default-bin/questing 1.18 amd64
#   Standard MPI runtime programs (metapackage)
# --
# mpi-default-dev/questing 1.18 amd64
#   Standard MPI development files (metapackage)
# --
# mythplugins/questing,questing 2:35.0+fixes.20250302.f3f012aa3f-0ubuntu4 all
#   Metapackage package for MythTV plugins
# --
# mythtv-backend-master/questing,questing 2:35.0+fixes.20250302.f3f012aa3f-0ubuntu4 all
#   Metapackage to setup and configure a "Master Backend" profile of MythTV
# --
# nextepc/questing,questing 0.3.10+nods-4.3 all
#   Evolved Packet Core implementation for LTE (metapackage)
# --
# nut/questing,questing 2.8.3-2 all
#   network UPS tools - metapackage
# --
# nvidia-driver-535-server/questing 535.261.03-0ubuntu2 amd64
#   NVIDIA Server Driver metapackage (transitional package)
# --
# nvidia-driver-535-server-open/questing 535.261.03-0ubuntu2 amd64
#   NVIDIA Server Driver metapackage (transitional package)
# --
# nvidia-driver-550/questing 550.107.02-0ubuntu3 amd64
#   NVIDIA Server Driver metapackage (transitional package)
# --
# nvidia-driver-550-open/questing 550.107.02-0ubuntu3 amd64
#   NVIDIA Server Driver metapackage (transitional package)
# --
# nvidia-driver-550-server/questing 550.163.01-0ubuntu4 amd64
#   NVIDIA Server Driver metapackage
# --
# nvidia-driver-550-server-open/questing 550.163.01-0ubuntu4 amd64
#   NVIDIA driver (open kernel) metapackage
# --
# nvidia-driver-560/questing 560.35.03-0ubuntu7.2 amd64
#   NVIDIA Server Driver metapackage (transitional package)
# --
# nvidia-driver-560-open/questing 560.35.03-0ubuntu7.2 amd64
#   NVIDIA Server Driver metapackage (transitional package)
# --
# nvidia-driver-570/questing 570.172.08-0ubuntu3 amd64
#   NVIDIA Server Driver metapackage
# --
# nvidia-driver-570-open/questing 570.172.08-0ubuntu3 amd64
#   NVIDIA driver (open kernel) metapackage
# --
# nvidia-driver-570-server/questing 570.172.08-0ubuntu2 amd64
#   NVIDIA Server Driver metapackage
# --
# nvidia-driver-570-server-open/questing 570.172.08-0ubuntu2 amd64
#   NVIDIA driver (open kernel) metapackage
# --
# nvidia-driver-575/questing 575.64.03-0ubuntu4 amd64
#   NVIDIA Server Driver metapackage
# --
# nvidia-driver-575-open/questing 575.64.03-0ubuntu4 amd64
#   NVIDIA driver (open kernel) metapackage
# --
# nvidia-driver-580/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   NVIDIA driver metapackage
# --
# nvidia-driver-580-open/questing-updates,questing-security,now 580.95.05-0ubuntu1 amd64 [installed]
#   NVIDIA driver (open kernel) metapackage
# --
# nvidia-driver-580-server/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   NVIDIA Server Driver metapackage
# --
# nvidia-driver-580-server-open/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   NVIDIA driver (open kernel) metapackage
# --
# nvidia-headless-535-server/questing 535.261.03-0ubuntu2 amd64
#   NVIDIA headless metapackage (transitional package)
# --
# nvidia-headless-535-server-open/questing 535.261.03-0ubuntu2 amd64
#   NVIDIA headless metapackage (transitional package)
# --
# nvidia-headless-550/questing 550.107.02-0ubuntu3 amd64
#   NVIDIA headless metapackage (transitional package)
# --
# nvidia-headless-550-open/questing 550.107.02-0ubuntu3 amd64
#   NVIDIA headless metapackage (transitional package)
# --
# nvidia-headless-550-server/questing 550.163.01-0ubuntu4 amd64
#   NVIDIA headless metapackage
# --
# nvidia-headless-550-server-open/questing 550.163.01-0ubuntu4 amd64
#   NVIDIA headless metapackage (open kernel module)
# --
# nvidia-headless-560/questing 560.35.03-0ubuntu7.2 amd64
#   NVIDIA headless metapackage (transitional package)
# --
# nvidia-headless-560-open/questing 560.35.03-0ubuntu7.2 amd64
#   NVIDIA headless metapackage (transitional package)
# --
# nvidia-headless-570/questing 570.172.08-0ubuntu3 amd64
#   NVIDIA headless metapackage
# --
# nvidia-headless-570-open/questing 570.172.08-0ubuntu3 amd64
#   NVIDIA headless metapackage (open kernel module)
# --
# nvidia-headless-570-server/questing 570.172.08-0ubuntu2 amd64
#   NVIDIA headless metapackage
# --
# nvidia-headless-570-server-open/questing 570.172.08-0ubuntu2 amd64
#   NVIDIA headless metapackage (open kernel module)
# --
# nvidia-headless-575/questing 575.64.03-0ubuntu4 amd64
#   NVIDIA headless metapackage
# --
# nvidia-headless-575-open/questing 575.64.03-0ubuntu4 amd64
#   NVIDIA headless metapackage (open kernel module)
# --
# nvidia-headless-580/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   NVIDIA headless metapackage
# --
# nvidia-headless-580-open/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   NVIDIA headless metapackage (open kernel module)
# --
# nvidia-headless-580-server/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   NVIDIA headless metapackage
# --
# nvidia-headless-580-server-open/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   NVIDIA headless metapackage (open kernel module)
# --
# nvidia-headless-no-dkms-535-server/questing 535.261.03-0ubuntu2 amd64
#   NVIDIA headless metapackage - no DKMS (transitional package)
# --
# nvidia-headless-no-dkms-535-server-open/questing 535.261.03-0ubuntu2 amd64
#   NVIDIA headless metapackage - no DKMS (transitional package)
# --
# nvidia-headless-no-dkms-550/questing 550.107.02-0ubuntu3 amd64
#   NVIDIA headless metapackage - no DKMS (transitional package)
# --
# nvidia-headless-no-dkms-550-open/questing 550.107.02-0ubuntu3 amd64
#   NVIDIA headless metapackage - no DKMS (transitional package)
# --
# nvidia-headless-no-dkms-550-server/questing 550.163.01-0ubuntu4 amd64
#   NVIDIA headless metapackage - no DKMS
# --
# nvidia-headless-no-dkms-550-server-open/questing 550.163.01-0ubuntu4 amd64
#   NVIDIA headless metapackage - no DKMS (open kernel module)
# --
# nvidia-headless-no-dkms-560/questing 560.35.03-0ubuntu7.2 amd64
#   NVIDIA headless metapackage - no DKMS (transitional package)
# --
# nvidia-headless-no-dkms-560-open/questing 560.35.03-0ubuntu7.2 amd64
#   NVIDIA headless metapackage - no DKMS (transitional package)
# --
# nvidia-headless-no-dkms-570/questing 570.172.08-0ubuntu3 amd64
#   NVIDIA headless metapackage - no DKMS
# --
# nvidia-headless-no-dkms-570-open/questing 570.172.08-0ubuntu3 amd64
#   NVIDIA headless metapackage - no DKMS (open kernel module)
# --
# nvidia-headless-no-dkms-570-server/questing 570.172.08-0ubuntu2 amd64
#   NVIDIA headless metapackage - no DKMS
# --
# nvidia-headless-no-dkms-570-server-open/questing 570.172.08-0ubuntu2 amd64
#   NVIDIA headless metapackage - no DKMS (open kernel module)
# --
# nvidia-headless-no-dkms-575/questing 575.64.03-0ubuntu4 amd64
#   NVIDIA headless metapackage - no DKMS
# --
# nvidia-headless-no-dkms-575-open/questing 575.64.03-0ubuntu4 amd64
#   NVIDIA headless metapackage - no DKMS (open kernel module)
# --
# nvidia-headless-no-dkms-580/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   NVIDIA headless metapackage - no DKMS
# --
# nvidia-headless-no-dkms-580-open/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   NVIDIA headless metapackage - no DKMS (open kernel module)
# --
# nvidia-headless-no-dkms-580-server/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   NVIDIA headless metapackage - no DKMS
# --
# nvidia-headless-no-dkms-580-server-open/questing-updates,questing-security 580.95.05-0ubuntu1 amd64
#   NVIDIA headless metapackage - no DKMS (open kernel module)
# --
# ocaml-batteries-included/questing,questing 3.9.0-1build3 all
#   Batteries included: OCaml development platform - metapackage
# --
# ocaml-core/questing,questing 5 all
#   OCaml core tools (metapackage)
# --
# ocaml-libs/questing,questing 5 all
#   OCaml core libraries (metapackage)
# --
# ocaml-platform/questing,questing 5 all
#   OCaml Platform (metapackage)
# --
# open-font-design-toolkit/questing,questing 1.9 all
#   metapackage for open font design
# --
# openrazer-meta/questing,questing 3.10.3+dfsg-2 all
#   OpenRazer peripheral drivers (metapackage)
# --
# parser3/questing,questing 3.5.1-3 all
#   Parser 3, HTML-embedded scripting language (metapackage)
# --
# peace-look/questing,questing 0.2-0ubuntu2 all
#   Peace look - metapackage
# --
# pgtap/questing,questing 1.3.3-3 all
#   Unit testing framework for PostgreSQL - metapackage
# --
# phonon4qt5/questing 4:4.12.0-5 amd64
#   multimedia framework from KDE using Qt 5 - metapackage
# --
# phonon4qt6/questing 4:4.12.0-5 amd64
#   multimedia framework from KDE using Qt 6 - metapackage
# --
# php8.4/questing,questing 8.4.11-1ubuntu1 all
#   server-side, HTML-embedded scripting language (metapackage)
# --
# pike8.0/questing,questing 8.0.1956-1 all
#   Recommended metapackage for Pike 8.0
# --
# pike8.0-full/questing,questing 8.0.1956-1 all
#   Metapackage for Pike 8.0
# --
# plaso/questing,questing 20241006-3 all
#   super timeline all the things -- metapackage
# --
# pluma-plugins/questing 1.27.0-3build2 amd64
#   set of plugins for pluma (metapackage)
# --
# postgresql-all/questing,questing 282ubuntu1 all
#   metapackage depending on all PostgreSQL server packages
# --
# postgresql-pgrouting/questing 3.7.3-1 amd64
#   Routing functionality support for PostgreSQL/PostGIS - Metapackage
# --
# postgresql-pgrouting-scripts/questing,questing 3.7.3-1 all
#   Routing functionality support for PostgreSQL/PostGIS - SQL scripts metapackage
# --
# postgresql-postgis/questing 3.5.3+dfsg-2build1 amd64
#   Geographic objects support for PostgreSQL -- Metapackage
# --
# postgresql-postgis-scripts/questing,questing 3.5.3+dfsg-2build1 all
#   Geographic objects support for PostgreSQL -- SQL scripts metapackage
# --
# printer-driver-all/questing,questing 0.20210903 all
#   printer drivers metapackage
# --
# printer-driver-all-enforce/questing,questing 0.20210903 all
#   printer drivers metapackage - enforcing version
# --
# pybuild-plugin-autopkgtest/questing,questing 6.20250414 all
#   pybuild autopkgtest test runner (metapackage)
# --
# python3-ceph/questing,questing 19.2.1-0ubuntu3 all
#   Meta-package for all Python 3.x modules for the Ceph libraries
# --
# python3-qtpy-pyqt5/questing,questing 2.4.3-1 all
#   Abstraction layer for Qt (PyQt5 minimal metapackage)
# --
# python3-qtpy-pyqt6/questing,questing 2.4.3-1 all
#   Abstraction layer for Qt (PyQt6 metapackage)
# --
# python3-qtpy-pyside6/questing,questing 2.4.3-1 all
#   Abstraction layer for Qt (PySide6 metapackage)
# --
# qtcurve/questing 1.9-7.1build1 amd64
#   unified widget styles for Qt and GTK+ applications (metapackage)
# --
# r-recommended/questing,questing 4.5.1-1 all
#   GNU R collection of recommended packages [metapackage]
# --
# rails/questing,questing 2:7.2.2.1+dfsg-7 all
#   MVC ruby based framework geared for web application development (metapackage)
# --
# redict/questing-updates,questing-updates,questing-security,questing-security 7.3.5+ds-1ubuntu0.2 all
#   Persistent key-value database with network interface (metapackage)
# --
# redis/questing-updates,questing-updates,questing-security,questing-security 5:8.0.2-3ubuntu0.25.10.1 all
#   Persistent key-value database with network interface (metapackage)
# --
# repmgr/questing,questing 5.5.0+debpgdg-1build1 all
#   replication manager for PostgreSQL (metapackage)
# --
# robot-testing-framework/questing 2.0.1+ds1-3ubuntu4 amd64
#   Robot Testing Framework (metapackage)
# --
# roundcube/questing,questing 1.6.11+dfsg-1 all
#   skinnable AJAX based webmail solution for IMAP servers - metapackage
# --
# roundcube-mysql/questing,questing 1.6.11+dfsg-1 all
#   metapackage providing MySQL dependencies for RoundCube
# --
# roundcube-pgsql/questing,questing 1.6.11+dfsg-1 all
#   metapackage providing PostgreSQL dependencies for RoundCube
# --
# roundcube-sqlite3/questing,questing 1.6.11+dfsg-1 all
#   metapackage providing SQLite dependencies for RoundCube
# --
# rtpengine/questing,questing 12.5.1.38-1 all
#   NGCP RTP/media proxy - metapackage
# --
# ruby-rspec/questing,questing 3.13.0c0e0m0s1-2 all
#   Behaviour Driven Development framework for Ruby - metapackage
# --
# sendmail/questing,questing 8.18.1-6 all
#   powerful, efficient, and scalable Mail Transport Agent (metapackage)
# --
# sequoia-chameleon-gnupg/questing,questing 0.13.1-3 all
#   Sequoia's GnuPG CLI tools (metapackage)
# --
# sigrok/questing,questing 0.3 all
#   Logic analyzer and protocol decoder software suite (metapackage)
# --
# slurm-wlm-plugins/questing 24.11.5-4 amd64
#   Slurm free plugins (metapackage)
# --
# slurm-wlm-plugins-dev/questing 24.11.5-4 amd64
#   Slurm free plugins development files (metapackage)
# --
# snd/questing,questing 25.6-1 all
#   Sound file editor (metapackage)
# --
# soapysdr-module-all/questing 0.8.1-5build1 amd64
#   All device support for default version of SoapySDR (metapackage)
# --
# soapysdr0.8-module-all/questing 0.8.1-5build1 amd64
#   All device support for SoapySDR (metapackage)
# --
# ssh/questing,questing 1:10.0p1-5ubuntu5 all
#   secure shell client and server (metapackage)
# --
# ssh-contact/questing,questing 0.7-1.1build4 all
#   establish SSH connections to your IM contacts using Telepathy (metapackage)
# --
# sssd/questing,now 2.10.1-2ubuntu5 amd64 [installed,automatic]
#   System Security Services Daemon -- metapackage
# --
# steam-libs/questing 1:1.0.0.83~ds-3 amd64
#   Metapackage for Steam dependencies
# --
# steam-libs-i386/questing 1:1.0.0.83~ds-3 i386
#   Metapackage for 32-bit Steam dependencies
# --
# stressant-meta/questing,questing 0.7.0 all
#   stress-testing, benchmarking and recovery tools (meta-package)
# --
# strongswan/questing-updates,questing-updates,questing-security,questing-security 6.0.1-6ubuntu4.1 all
#   IPsec VPN solution metapackage
# --
# supercollider/questing 1:3.13.0+repack-3ubuntu1 amd64
#   real time audio synthesis programming language - metapackage
# --
# syslog-ng/questing,questing 4.8.1-6 all
#   Enhanced system logging daemon (metapackage)
# --
# tachyon/questing,questing 0.99~b6+dsx-16 all
#   Parallel/Multiprocessor Standalone Ray Tracer - metapackage
# --
# tdiary/questing,questing 5.3.0-2 all
#   Metapackages of tDiary
# --
# testrepository/questing,questing 0.0.21-3 all
#   unit test system with database of test results - metapackage and doc
# --
# texlive-full/questing,questing 2024.20250309-1 all
#   TeX Live: metapackage pulling in all components of TeX Live
# --
# texlive-lang-all/questing,questing 2024.20250309-1 all
#   TeX Live: metapackage depending on all TeX Live language packages
# --
# tropic-look/questing,questing 0.2-0ubuntu2 all
#   Tropic look - metapackage
# --
# tryton-modules-all/questing,questing 56 all
#   Tryton application platform - Tryton modules metapackage
# --
# ubuntu-budgie-desktop/questing 0.139 amd64
#   Ubuntu Budgie metapackage
# --
# ubuntu-packaging-guide/questing,questing 1.0.4 all
#   Ubuntu Packaging Guide - metapackage
# --
# ubuntustudio-pulseaudio-config/questing,questing 25.10.9 all
#   Transitional Metapackage PulseAudio > PipeWire Config
# --
# uim-anthy/questing,questing 1:1.9.6-1build2 all
#   Universal Input Method - Anthy support metapackage
# --
# uim-byeoru/questing,questing 1:1.9.6-1build2 all
#   Universal Input Method - byeoru hangul input support metapackage
# --
# uim-ipa-x-sampa/questing,questing 1:1.9.6-1build2 all
#   Universal Input Method - X-SAMPA IPA input support metapackage
# --
# uim-latin/questing,questing 1:1.9.6-1build2 all
#   Universal Input Method - Latin script input support metapackage
# --
# uim-look/questing,questing 1:1.9.6-1build2 all
#   Universal Input Method - Dictionary-based completion input support metapackage
# --
# uim-m17nlib/questing,questing 1:1.9.6-1build2 all
#   Universal Input Method - m17nlib plugin metapackage
# --
# uim-pinyin/questing,questing 1:1.9.6-1build2 all
#   Universal Input Method - pinyin input support metapackage
# --
# uim-skk/questing,questing 1:1.9.6-1build2 all
#   Universal Input Method - SKK support metapackage
# --
# uim-tcode/questing,questing 1:1.9.6-1build2 all
#   Universal Input Method - T-Code support metapackage
# --
# uim-viqr/questing,questing 1:1.9.6-1build2 all
#   Universal Input Method - Vietnamese Quoted-Readable support metapackage
# --
# ukui-desktop-environment/questing,questing 3.0.4 all
#   UKUI Desktop Environment (metapackage)
# --
# ukui-desktop-environment-core/questing,questing 3.0.4 all
#   UKUI Desktop Environment (essential components, metapackage)
# --
# ukui-desktop-environment-extras/questing,questing 3.0.4 all
#   UKUI Desktop Environment (extra components, metapackage)
# --
# va-driver-all/questing 2.22.0-3ubuntu3 amd64
#   Video Acceleration (VA) API -- driver metapackage
# --
# vanilla-gnome-desktop/questing 0.102 amd64
#   Vanilla GNOME metapackage
# --
# vdpau-driver-all/questing,now 1.5-3 amd64 [installed,automatic]
#   Video Decode and Presentation API for Unix (driver metapackage)
# --
# vitrage-common/questing,questing 15.0.0-0ubuntu1 all
#   OpenStack RCA as a Service - metapackage
# --
# vuos/questing 0.9.2-1 amd64
#   Virtual Operating System at user space metapackage
# --
# weechat/questing,questing 4.6.3-1build1 all
#   Fast, light and extensible chat client (metapackage)
# --
# wesnoth/questing,questing 1:1.18.5-1build2 all
#   fantasy turn-based strategy game (metapackage)
# --
# wesnoth-music/questing,questing 1:1.18.5-1build2 all
#   music files for Wesnoth (metapackage)
# --
# wireguard/questing,questing 1.0.20210914-3ubuntu2 all
#   fast, modern, secure kernel VPN tunnel (metapackage)
# --
# x2gothinclient-chroot/questing,questing 1.5.0.1-10.2 all
#   Install X2Go Thin Client chroot (metapackage)
# --
# xbase-clients/questing,questing 1:7.7+24ubuntu1 all
#   miscellaneous X clients - metapackage
# --
# xemacs21/questing,questing 21.4.24-12build3 all
#   highly customizable text editor metapackage
# --
# xen-system-amd64/questing 4.20.0+68-g35cb38b222-1 amd64
#   Xen System on AMD64 (metapackage)
# --
# xfce4/questing,questing 4.20.1 all
#   Meta-package for the Xfce Lightweight Desktop Environment
# --
# xfonts-thai/questing,questing 1:1.2.7-6 all
#   Collection of Thai fonts for X (metapackage)
# --
# xnee/questing,questing 3.19-9.2 all
#   X event recorder/replayer - metapackage
# --
# xserver-xorg-input-all/questing 1:7.7+24ubuntu1 amd64
#   X.Org X server -- input driver metapackage
# --
# xserver-xorg-video-all/questing 1:7.7+24ubuntu1 amd64
#   X.Org X server -- output driver metapackage
# --
# xutils/questing,questing 1:7.7+24ubuntu1 all
#   X Window System utility programs metapackage
# --
# zeroc-ice-all-dev/questing,questing 3.7.10-3.1 all
#   Ice development packages (metapackage)
# --
# zeroc-ice-all-runtime/questing,questing 3.7.10-3.1 all
#   Ice run-time packages (metapackage)
