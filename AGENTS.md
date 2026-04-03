# AGENTS.md

This file provides guidance to coding agents when working with code in this repository.

## Overview

Configuration files for personal machines (physical and virtual). Uses devcontainer features structure for modular software installation and configuration.

## Feature Structure

Each feature in `features/` and `dotfiles/` follows the devcontainer features pattern:

```
feature/
├── install.sh          # Entry point - detects OS and runs appropriate installer
├── configure.sh        # Applies config/ to destination folder (default: $HOME)
├── devcontainer-feature.json  # Metadata
├── install/            # OS-specific installers
│   ├── install.sh      # Generic (if present, used instead of OS-specific)
│   ├── ubuntu.sh       # Ubuntu-specific
│   └── macosx.sh       # macOS-specific
├── config/             # Files to rsync to destination
├── pre-configure.sh    # Optional: runs before configure
└── post-configure.sh   # Optional: runs after configure
```

**Install a feature**: `./features/<name>/install.sh` (installs software + applies config)

**Configure only** (software already installed): `./features/<name>/configure.sh [destination]`

## Shell Configuration

`dotfiles/config/.my-shell-conf/kickstart.sh` loads shell config in order:
1. `confs/generic/` - All shells, all OS
2. `confs/{bash,zsh}/` - Shell-specific
3. `confs/{linux,osx}/` - OS-specific  
4. `host-specific/` - Machine-specific overrides

Source `~/.my-shell-conf/kickstart.sh` from `.bashrc` or `.zshrc`.

## VM Management (QEMU)

Ubuntu VMs in `vm/macos_host/ubuntu/`:

```bash
make start                    # Start VM
make disk                     # Create new 80G qcow2 disk
make inject-machine-tarball   # Package dotfiles+features for VM injection
make nuke                     # Delete disk image
```

## Devcontainer

The `.devcontainer/` provides a generic dev container with common features (dotfiles, git, ssh, zsh, tmux, gh, vim). Features are referenced as local paths in `devcontainer.json`.
