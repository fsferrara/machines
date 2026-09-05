# AGENTS.md

This file provides guidance to coding agents when working with code in this repository.

## Overview

Configuration files for personal machines (physical and virtual). Uses devcontainer features structure for modular software installation and configuration.

## Documentation Layout

Repository documentation and machine setup guides live under `docs/`. The directory also contains supporting setup scripts and configuration payloads that are documented by the nearby README files. Keep reusable installed or configured software in the feature-style structures described below.

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
│   └── macos.sh        # macOS-specific
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

## Devcontainer

The `.devcontainer/` provides a generic dev container with common features (dotfiles, git, ssh, zsh, tmux, gh, vim). Features are referenced as local paths in `devcontainer.json`.
