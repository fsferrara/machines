# My dotfiles

My SSH configuration for work and personal use.

## Feature

It follows the devcontainer features structure.  
Metadata are in the `devcontainer-feature.json` file.

### Software Installation

The entry point is the `install.sh` script which installs the software and then call the `configure.sh` script which applies the configuration.  
If you already have the software installed, you can directly call the `configure.sh` script.

The installation is done executing the scripts in the `install` folder. In it there may be a generic `install.sh` script or an OS-specific installation script (e.g. `ubuntu.sh`, `debian.sh`, `macosx.sh`).

### Configuration

The `configure.sh` script applies the configuration contained in the `config` folder to the destination folder (default is the home folder).

Before and after the configuration is applied, the script looks for `pre-configure.sh` and `post-configure.sh` scripts and executes them if they exist.
