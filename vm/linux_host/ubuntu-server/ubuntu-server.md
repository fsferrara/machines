# Ubuntu Server

This is a guide to create a local development server.

## Install the guest

Download the ISO image and install it in a VM.
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

`sudo hostnamectl set-hostname VUBUNTU`
