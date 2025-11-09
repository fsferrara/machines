# QEMU Ubuntu Server Development

This is a guide to create a local development server.

## Install the guest

Download the `ubuntu-22.04.2-live-server-amd64.iso` image and install it in a VM.

Check the option to install the ssh server. In alternative, install it `sudo apt-get install openssh-server`.

User access with `user/password` and the user has sudo access.

### Additional user

To create a custom user, with custom uid/gid, execute:

```shell
export CUST_USR="fsferrara"
export CUST_USR_UID="1000"
export CUST_USR_GID="1000"

sudo adduser --uid ${CUST_USR_UID} --gid ${CUST_USR_GID} --add_extra_groups ${CUST_USR}

sudo usermod -a -G dialout ${CUST_USR}
sudo usermod -a -G cdrom ${CUST_USR}
sudo usermod -a -G floppy ${CUST_USR}
sudo usermod -a -G audio ${CUST_USR}
sudo usermod -a -G video ${CUST_USR}
sudo usermod -a -G plugdev ${CUST_USR}
sudo usermod -a -G users ${CUST_USR}
sudo usermod -a -G adm ${CUST_USR}
sudo usermod -a -G cdrom ${CUST_USR}
sudo usermod -a -G sudo ${CUST_USR}
sudo usermod -a -G dip ${CUST_USR}
sudo usermod -a -G plugdev ${CUST_USR}
sudo usermod -a -G lxd ${CUST_USR}
sudo usermod -a -G davfs2 ${CUST_USR}
```

Then log as `root` and swap directories/permissions of `/home/fsferrara` and `/home/user`

### Custom hostname

`sudo hostnamectl set-hostname EXPC02D60XTMD6V`

## Environment variables

Export those env variables in both host and guest

```sh
export GUEST_IP="192.168.64.10"
export HOST_IP="192.168.64.1"
export MACHINES="${HOME}/github/fsferrara/machines"
```

## VM Configuration

Execute in this order: Host Setup, Guest Setup, Exp Setup

### Host Setup

- [host-000-ssh-setup.sh](./host-000-ssh-setup.sh)
- [host-010-install-machines.sh](./host-010-install-machines.sh)

### Guest Setup

- [000-create-default-directories.sh](./000-create-default-directories.sh)
- [001-passwordless-sudo.sh](./001-passwordless-sudo.sh)
- [010-install-essentials.sh](./010-install-essentials.sh)
- [011-install-vm-essentials.sh](./011-install-vm-essentials.sh)
- [012-setup-spice-share.sh](./012-setup-spice-share.sh)
- [020-install-zsh.sh](./020-install-zsh.sh)
- [021-install-oh-my-zsh.sh](./021-install-oh-my-zsh.sh)
- [030-vim.sh](./030-vim.sh)
- [040-my-shell-conf.sh](./040-my-shell-conf.sh)
- [041-my-git-conf.sh](./041-my-git-conf.sh)
- [042-my-other-conf.sh](./042-my-other-conf.sh)
- [050-install-nerdfonts.sh](./050-install-nerdfonts.sh)
- [060-install-sdkman.sh](./060-install-sdkman.sh)
- [061-install_java.sh](./061-install_java.sh)
- [070-aws-cli.sh](./070-aws-cli.sh)
- [071-aws-saml2aws.sh](./071-aws-saml2aws.sh)

### Guest Setup

- [072-aws-saml2aws-conf.sh](./072-aws-saml2aws-conf.sh)
