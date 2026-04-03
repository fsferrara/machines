.PHONY: start disk

start:
	./start.sh

disk:
	qemu-img create -f qcow2 disk.qcow2 80G
	qemu-img info disk.qcow2

nuke:
	rm -f disk.qcow2
