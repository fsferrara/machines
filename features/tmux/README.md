# tmux

Installs tmux and fzf, deploys `.tmux.conf`, and adds lightweight session
management commands to the shell configuration.

## Commands

- `tmux-list` lists running sessions followed by configured sessions. Duplicate
  names are shown once.
- `tmux-connect [name]` connects to an existing session or creates it when it
  does not exist. Without a name, it opens an fzf picker.
- `tmux-new <name> [directory]` creates a session in `directory`, or in the
  current directory when omitted, and connects to it.
- `tmux-attach [name]` is an alias for `tmux-connect`.
- `tmux-new-detached`, `tmux-kill`, and `tmux-kill-all` remain low-level tmux
  shortcuts.

Connecting attaches when called outside tmux and switches the current client
when called from inside tmux.

## Configured sessions

Session definitions live in:

```text
${XDG_CONFIG_HOME:-$HOME/.config}/tmux/sessions.d
```

Set `TMUX_SESSIONS_DIR` to use another directory. Each `NAME.sh` file defines a
session named `NAME`:

```sh
TMUX_SESSION_DIRECTORY="$HOME/workspace/project"
TMUX_SESSION_COMMAND='nvim'
```

`TMUX_SESSION_DIRECTORY` is required. `TMUX_SESSION_COMMAND` is optional and
runs in the first window only when the session is created. When it exits, the
window returns to your shell. Reconnecting to a running session does not run it
again.

For sessions that need multiple windows, define `tmux_session_create` instead.
It receives the session name and directory, and must create the named session
in detached mode without attaching to it. See
`.config/tmux/sessions.d/session.sh.example` for a template.

Session names cannot contain periods, slashes, or colons.

## Key bindings

With the configured `C-a` prefix:

- `C-a C-c` prompts for a session name, creates it in the current pane's
  directory, and switches to it.
- `C-a S` opens the session picker in a tmux popup.
- `C-a s` remains tmux's built-in session chooser.
- `C-a x` kills the current pane without confirmation.

`detach-on-destroy` is disabled, so closing a session does not detach the tmux
client when another session is available.