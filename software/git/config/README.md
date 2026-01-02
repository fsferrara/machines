# Git Configuration

This folder contains my Git configuration files.

## Conditional Includes

In the `.gitconfig` file, you can conditionally include other configuration files based on the repository path. For example:

```ini
[includeIf "gitdir:~/github/"]
  path = .gitconfig-personal
```

Then, create a `.gitconfig-personal` file with your personal settings:

```ini
[user]
  name = Full Name
  email = username@users.noreply.github.com
```
