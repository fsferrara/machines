# SSH Feature

Use SSH host aliases to select a different key per GitHub account.

In `~/.ssh/config`,:
- `github.com-personal` points to `github.com` with `~/.ssh/id_personal`,
- `github.com-work` points to `github.com` with `~/.ssh/id_work`.

For cloning, use the matching URI export:
- `SSH_GITHUB_PERSONAL_URI="git@github.com-personal:"`
- `SSH_GITHUB_WORK_URI="git@github.com-work:"`

`personal` and `work` are the two workspace profiles, so choose the URI that matches the profile before cloning a repository.
