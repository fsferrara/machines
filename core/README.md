# Core Feature

This feature installs the basic software and configuration files for my machines.
All other features require core. It is also the reference for their shared
`install.sh` and `configure.sh` entry points, which must remain byte-for-byte
identical to the corresponding files here.

From the repository root, run `./install.sh` to install core, apply its
configuration, and refresh the shared scripts in all other features. Then install
the features you need with `./features/<name>/install.sh`.

Devcontainer features declare `"dependsOn": {"./core": {}}` to install core first.
Direct shell installs do not resolve this metadata; install core before running
another feature. See [Feature Structure](../features/AGENTS.md) for the dependency
and shared-script rules.

## Feature

Core follows the devcontainer features structure.
Metadata is in [devcontainer-feature.json](devcontainer-feature.json).

### Software Installation

The [install.sh](install.sh) entry point installs software, then calls
[configure.sh](configure.sh) to apply configuration. If the software is already
installed, run `./core/configure.sh [destination]` from the repository root.

Installation runs scripts in `install/`. If `install/install.sh` exists, it takes
precedence over the OS-specific `install/ubuntu.sh` or `install/macos.sh`.

### Configuration

The `configure.sh` script applies the configuration contained in the `config` folder to the destination folder (default is the home folder).

Before and after the configuration is applied, the script looks for `pre-configure.sh` and `post-configure.sh` scripts and executes them if they exist.
