# Generic Dev Container

Here is a generic dev container containing my configuration.

## Local Features Layout

This dev container uses locally referenced Features from `devcontainer.json`.

To satisfy the Dev Container Feature layout requirements, each locally referenced feature is exposed as a direct entry under `.devcontainer/`.

The helper script [create_feature_links.sh](create_feature_links.sh) rebuilds those links:

- it removes the old `.devcontainer/features` directory or symlink
- it removes previously generated feature symlinks from `.devcontainer/`
- it adds one direct symlink per feature, such as `./git`

## Summary: Locally Referenced Features

Per the Dev Container documentation, a Feature can be referenced from a local folder instead of being published to an OCI registry. This is useful while authoring or testing a Feature.

Key constraints:

- the project must have a `.devcontainer/` folder at the workspace root
- the Feature source must live inside a direct subfolder of `.devcontainer/`
- the subfolder name must match the Feature `id`
- Features must be referenced with a relative path, not an absolute path
- each Feature folder must contain at least `devcontainer-feature.json` and `install.sh`
- paths must use Unix-style syntax like `./git`, even on non-Unix hosts

In this repository, the effective local references used by [devcontainer.json](devcontainer.json) are made valid by creating direct symlinks in `.devcontainer/` that point to the actual feature implementations in the top-level `features/` directory.
