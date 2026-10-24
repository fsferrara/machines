# Herdr

A portable terminal workspace and development-layout workflow for macOS and
Ubuntu, adapted from the [Omarchy Herdr overview](https://omarchy.org/manual/tuis/#herdr)
and [shell-function reference](https://omarchy.org/manual/shell-functions/).
Herdr remains independent of tmux: workspaces correspond to tmux sessions,
tabs to windows, and panes to panes.

## Installation and configuration

Install [core](../../core/README.md) first, then:

```sh
./features/herdr/install.sh
```

The existing installers use Homebrew on macOS and the
[upstream installer](https://herdr.dev/install.sh) on Ubuntu. Core supplies
`jq`, which the layout helpers use to validate Herdr API responses.
The [feature metadata](devcontainer-feature.json) declares the core dependency;
direct shell installs require installing core first.

When Herdr is already installed:

```sh
./features/herdr/configure.sh
./features/herdr/configure.sh /path/to/destination
```

Configuration defaults to your home directory. It replaces
`~/.config/herdr/config.toml` with the [managed configuration](config/.config/herdr/config.toml)
and installs the [shell module](config/.my-shell-conf/confs/generic/herdr.sh)
at `~/.my-shell-conf/confs/generic/herdr.sh`. Existing Herdr settings are not
merged. Other features' files are left untouched.

Start a fresh Bash or Zsh shell whose startup sources
`~/.my-shell-conf/kickstart.sh`. For an existing Herdr server, reload from a
pane in the intended session:

```sh
herdr server reload-config
```

After the new bindings are loaded, prefix `q` also reloads configuration.
Configuration does not automatically reload or restart running servers.
If you set `HERDR_CONFIG_PATH`, Herdr uses that alternative file instead.
No migration hooks or cleanup of old installed files are included.

## Workspaces and keybindings

`h` is an alias for native `herdr`: launch or attach to its persistent session.
It forwards arguments, for example `h --session project`. There is no custom
session registry or wrapper around the `herdr` command.

The prefix is **Ctrl-Space**, replacing the old Ctrl-A configuration. Press and
release it before the key shown below.

| After prefix | Action |
| --- | --- |
| `?` / `q` / `d` | Native help / reload configuration / detach |
| `[` | Enter native copy mode |
| `h` / `v` | Split top/bottom / left/right |
| `x` / `z` / `;` | Close pane / zoom / last pane |
| Ctrl-arrow | Enter resize mode |
| `O` | Rename pane |
| `c` / `r` / `k` | Create / rename / close tab |
| `p` / `n` / `1`...`9` | Previous / next / numbered tab |
| `C` / `R` / `K` | Create / rename / close workspace |
| `P` / `N` | Previous / next workspace |

Unprefixed shortcuts match Omarchy where the terminal can transmit them:

| Shortcut | Action |
| --- | --- |
| Alt-Enter / Alt-Shift-Enter | Split top/bottom / left/right |
| Alt-Escape | Close pane |
| Ctrl-Alt-arrow | Focus pane |
| Ctrl-Alt-Shift-arrow | Resize pane |
| Alt-1...9 | Select tab |
| Alt-Left / Alt-Right | Previous / next tab |
| Alt-Shift-Left / Alt-Shift-Right | Move tab |
| Alt-Up / Alt-Down | Previous / next workspace |

New panes and tabs follow the current directory. Mouse capture is enabled.
Closing panes, tabs, or workspaces **does not ask for confirmation** and can
terminate running work. Detach instead when you want to keep it running.
New tabs do not prompt for a name.

## Development layouts

Run layouts inside Herdr, starting from a **single-pane tab**. They use stable
pane/tab/workspace IDs and leave the invoking pane as the editor or first grid
pane. Start a new tab before applying another layout.

| Function | Layout |
| --- | --- |
| `hdl <command> [second-command]` | Editor left, command right, terminal along the bottom. A second command divides the right column. |
| `hds <diff-command> <agent-command>` | Editor top-left, diff top-right, terminal bottom-left, agent bottom-right. |
| `hdlm <command> [second-command]` | One `hdl` tab per immediate non-hidden subdirectory, reusing the current tab for the first project. |
| `hsl <count> <command>` | Exactly `count` panes in a grid, each running the supplied command. |

Editor panes run `$EDITOR .`, or `vi .` if `EDITOR` is unset or empty.
`EDITOR` may contain arguments. Other commands must be supplied explicitly;
unlike Omarchy's zero-argument `hds`, both diff and agent commands are required.
No particular editor, diff watcher, or AI agent is installed or required.

```sh
hdl 'claude'
hdl 'opencode' 'codex'
hds 'git diff' 'claude'
hdlm 'opencode'
hsl 5 'printf "%s\n" "$PWD"'
```

These tools are examples, not defaults. Pass each complete command as one
quoted argument. It executes in the destination's interactive shell, supporting
aliases, functions, arguments, and pipelines. Aliases/functions must be loaded
by that shell's startup, not just defined in the invoking pane. Do not pass
untrusted text as a command.

`hdlm` names the workspace after the parent directory and tabs after their
project directories. It returns focus to the first tab. Its caller's directory
is unchanged during construction; the reused editor pane subsequently changes
to the first project's directory. No matching directories is an error.

`hsl` accepts decimal counts from 1 through 2147483647, including leading zeros.
This is a portable arithmetic bound, not a promise that the terminal or system
can accommodate that many panes. Actual limits depend on Herdr and available
resources. Grid ratios use locale-independent decimals.

Invalid arguments, missing Herdr/jq, stale context, and already-split tabs
fail before layout changes. CLI failures and malformed API responses produce
diagnostics and a nonzero status. Execution stops on the first failure, leaving
any partial layout intact; already-started commands are not rolled back.

## Appearance and terminal compatibility

The configuration uses one terminal-palette style with a black panel background,
blue accents, no pane gaps/outer borders/scrollbars, and zoom/hostname status.
Use a dark terminal palette for the intended contrast. There is no automatic
theme switching, Omarchy menu integration, or desktop launcher dependency.

Herdr's native key handling and clipboard behavior are retained. No global
`TERM`, forced terminal capabilities, SSH changes, or editor clipboard patches
are installed. Actual copy/paste, modifier keys, and mouse behavior depend on
the terminal. On macOS, configure Option as Alt/Meta where needed and resolve
OS shortcuts that intercept Ctrl-Space. Unlike tmux, this configuration does
not add a second prefix; native help lists the remaining navigation options.

## Validation

Tested with Herdr **0.9.5** on macOS (Bash 3.2.57, Zsh 5.9) and Ubuntu 22.04
(Bash 5.1.16, Zsh 5.8.1), both on ARM64. Older Herdr versions are not claimed
as supported by these tests.

With Bash, Zsh, jq, rsync, and Herdr installed:

```sh
bash features/herdr/tests/run.sh
```

The [focused runner](tests/run.sh) uses short temporary homes, private named
Herdr servers, harmless marker commands, and test-owned editor fixtures.
It validates configuration with `herdr config check`, repeated configuration
and preservation of other files/symlinks, core shell loading alongside tmux,
layouts and their counts/ratios/focus, directory quoting, editor selection,
and explicit error/partial-failure behavior in both shells.

Tests never configure your home or target your running Herdr session, and
remove their own processes and temporary files afterward. Native launch/attach
rendering, physical modifier-key delivery, visual contrast, mouse interaction,
and the system clipboard still require a manual check in your chosen terminal.
