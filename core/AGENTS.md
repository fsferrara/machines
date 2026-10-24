# Core Feature Concepts

Core provides the baseline environment shared by the other features.
[configure.sh](./configure.sh) uses rsync to merge the contents of
[config/](./config/), including hidden files and directories, into the destination
directory (the user's home directory by default). The paths below describe that
default home-directory layout. See [README.md](./README.md) for installation details.

## Shell Configuration

[config/.my-shell-conf/](./config/.my-shell-conf/) contains modular shell
configuration. When sourced by shell startup,
[kickstart.sh](./config/.my-shell-conf/kickstart.sh) detects the OS and shell and
automatically sources `.sh` files recursively from the applicable directories,
in this order:

1. `confs/generic/`: configuration shared by all supported shells and operating systems.
2. `confs/bash/` or `confs/zsh/`: configuration for the detected Bash or Zsh shell.
3. `confs/linux/` or `confs/osx/`: configuration for the detected Linux or macOS system.
4. `host-specific/`: machine-specific configuration, loaded last for local overrides.

These directories are relative to `~/.my-shell-conf/`. The loader runs only in
interactive shells. Shell startup must source it; copying the configuration alone
does not activate it in every shell. The supplied
[.profile](./config/.profile) sources it, and
[post-configure.sh](./post-configure.sh) prints instructions for sourcing it from
`.bashrc` or `.zshrc`.

## Script Directories

- [config/bin/](./config/bin/) provides the standard set of core scripts, installed
  into `~/bin`.
- [config/.local/bin/](./config/.local/bin/) establishes `~/.local/bin`, the intended
  destination for additional scripts rsynced from other features' `config/.local/bin/`
  payloads. This describes the intended layout, not a guarantee that every existing
  feature already uses it.

The shared shell configuration in
[bin.sh](./config/.my-shell-conf/confs/generic/bin.sh) adds both directories to
`PATH` when they exist, placing `~/.local/bin` ahead of `~/bin`.

## Minimal Tool Configuration

[config/.config/](./config/.config/) contains minimal configuration for tools
installed with core, rather than extensive application customization. Some core
tool configuration also lives directly under [config/](./config/) as dotfiles.

## Standard Home Directories

Core also establishes these standard directories:

- [config/tmp/](./config/tmp/) becomes `~/tmp`, for temporary files and playground projects.
- [config/tools/](./config/tools/) becomes `~/tools`, a place for tools.
- [config/workspace/](./config/workspace/) becomes `~/workspace`, for projects,
  with `personal/` and `work/` subdivisions and `spaces/` for groups of related worktrees.
