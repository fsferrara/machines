# MACHINES

Configuration files for my machines, both physical and virtual.

## Features

[Core](core/README.md) installs the basic software and configuration required by
all other features. It is also the reference for their shared installation and
configuration scripts.

From the repository root, install core and refresh the shared scripts:

```sh
./install.sh
```

Then install each feature you need with `./features/<name>/install.sh`.
Direct shell installs require core to be installed first. In the
[devcontainer](.devcontainer/devcontainer.json), feature metadata declares this
dependency and core is installed first.

See [Feature Structure](features/AGENTS.md) for the layout, dependency declaration,
and shared-script maintenance rules.

## Documentation

- [Machine setup documentation](docs/README.md)
- [Common setup](docs/common/README.md)
- [macOS setup](docs/macos/README.md)
- [Ubuntu setup](docs/ubuntu/README.md)
- [Windows setup](docs/windows/README.md)
