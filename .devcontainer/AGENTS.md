# Generic Dev Container

Here is a generic dev container containing my configuration.

## Local Features Layout

This dev container uses locally referenced Features from `devcontainer.json`.

Features live under `.devcontainer/features/` and are referenced in [devcontainer.json](devcontainer.json) using relative paths like `./features/git`.

## Locally Referenced Features

Per the Dev Container documentation, a Feature can be referenced from a local folder instead of being published to an OCI registry. This is useful while authoring or testing a Feature.

Key constraints:

- the project must have a `.devcontainer/` folder at the workspace root
- the Feature source must live inside a subfolder of `.devcontainer/`
- the subfolder name must match the Feature `id`
- Features must be referenced with a relative path, not an absolute path
- each Feature folder must contain at least `devcontainer-feature.json` and `install.sh`
- paths must use Unix-style syntax like `./features/git`, even on non-Unix hosts
