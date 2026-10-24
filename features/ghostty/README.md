# Ghostty

An adaptation of the [Omarchy terminal workflow](https://omarchy.org/manual/terminal/)
for macOS and Ubuntu. Ghostty is an independent terminal feature, compatible
with tmux, Herdr, and the core shell configuration.

## Installation

Install [core](../../core/README.md) first, then the
[Nerd Fonts feature](../nerdfonts/README.md) for JetBrainsMono:

```sh
./features/nerdfonts/install.sh
./features/ghostty/install.sh
```

The installers use Homebrew's Ghostty cask on macOS and the official `ghostty`
APT package on **Ubuntu 26.04 or later**. Older Ubuntu releases are not supported
by this feature's automatic installer; it does not add third-party package
sources. See [Ghostty's installation reference](https://ghostty.org/docs/install/binary).
The configuration uses Ghostty 1.3-era options; it has been validated with macOS
1.3.1 and Ubuntu's `1.3.0~us1-0ubuntu1.1` package.

The [metadata](devcontainer-feature.json) declares core and Nerd Fonts as
dependencies, so devcontainer builds install both before Ghostty. Dependency
paths are relative to `.devcontainer/devcontainer.json`. Direct shell installs
do not process this metadata; install core, then Nerd Fonts, then Ghostty.

## Configuration

For an existing installation:

```sh
./features/ghostty/configure.sh
./features/ghostty/configure.sh /path/to/destination
```

The destination defaults to your home directory. This **replaces**
`~/.config/ghostty/config` with the [managed configuration](config/.config/ghostty/config);
it does not merge custom settings, create backups, or remove other files.
Configuration does not uninstall fonts or restart terminals.

The configuration provides:

- JetBrainsMono Nerd Font, Regular, size 9.
- One inline dark palette from the captured Omarchy setup, with no theme files,
  symlinks, switching, or runtime dependency on Omarchy.
- Matching window appearance, 14-unit padding, a steady block cursor, and no
  resize overlay.
- Hidden scrollbar and a **10000-byte** scrollback limit (not 10000
  lines). This is a small per-surface buffer; tmux and Herdr manage their own history.
- Omarchy's 0.95 mouse-scroll multiplier, with mouse reporting enabled and Shift
  available for terminal selection.
- Automatic shell integration with `no-cursor,ssh-env`: preserve the block cursor
  and enable Ghostty's SSH environment compatibility. Local terminal identity is
  not overridden, and automatic remote terminfo installation is not enabled.

**Closing a terminal surface does not ask for confirmation and can terminate
running work.** Detach from a persistent multiplexer session when appropriate
instead of terminating its work.

GTK-only options, the Hyprland backend workaround, screensaver configuration,
desktop launchers, and menu integrations are excluded. macOS Option-as-Alt
delivers the same Alt-based workflow on both systems.

## Keybindings

| Shortcut | Action |
| --- | --- |
| Ctrl-Shift-N / Ctrl-Shift-T | New window / tab |
| Shift-Insert / Ctrl-Insert | Paste / copy |
| Shift-Enter | Send CSI-u `13;2u` for supporting TUIs |
| Alt-Shift-Enter | Send CSI-u `13;4u` for tmux/Herdr and supporting TUIs |
| Super-Ctrl-Alt-Shift-arrow | Resize a native Ghostty split by 100 |
| Alt-Left / Alt-Right | Pass through to the application instead of Ghostty's native bindings |

Super is Command on macOS. Other native bindings, including macOS Command-C/V,
are available. Ctrl-Space and Alt-Enter are not captured by the managed
configuration. Terminal encoding support and OS-reserved shortcuts still affect
what an application receives; no system-wide keyboard settings are changed.

## Reload and validation

Reload from Ghostty's menu or its default shortcut: **Command-Shift-comma** on
macOS, **Ctrl-Shift-comma** on Linux. Configuration is not automatically reloaded
by this feature. Existing manually resized fonts can retain their size; use a
new window to check the default. No running terminal needs to be closed.

On macOS, the command is also available directly from the app bundle:

```sh
/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config
/Applications/Ghostty.app/Contents/MacOS/ghostty +list-fonts \
  --family='JetBrainsMono Nerd Font' --style=Regular
GHOSTTY_BIN=/Applications/Ghostty.app/Contents/MacOS/ghostty \
  bash features/ghostty/tests/run.sh
```

On Ubuntu, with Ghostty, Bash, jq, and rsync installed:

```sh
ghostty +validate-config
ghostty +list-fonts --family='JetBrainsMono Nerd Font' --style=Regular
bash features/ghostty/tests/run.sh
```

The [tests](tests/run.sh) check the real configuration parser, effective settings,
key actions, static palette, metadata, shared scripts, and repeated configuration
in an isolated home while preserving unrelated files and shell modules. They also
verify that invalid configuration is rejected. They do not install fonts or
packages or alter the real home directory.

Automated tests pass on macOS (Ghostty 1.3.1) and Ubuntu 26.04 ARM64 (official
package reporting `1.3.0-dev+0000000`). Interactive rendering, clipboard access,
and physical key delivery remain manual checks:

- Confirm the dark palette and JetBrainsMono size 9 in a new window.
- Check copy/paste, Shift selection, and mouse scrolling.
- In tmux and Herdr, check Ctrl-Space, Alt-Enter, Alt-Shift-Enter, Alt-arrow
  navigation, and Shift-Enter in a supporting TUI.
- Check native split resizing in a disposable window.

See the [Ghostty configuration reference](https://ghostty.org/docs/config/reference)
for option semantics and platform-specific limitations.
