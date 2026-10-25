# Modern Unix

A portable terminal toolbox for macOS and Ubuntu 26.04, adapted selectively
from Omarchy. Where workflows overlap, the feature prefers the selected
Omarchy tool while keeping distinct utilities and standard commands available.

## Source Required

Differently from Omarchy, I prefer to integrate all these modern tools on-demand
with a specific command:

```sh
source modern
```

## Installation

Install [core](../../core/README.md) first. Then, from the repository root:

```sh
./features/modern-unix/install.sh
```

macOS uses Homebrew. Ubuntu 26.04 requires its standard repositories, including
`universe`, and uses apt except for dua and Hunk. Ubuntu supports ARM64 and x86_64;
other architectures fail explicitly. fzf must support `--bash` and `--zsh`
(version 0.48 or newer). Installation failures stop before configuration.

If the software is already installed:

```sh
./features/modern-unix/configure.sh [destination]
```

The destination defaults to `$HOME`. Configuration merges through the standard
feature scripts; unrelated files are not deleted. Feature-owned configuration
files are overwritten, so review local customization before applying.
Shell startup must source `~/.my-shell-conf/kickstart.sh`; installation does not
rewrite `.bashrc` or `.zshrc`.

### Package and command names

| Command | Homebrew | Ubuntu |
| --- | --- | --- |
| `lazygit` | `lazygit` | `lazygit` |
| `hunk` | `hunk` | Verified upstream binary |
| `fd` | `fd` | `fd-find` (`fdfind`) |
| `fzf` | `fzf` | `fzf` |
| `rg` | `ripgrep` | `ripgrep` |
| `bat` | `bat` | `bat` (`batcat`) |
| `eza` | `eza` | `eza` |
| `zoxide`, `z`, `zi` | `zoxide` | `zoxide` |
| `tldr` | `tealdeer` | `tealdeer` |
| `btop` | `btop` | `btop` |
| `fastfetch` | `fastfetch` | `fastfetch` |
| `dua` | `dua-cli` | Verified upstream binary |

On Ubuntu, configuration provides `fd` and `bat` links in the destination's
`.local/bin` when needed. Core adds that directory to `PATH`. Existing native
commands remain available; conflicting destination files or links are
preserved and reported, not overwritten.

Ubuntu's dua binary is pinned to **2.46.0** in
[the Ubuntu installer](install/ubuntu.sh). It downloads the appropriate
upstream musl archive, verifies its architecture-specific SHA-256, and installs
only the executable into `/usr/local/bin/dua`. An identical existing binary is
left untouched; an existing different binary or symlink requires explicit
resolution. To update the pin, verify both upstream assets, update the version
and both digests together, and rerun installation tests. Do not bypass digest
verification or install arbitrary binaries over existing files.

Hunk follows the same release verification and collision rules, pinned to
**0.24.0** from `modem-dev/hunk` and installed into `/usr/local/bin/hunk`.
Only the standalone executable is installed, not the release's bundled agent
skills. No Node.js or mise dependency is introduced.

Homebrew's obsolete `tldr` client and `tlrc` conflict with tealdeer. If one is
linked, the installer reports the corresponding `brew unlink` command and
stops. Unlinking is a separate, deliberate migration; installers never
automatically uninstall clients or remove their caches.

## Workflow

| Tool | Usage |
| --- | --- |
| lazygit | Run `lazygit` in a Git repository; use native navigation, staging, commits, and `?` help. |
| Hunk | `hunk diff` reviews working-tree changes; `hunk diff --watch` keeps the review updated. |
| fd | `fd pattern` finds names; `fd -H pattern` includes hidden entries. |
| fzf | `ff` selects files with bat text previews. Ctrl-R searches history; Ctrl-T and Alt-C retain native fzf behavior. |
| ripgrep | `rg pattern path` searches file contents with native ignore rules. |
| bat | `bat file` provides syntax highlighting and paging, using its built-in `ansi` theme. |
| eza | `eza --long --group-directories-first --icons=auto` lists files; `eza --tree --level=2` shows a shallow tree. |
| zoxide | `z path` visits a directory; `z fragment` jumps to a learned location; `zi` selects interactively with fzf. |
| tldr | Run `tldr --update` once to populate the cache, then `tldr tar` for concise examples. |
| btop | Run `btop` for resource/process monitoring, with vi navigation and a static built-in dark appearance. |
| fastfetch | Run `fastfetch` for OS, kernel, uptime, shell, terminal, CPU, memory, and disk information. |
| dua | `dua aggregate .` summarizes disk usage; `dua interactive .` explores it. Deletion is an explicit action inside the TUI. |

`ls`, `cd`, `find`, `grep`, `cat`, global pagers, and editor settings are not
replaced. In particular, core's native `ls` color alias remains unchanged.
Icons require a suitable font, but text workflows do not require an
Omarchy-specific terminal or desktop.

Bash and Zsh use native fzf/zoxide initialization through the core loader.
Zsh completion is initialized if not already available. fzf owns Ctrl-R;
McFly and its old `mhistory` alias are no longer included. Missing tools
and initialization failures produce diagnostics. `ff` preserves fzf's result
and cancellation status, and quotes preview filenames through fzf's placeholder
handling. fzf defaults to a terminal-palette color scheme unless
`FZF_DEFAULT_OPTS` is already set.

Tealdeer uses English pages by default to avoid invalid language selection in
`C` locales, and native system certificate trust on both platforms. Other
languages remain available through `tldr --language <language> --update` and
`tldr --language <language> <command>`. Cache downloads require network access;
TLS verification remains enabled. See the
[tealdeer configuration](https://docs.tealdeer.org/stable/config_updates.html).

Fastfetch and the monitoring tools never run automatically at shell startup.
No desktop launchers, theme-switching links, or automatic cleanup are included.
Lazygit keeps native configuration defaults; Git, Neovim, tmux, and Herdr
configuration remains owned by their respective features.

Hunk retains its native `github-dark-default` theme, keyboard navigation,
help, and adaptive split/unified layout without extra configuration.
It complements lazygit and replaces delta for explicit diff review:
`mdiff` runs `hunk diff`. Git pagers stay unchanged; Hunk is not configured as
a drop-in delta pager. Compare two files with `mdiff --files old new`.
Pass `hunk diff --watch` explicitly as the diff command to an existing tmux
or Herdr development layout when desired; no layout defaults are changed.

## Overlap decisions

| Removed tool | Preferred workflow |
| --- | --- |
| delta | Hunk diff review (`mdiff`) |
| lsd | eza listings (`mls`, `ll`, `la`) |
| dust | dua disk-usage summaries (`mdu`) |
| broot | eza trees (`mtree`), fzf selection (`ff`), and zoxide navigation (`z`/`zi`) |
| McFly | Native fzf Ctrl-R history recall |
| cheat | tldr command examples |
| glances | btop resource monitoring (`mtop`) |
| procs | btop process monitoring (`mtop`) |

These consolidate workflows, not identical APIs. Hunk does not take all delta
arguments, eza does not reproduce broot's file-management UI, tldr does not
provide personal cheat-sheet authoring, and btop does not replace Glances'
server mode or procs' scriptable process listings. The old `mps` and `mhistory`
aliases are removed rather than pretending to preserve those interfaces.

The macOS installer still includes glow for Markdown rendering, duf for
filesystem free space, jq, sd, gping, httpie, and doggo alongside the selected
tools. Ubuntu installation covers the selected tools, not all these
non-overlapping additions.

Current m-prefixed aliases:

```text
mcat=bat          mls=eza       mdiff='hunk diff'    mdu='dua aggregate'
mdf=duf           mtree='eza --tree'               mfind=fd
mgrep=rg          mjson=jq      msd=sd              mtop=btop
mping=gping       mdig=doggo
```

`ll='eza -lh'` and `la='eza -lha'` provide long listings, with hidden entries
included by `la`. Neither changes `ls`.

Aliases for unselected tools still require those tools to be installed.

Removing packages from the installer does not uninstall existing copies.
Any host uninstall is a separate, explicit operation after checking dependents
and active configuration; it is never performed by feature hooks. Personal
configuration, caches, and custom cheat sheets are preserved. Open a fresh
shell after applying configuration: already-running shells can retain old
aliases even after their definitions are removed from the payload.

## Validation

After installing the feature and the test prerequisites (Bash, Zsh, jq, rsync,
Python 3, and Git), run:

```sh
./features/modern-unix/tests/run.sh
```

The focused suite uses temporary HOME/XDG directories. It checks configuration
repeatability, custom destinations, preservation, command-name normalization,
all selected executables, retained/removed package requests, replacement aliases,
native filtering, shell bindings, preview filename
safety, cancellation, and installer failure paths. PTY checks exercise real
fzf previews, lazygit's first-launch screen, Hunk working-tree review and live
watch updates, btop, and dua without deleting data.
Offline tldr rendering is tested; `tldr --update` and real page lookup should
also be checked separately with an isolated cache when validating releases.

Physical key delivery, fonts, appearance, and platform-specific monitoring
capabilities still warrant manual checks in the user's terminal.

The suite and separate live tldr cache downloads/page lookups passed on ARM64
macOS and Ubuntu 26.04. Ubuntu installation was also repeated successfully.
Both Linux dua and Hunk release archive digests were verified; x86_64 execution
was not tested. Hunk 0.24.0 is installed on the current Mac. Its diff/watch
checks pass on both tested systems. The current Mac's real Bash/Zsh integration
and configuration were verified separately from the isolated tests.

The consolidation was also validated after uninstalling the eight superseded
formulas from the Mac: no additional Homebrew formulas were removed, all 19
retained commands remained available, and fresh Bash/Zsh shells used the
replacement aliases. The same alias and package-selection tests pass on
Ubuntu 26.04 ARM64.

## References

- [Omarchy shell tools](https://omarchy.org/manual/shell-tools/)
- [Omarchy TUIs](https://omarchy.org/manual/tuis/)
- [dua](https://github.com/Byron/dua-cli)
- [Hunk](https://www.hunk.dev/)
- [tealdeer](https://docs.tealdeer.org/stable/)
