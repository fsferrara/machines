# Git Feature

My Git configuration files.

## Conditional Includes

In the `.gitconfig` file, you can conditionally include other configuration files based on the repository path. For example, instead of the user detail in `.gitconfig`, you can conditionally include a separate configuration file for repositories in the `~/workspace/personal/` directory:

```ini
[includeIf "gitdir:~/workspace/personal/"]
  path = .gitconfig-personal
```

Then, create a `.gitconfig-personal` file with your personal settings:

```ini
[user]
  name = Full Name
  email = username@users.noreply.github.com
```
