# Ubuntu

Notes

## Kickstart

1. Password Manager: bitwarden

```
snap install bitwarden
```

2. Install secrets: ssh keys

4. clone machines

```
sudo apt install git
mkdir -p ~/github/fsferrara
cd ~/github/fsferrara
git clone git@github.com:fsferrara/fsferrara.git
./fsferrara/scripts/clone.sh
```

## Scripts

Execute:

- `./common/default-directories.sh`
- `./common/passwordless-sudo.sh`
- `./ubuntu/install_tools_and_tech.sh`
