#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_GROUP_LIST="dnf group list --hidden"
CMD_GROUP_INFO="dnf group info group-name"


########
# EXEC #
########
echo -e "\n\n🔌 Executing...\n";
${CMD_GROUP_LIST}


########
# DONE #
########
echo -e "\n\n✅ To know what's inside a group use:\n\t $CMD_GROUP_INFO\n";
exit 0;


# ID                           Name
# network-server               Network Servers
# lxqt-media                   Multimedia support for LXQt
# lxqt-office                  LXQt Office
# mail-server                  Mail Server
# mate-applications            MATE Applications
# mate-desktop                 MATE
# milkymist                    Milkymist
# mingw32                      MinGW cross-compiler
# miraclewm-desktop            Miracle Window Manager Desktop
# multimedia                   Multimedia
# mysql                        MariaDB (MySQL) Database
# lxqt-l10n                    Translations of LXQt
# networkmanager-submodules    Common NetworkManager Submodules
# neuron-modelling-simulators  Neuron Modelling Simulators
# news-server                  News Server
# ocaml                        OCaml
# office                       Office/Productivity
# perl                         Perl Development
# perl-web                     Perl for Web
# phosh-desktop                A phone/tablet UX environment
# php                          PHP
# legacy-network-server        Legacy Network Server
# kde-media                    KDE Multimedia support
# kde-mobile                   KDE Mobile
# kde-mobile-apps              KDE Mobile Apps
# kde-office                   KDE Office
# kde-pim                      KDE PIM
# kde-software-development     KDE Software Development
# kde-spin-initial-setup       KDE Spin Initial Setup
# kf6-software-development     KDE Frameworks 6 Software Development
# legacy-fonts                 Legacy Fonts
# platform-vmware              VMware Platform Support
# libreoffice                  LibreOffice
# libreoffice-development      LibreOffice Development
# load-balancer                Load Balancer
# lxde-apps                    Applications for the LXDE Desktop
# lxde-desktop                 LXDE
# lxde-media                   Multimedia support for LXDE
# lxde-office                  LXDE Office
# lxqt-apps                    Applications for the LXQt Desktop
# lxqt-desktop                 LXQt
# workstation-product          Fedora Workstation product core
# text-internet                Text-based Internet
# tomcat                       Tomcat
# vagrant                      Vagrant with libvirt support
# virtualization               Virtualization
# virtualization-headless      Headless Virtualization
# vlc                          VideoLAN Client
# web-server                   Basic Web Server
# window-managers              Window Managers
# workstation-ostree-support   Fedora Workstation ostree support
# system-tools                 System Tools
# x-software-development       X Software Development
# xfce-apps                    Applications for the Xfce Desktop
# xfce-desktop                 Xfce
# xfce-extra-plugins           Extra plugins for the Xfce panel
# xfce-media                   Multimedia support for Xfce
# xfce-office                  Xfce Office
# xfce-software-development    Xfce Software Development
# xmonad                       XMonad
# xmonad-mate                  XMonad for MATE
# server-hardware-support      Hardware Support for Server Systems
# printing                     Printing Support
# python-classroom             Python Classroom
# python-science               Python Science
# robotics-suite               Robotics
# rpm-development-tools        RPM Development Tools
# ruby                         Ruby
# rubyonrails                  Ruby on Rails
# security-lab                 Security Lab
# server-cfg                   Server Configuration Tools
# kde-education                KDE Educational applications
# server-product               Fedora Server product core
# smb-server                   Windows File Server
# sound-and-video              Sound and Video
# sql-server                   PostgreSQL Database
# standard                     Standard
# sugar-apps                   Additional Sugar Activities
# sugar-desktop                Sugar Desktop Environment
# swaywm                       Sway Window Manager
# swaywm-extended              Sway Window Manager (supplemental packages)
# critical-path-lxqt           Critical Path (LXQt)
# cosmic-desktop-apps          COSMIC Desktop Supplementary Applications
# critical-path-anaconda       Critical Path (anaconda)
# critical-path-apps           Critical Path (Applications)
# critical-path-base           Critical Path (Base)
# critical-path-build          Critical Path (Build)
# critical-path-compose        Critical Path (Compose)
# critical-path-deepin-desktop Critical Path (Deepin desktop)
# critical-path-gnome          Critical Path (GNOME)
# critical-path-kde            Critical Path (KDE)
# critical-path-lxde           Critical Path (LXDE)
# cosmic-desktop               COSMIC Desktop
# critical-path-server         Critical Path (Server)
# critical-path-standard       Critical Path (standard)
# critical-path-xfce           Critical Path (Xfce)
# d-development                D Development Tools and Libraries
# deepin-desktop               Deepin Desktop Environment
# deepin-desktop-apps          Deepin Desktop Applications
# deepin-desktop-media         Media packages for Deepin Desktop
# deepin-desktop-office        Deepin Desktop Office
# design-suite                 Design Suite
# buildsys-build               Buildsystem building group
# admin-tools                  Administration Tools
# anaconda-tools               Anaconda tools
# audio                        Audio Production
# authoring-and-publishing     Authoring and Publishing
# base-graphical               base-graphical
# base-x                       base-x
# basic-desktop                Basic Desktop
# budgie-desktop               Budgie
# budgie-desktop-apps          Budgie Desktop Applications
# desktop-accessibility        Desktop accessibility
# c-development                C Development Tools and Libraries
# cinnamon-desktop             Cinnamon
# cloud-bootloader-tools       Bootloader tools for Cloud images
# cloud-infrastructure         Cloud Infrastructure
# cloud-management             Cloud Management Tools
# cloud-server                 Cloud Server Tools
# compiz                       Compiz
# container-management         Container Management
# core                         Core
# haskell                      Haskell
# gnome-software-development   GNOME Software Development
# gnome-games                  Extra games for the GNOME Desktop
# graphical-internet           Graphical Internet
# graphics                     Graphics
# guest-agents                 Guest Agents
# guest-desktop-agents         Guest Desktop Agents
# ha                           High Availability
# haproxy                      HAProxy
# hardware-support             Hardware Support
# gnome-desktop                GNOME
# headless-management          Headless Management
# i3                           i3 window manager
# i3-extended                  i3 window manager (supplemental packages)
# input-methods                Input Methods
# java                         Java
# java-development             Java Development
# javaenterprise               Java Application Server
# kde-apps                     KDE Applications
# kde-desktop                  KDE
# electronic-lab               Electronic Lab
# development-tools            Development Tools
# development-libs             Development Libraries
# dial-up                      Dial-up Networking Support
# directory-server             Directory Server
# dns-server                   DNS Name Server
# dogtag                       Dogtag Certificate System
# domain-client                Domain Membership
# editors                      Editors
# education                    Educational Software
# 3d-printing                  3D Printing
# engineering-and-scientific   Engineering and Scientific
# enlightenment-desktop        Enlightenment
# fedora-packager              Fedora Packager
# firefox                      Firefox Web Browser
# font-design                  Font design and packaging
# fonts                        Fonts
# freeipa-server               FreeIPA Server
# ftp-server                   FTP Server
# games                        Games and Entertainment
