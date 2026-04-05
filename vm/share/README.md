# QEMU Shared Folder

QEMU allows to share folders in two different ways: VirtFS or WebDAV.
I use VirtFS.

## VirtFS

VirtFS is really stable and performant. When starting QEMU it need an option like this one:

```shell
-virtfs local,path=../../share,mount_tag=share,security_model=none,id=share,readonly=off
```

### Mounting the shared folder in the guest
Then, in the guest `/etc/fstab` add this line:

```shell
share   /mnt/share      9p      trans=virtio,version=9p2000.L,rw,_netdev,nofail,users   0       0
```

### Permissions

With `security_model=none` the guest writes files with the same permissions as the host user that started QEMU.
I usually create a VM user with the same UID and GID as the host user, so that permissions are consistent between host and guest.

```shell
export USERNAME=user
export USER_UID=1010
export USER_GID=1010
groupadd --gid "${USER_GID}" "${USERNAME}"
useradd --uid "${USER_UID}" --gid "${USER_GID}" -m -s /bin/zsh "${USERNAME}"
```
