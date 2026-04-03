.DEFAULT_GOAL := start

MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: start inject-machine-tarball disk nuke

start:
	./start.sh

inject-machine-tarball:
	tar -cvzf "$(MAKEFILE_DIR)/../../share/machine.tgz" -C "$(MAKEFILE_DIR)/../../.." dotfiles features

disk:
	qemu-img create -f qcow2 disk.qcow2 80G
	qemu-img info disk.qcow2

nuke:
	rm -f disk.qcow2
