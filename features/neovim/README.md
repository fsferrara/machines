# Neovim

Neovim with a portable Omarchy-inspired LazyVim configuration for macOS and
Ubuntu 26.04. This replaces the former `lazyvim` feature; LazyVim remains the
configuration foundation, not a separate feature.

## Install and configure

Install core first, then run:

```sh
./features/neovim/install.sh
```

The OS-specific installers use Homebrew on macOS and apt on Ubuntu. Neovim
must be at least 0.11.2 with LuaJIT. Older Ubuntu repositories without a suitable
Neovim candidate fail explicitly; this feature does not add a PPA or install
release binaries. Git, fzf, ripgrep, fd (`fd-find` on Ubuntu), and lazygit are
included. Core and the base OS supply build tools, curl, tar/unzip, and rsync. Use a Nerd Font
and a true-color terminal for the intended appearance.

For software already installed:

```sh
./features/neovim/configure.sh [destination]
```

The destination defaults to `$HOME` and must be an existing directory. The
feature uses the standard home layout, not custom XDG locations. The core shell
loader activates `EDITOR=nvim` and the `n` alias in interactive Bash and Zsh.
Existing shells need to reload the loader or open a new shell.

### Destructive reset on every configuration

**Every install/configure run permanently removes these four directories beneath
the destination before copying the new configuration, without a backup:**

- `.config/nvim`: configuration and plugin lockfile
- `.local/share/nvim`: plugins, parsers, and Mason-installed tools
- `.local/state/nvim`: editor state, undo history, and logs
- `.cache/nvim`: caches

Save wanted customizations elsewhere and close Neovim before running either
command. This is an intentional Neovim-only exception to the repository's
general one-time migration policy. Reconfiguration resets Neovim to this
feature's defaults; it does not preserve additions inside these directories.
The hook rejects unsafe destinations and symlinks in the reset targets or their
parents. Vim and unrelated feature files are not reset.

The first launch requires network access to fetch LazyVim and its plugins.
LazyVim/Mason provisions the Treesitter CLI when missing, and parsers need a C
compiler. The Treesitter build waits for Mason's CLI installation before editor
configuration proceeds, avoiding concurrent first-launch installation requests.
The Neovim 0.11 Treesitter revision matches LazyVim's compatibility pin, and the
parser installation directory is registered explicitly for first-launch use.
Plugin/tool installation errors must be resolved before relying on
the setup; use `:Lazy`, `:Mason`, and `:checkhealth` for diagnostics.

## Workflow

The configuration uses absolute line numbers, disables automatic formatting and
animated scrolling, and selects the static `tokyonight-night` dark theme.
Neo-tree is the only configured explorer. There are no Omarchy desktop
dependencies, theme switching, or custom clipboard providers.

| Command/key | Action |
| --- | --- |
| `n`, `n file` | Launch Neovim, optionally opening a file |
| `Space Space` | Find files |
| `Space s g` | Search project text |
| `Space e` | Toggle Neo-tree |
| `Ctrl-w w` | Move between windows |
| `Shift-h`, `Shift-l` | Previous/next buffer |
| `Space b d`, `Space b o` | Delete buffer / other buffers |
| `Space g g` | Open lazygit |
| `Space u w` | Toggle wrapping |

Use `?` in Neo-tree for its native help. Standard LazyVim mappings remain the
source of truth; the separate Vim, tmux, and Herdr configurations are unchanged.

## Clipboard

Keep Neovim/LazyVim's native detection, matching the existing macOS workflow.
Locally, LazyVim sets `clipboard=unnamedplus`; Neovim selects an available
provider such as macOS `pbcopy`/`pbpaste`. On Linux, native desktop providers
require their corresponding tools and display environment.

Over SSH, LazyVim leaves the clipboard option empty so normal editing does not
force remote clipboard access. Use explicit registers such as `"+y` and `"+p`
where supported. Neovim can use OSC 52 or a multiplexer provider when detected;
this is not a guarantee that every attached client receives a copy. Terminals
may allow OSC 52 writes but block reads, causing paste prompts or timeouts.
Use the terminal's paste command when remote clipboard reads are unsupported.
This feature does not force terminal capabilities or copy Omarchy's
Linux-specific clipboard/process-detection module.

## Validation

```sh
./features/neovim/tests/run.sh
```

Tests require Bash, Zsh, jq, rsync, Neovim, Git, curl, tar, unzip, a C compiler,
ripgrep, and fd/fdfind. They use a disposable HOME/XDG layout and network access
for real plugin and parser installation. They cover feature wiring, reset
boundaries, shell integration, effective editor settings, Neo-tree, keymaps,
native clipboard defaults, and loading every default Treesitter parser.

Verified on macOS 26.7.1 with Neovim 0.12.6 and Ubuntu 26.04 ARM64 with Neovim
0.11.6, using Bash and Zsh. Both clean first-launch suites pass, including the
Mason-provisioned Treesitter CLI and all default parsers. The current Mac was
also installed/configured and checked against the same runtime assertions.

Physical key delivery, terminal rendering, and end-to-end local/remote clipboard
behavior require manual checks in the terminals and multiplexers being used.
Tests do not read or overwrite the real system clipboard.

## References

- [Omarchy Neovim manual](https://omarchy.org/manual/neovim/)
- [LazyVim keymaps](https://www.lazyvim.org/keymaps)
- [LazyVim requirements](https://www.lazyvim.org/)
