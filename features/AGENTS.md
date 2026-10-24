# Feature Structure

These instructions apply to all features under `features/`. Follow the repository
root `AGENTS.md` as well. `dotfiles/` is the reference feature.

## Layout

Each feature follows the same devcontainer feature structure as `dotfiles/`:

```text
features/<name>/
|-- install.sh                 # Shared installation entry point
|-- configure.sh               # Shared configuration entry point
|-- devcontainer-feature.json  # Feature metadata
|-- install/
|   |-- install.sh             # Optional generic installer
|   |-- macos.sh               # macOS installer
|   `-- ubuntu.sh              # Ubuntu installer
|-- config/                    # Configuration files to copy to the destination
|-- pre-configure.sh           # Optional hook before copying configuration
`-- post-configure.sh          # Optional hook after copying configuration
```

## Execution Order

- The feature-root `install.sh` runs `install/install.sh` if that file exists.
	Otherwise, it selects `install/macos.sh` or `install/ubuntu.sh` for the detected
	OS. If no matching installer exists, it skips software installation.
- After installation, it calls `configure.sh`. The destination is
	`_REMOTE_USER_HOME` when set and non-empty, or `$HOME` otherwise. When
	`_REMOTE_USER` names a different user, the entry point first switches to that user.
- `configure.sh` runs `pre-configure.sh` if present, copies the contents of
	`config/` to the destination with `rsync -av`, then runs `post-configure.sh` if
	present. Both hooks receive the destination as their first argument.

From the repository root:

```sh
./features/<name>/install.sh
./features/<name>/configure.sh [destination]
```

Use the first command to install software and apply configuration. Use the second
to apply configuration only; its destination defaults to `$HOME`.

## Shared Scripts

`dotfiles/install.sh` and `dotfiles/configure.sh` are the source of truth.
Every feature-root `install.sh` and `configure.sh` must be byte-for-byte identical
to the corresponding file in `dotfiles/`.

- Do not add feature-specific behavior to either shared entry point.
- To change shared behavior, edit the reference scripts in `dotfiles/`, then copy
	both scripts to every `features/*/` directory. Keep all copies synchronized in
	the same change.
- When adding a feature, copy both entry points from `dotfiles/` unchanged.
- Put feature-specific installation logic in `install/`, configuration files in
	`config/`, and configuration setup or cleanup in the pre/post hooks. Keep
	feature metadata in `devcontainer-feature.json`.
- The feature-specific `install/install.sh` is different from the shared
	feature-root `install.sh`; only the latter is copied from the reference feature.

The repository-root `install.sh` installs dotfiles first. Its `REFRESH FEATURES`
block then copies `dotfiles/configure.sh` and `dotfiles/install.sh` into every
`features/*/` directory with `cp -f`. This overwrites any local changes to those
copies. It does not copy installers, configuration files, hooks, or metadata.
Do not run the root installer just to check synchronization: it also installs
software and applies dotfiles configuration.

To check the shared scripts without running installers, run this from the
repository root. No output means all copies match:

```sh
for feature in features/*/; do
		for script in install.sh configure.sh; do
				cmp -s "dotfiles/$script" "${feature}${script}" ||
						printf 'Mismatch or missing file: %s\n' "${feature}${script}"
		done
done
```
