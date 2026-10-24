# Generic Dev Container

Here is a generic dev container containing my configuration.

## Local Features Layout

This dev container uses locally referenced Features from `devcontainer.json`.

The `.devcontainer/core` link points to `../core`, and `.devcontainer/features`
points to `../features`. Features are referenced in
[devcontainer.json](devcontainer.json) using `./core` and paths like `./features/git`.
The `.devcontainer/private` link points outside this repository; do not modify
its target as part of changes to this repository.

## Core Dependency

Core is the reference feature and the prerequisite for all other features.
Every feature under `features/` declares `"dependsOn": {"./core": {}}` in its
metadata. The dependency path is relative to `devcontainer.json`, not the
dependent feature directory. Keep `./core` in the feature selection and first
in `overrideFeatureInstallOrder`. Do not add a self-dependency to core.

This dependency is specific to the local layout. It does not apply when running
the shell installers directly; install core first in that workflow.

## Locally Referenced Features

Per the Dev Container documentation, a Feature can be referenced from a local folder instead of being published to an OCI registry. This is useful while authoring or testing a Feature.

Key constraints:

- the project must have a `.devcontainer/` folder at the workspace root
- the Feature source must live inside a subfolder of `.devcontainer/`
- the subfolder name must match the Feature `id`
- Features must be referenced with a relative path, not an absolute path
- each Feature folder must contain at least `devcontainer-feature.json` and `install.sh`
- paths must use Unix-style syntax like `./features/git`, even on non-Unix hosts
