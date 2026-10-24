# AGENTS.md

This file provides guidance to coding agents when working with code in this repository.

## Overview

Configuration files for personal machines (physical and virtual). Uses devcontainer features structure for modular software installation and configuration.

## Documentation Layout

Repository documentation and machine setup guides live under `docs/`. The directory also contains supporting setup scripts and configuration payloads that are documented by the nearby README files. Keep reusable installed or configured software in the feature-style structures described below.

## Feature Structure

Each feature in `features/` and `core/` follows the devcontainer features pattern.
`core/` is the reference feature and the prerequisite for all other features.
Feature-root `install.sh` and `configure.sh` must remain identical to the
corresponding scripts in `core/`. See [Feature Structure](features/AGENTS.md).

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

**Install core first**: `./install.sh` (installs core, applies its configuration, and refreshes shared feature scripts)

**Install a feature**: `./features/<name>/install.sh` (installs software + applies config; requires core to be installed first)

**Configure only** (software already installed): `./features/<name>/configure.sh [destination]`

## Shell Configuration

`core/config/.my-shell-conf/kickstart.sh` loads shell config in order:
1. `confs/generic/` - All shells, all OS
2. `confs/{bash,zsh}/` - Shell-specific
3. `confs/{linux,osx}/` - OS-specific  
4. `host-specific/` - Machine-specific overrides

Source `~/.my-shell-conf/kickstart.sh` from `.bashrc` or `.zshrc`.

## Devcontainer

The `.devcontainer/` provides a generic dev container with common features (core, git, ssh, zsh, tmux, gh, vim). Features are referenced as local paths in `devcontainer.json`.
All features under `features/` declare `"dependsOn": {"./core": {}}` in their
metadata. This path is relative to `.devcontainer/devcontainer.json`, not the
dependent feature directory. This dependency applies to devcontainer builds;
direct shell installs still require core to be installed first.
