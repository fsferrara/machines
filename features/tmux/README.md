# tmux

A terminal-independent session and development-layout workflow for macOS and
Ubuntu, adapted from the [Omarchy terminal manual](https://omarchy.org/manual/terminal/)
and [shell-function reference](https://omarchy.org/manual/shell-functions/).
Uses native tmux, one dark ANSI-color style, and no plugins or desktop integration.

## Installation

Install [core](../../core/README.md) first, then:

```sh
./features/tmux/install.sh
```

This installs tmux with Homebrew on macOS or apt on Ubuntu, then copies the
[configuration](config/.config/tmux/tmux.conf) and
[shell functions](config/.my-shell-conf/confs/generic/tmux.sh) to your home
directory. Supported baseline: tmux 3.2+, Ubuntu 22.04+, and Bash 3.2 or Zsh.
The [feature metadata](devcontainer-feature.json) retains the core dependency
for devcontainer builds.

The tmux configuration is installed at `~/.config/tmux/tmux.conf`, which tmux
discovers automatically. Shell functions remain in
`~/.my-shell-conf/confs/generic/tmux.sh` for core's shell loader.

To apply configuration without installing software:

```sh
./features/tmux/configure.sh
./features/tmux/configure.sh /path/to/destination
```

The destination defaults to `$HOME`. The shell functions load through core's
interactive shell loader; your shell startup must source
`~/.my-shell-conf/kickstart.sh`.

## Sessions

The native `tmux` command is not wrapped or aliased.

- Outside tmux, `t` attaches to an existing session. If none exists, it creates
  `Work` in the current directory. An attach failure is reported, not treated
  as permission to create another session.
- Inside tmux, `t` opens the native session chooser instead of nesting clients.
- `t` accepts no arguments. Use native commands for named sessions:

```sh
tmux new-session -s project
tmux attach-session -t project
tmux list-sessions
```

Sessions stay alive when you detach or close the terminal. There is no
configured-session registry, fzf session picker, or automatic session restoration
after reboot.

## Keybindings

The primary **prefix** is **Ctrl-Space**; **Ctrl-b** is the fallback. Press and
release either prefix before a key in the first column below.

| After prefix | Action |
| --- | --- |
| `?` | Native tmux keybinding help |
| `q` | Reload `~/.config/tmux/tmux.conf` |
| `h` / `v` | Split top/bottom / left/right in the current pane's directory |
| `x` | Kill pane without confirmation |
| `c` / `r` / `k` | Create / rename / kill window |
| `C` / `R` / `K` | Create / rename / kill session |
| `s` | Native session chooser |
| `P` / `N` | Previous / next session |
| Arrow keys | Focus pane (native fallback) |
| Ctrl-arrow keys | Resize pane (native fallback) |
| `p` / `n` / `1`...`9` | Previous / next / numbered window |
| `z` | Toggle pane zoom |
| `d` | Detach |
| `[` | Enter vi copy mode |
| Ctrl-Space / Ctrl-b | Send the primary / fallback prefix to a nested session |

In copy mode, `v` begins selection and `y` copies and exits copy mode.
Mouse selection and scrolling are enabled.

These shortcuts need no prefix, but depend on your terminal transmitting them:

| Shortcut | Action |
| --- | --- |
| Alt-Enter / Alt-Shift-Enter | Split top/bottom / left/right |
| Alt-Escape | Kill pane |
| Ctrl-Alt-arrow | Focus pane |
| Ctrl-Alt-Shift-arrow | Resize pane by five cells |
| Alt-1...9 | Select window |
| Alt-Left / Alt-Right | Previous / next window |
| Alt-Shift-Left / Alt-Shift-Right | Move window left / right |
| Alt-Up / Alt-Down | Previous / next session |

Windows and panes start at index 1. Closing a window renumbers the remaining
windows. Closing a session keeps the client attached if another session exists.
The top status bar shows the session, windows, hostname, and copy/prefix/zoom
indicators. Scrollback holds 50,000 lines. Aggressive resizing follows the
clients viewing a window, rather than preserving the old iTerm2-oriented setting.

## Development layouts

Run these functions **inside tmux, from a single-pane window**. They preserve
the invoking pane, use stable pane IDs, and create all panes in the project
directory. Start a new window before applying another layout.

| Function | Layout |
| --- | --- |
| `tdl <command> [second-command]` | Editor left, command right, terminal across the bottom. A second command divides the right column. |
| `tds <diff-command> <agent-command>` | Editor top-left, diff top-right, terminal bottom-left, agent bottom-right. |
| `tdlm <command> [second-command]` | One `tdl` window per immediate non-hidden subdirectory. Reuses the current window for the first project. |
| `tsl <count> <command>` | Tiled panes, each running the supplied command. |

Editor panes run `$EDITOR .`, or `vi .` when `EDITOR` is unset or empty.
`EDITOR` may contain arguments. Other commands are always explicit; the feature
does not install or require an editor, AI agent, or diff watcher.

```sh
tdl 'claude'
tdl 'opencode' 'codex'
tds 'git diff' 'claude'
tdlm 'opencode'
tsl 4 'claude'
```

These are examples, not defaults: install the chosen tools separately. Unlike
Omarchy's zero-argument `tds`, this adaptation requires both commands.

Pass each complete command as **one quoted argument**. It is submitted literally
to the destination's interactive shell and then executed there, so shell aliases,
functions, pipelines, and arguments work. Use single quotes to defer expansion:

```sh
tsl 2 'printf "%s\n" "$PWD"'
```

Aliases and functions must be available in each new pane's shell startup, not
only defined transiently in the invoking pane. Bash and Zsh are supported;
custom pane shells must understand the submitted shell commands. Do not pass
untrusted text as a command.

`tdlm` renames the session after the parent directory, replacing periods and
colons with hyphens, and returns focus to the first project's editor. It does
not change the caller's working directory during construction; afterward the
reused editor pane changes to the first project's directory. Hidden directories
are skipped; no matching directories is an error.

Invalid arguments, missing tmux context, and already-split windows fail before
layout changes. Pane counts must be positive decimal integers representable
within 1...2147483647 (leading zeros are accepted); there is no additional
policy cap. Actual pane creation is limited by available window dimensions.
If a tmux operation fails, the function stops with a nonzero status and a
diagnostic. A partially built layout is left intact for inspection, not silently
discarded; commands already started cannot safely be rolled back.

## Terminal compatibility

- The outer shell's `TERM` is never overridden. Inside tmux, use
  `tmux-256color` when `infocmp` finds it, otherwise `screen-256color`.
  No custom terminfo is compiled or installed.
- Colors, clipboard support, and extended-key support use tmux's native
  terminal detection. No wildcard RGB, clipboard, or extended-key claims are
  added, and no newer extended-key encoding is forced.
- Clipboard mode is `external`: tmux can send copied text to a supporting
  terminal (OSC 52), but applications cannot use tmux's clipboard option to
  create clipboard buffers. Actual behavior depends on terminal permissions.
  Passthrough is enabled on tmux 3.3+ for applications that need it; this is a
  separate terminal-control path, so it is not a clipboard security boundary.
- If Ctrl-Space is intercepted by an OS input-source shortcut, use Ctrl-b.
  On macOS, configure Option as Alt/Meta in your terminal for Alt shortcuts.
  Some terminals cannot distinguish shifted Enter or advanced modifier keys;
  use prefix h/v, arrows, Ctrl-arrows, p/n, and P/N as alternatives.
- Remote hosts also need suitable terminfo for the terminal identity they see.
  This feature does not force terminal capabilities on SSH destinations.

## Configuration scope

The feature supports fresh installations and repeatable configuration. It
installs only tmux and copies its own configuration; it does not delete files
owned by other features, manage fzf, or perform legacy cleanup. Any one-time
cleanup of an existing machine belongs outside the reusable feature.

An existing `~/.tmux.conf` takes precedence over `~/.config/tmux/tmux.conf`.
When switching an existing machine to this layout, review and retire the old
file separately; normal feature configuration does not remove it.

After configuring, start a fresh shell to load the functions. Existing tmux
servers are not reloaded automatically; use prefix `q` to reload configuration.
Changes to terminal capabilities or removal of previous custom bindings may
require restarting the server after saving your work. Reloading configuration
does not change the `TERM` of existing panes.

## Validation

Run the focused tests with Bash, Zsh, tmux, rsync, and ncurses `infocmp` available:

```sh
bash features/tmux/tests/run.sh
```

The [test runner](tests/run.sh) uses temporary homes, private tmux sockets,
and harmless marker commands. It does not configure your home or touch your
tmux server. It verifies automatic configuration discovery, the reload binding,
native sessions, layouts in both shells, failures,
fresh configuration, and repeated configuration without modifying other
features' files or symlinks.
The suite is exercised on macOS and Ubuntu 22.04's tmux 3.2a baseline.
Physical modifier-key delivery and system clipboard integration still need a
manual check in your chosen terminal.
