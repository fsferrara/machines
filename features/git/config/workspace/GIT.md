My git configuration files:

- `.gitconfig` - global configuration
- `.gitconfig-personal` - configuration file for the personal profile
- `.gitconfig-work` - configuration file for the work profile
- `.gitignore_global` - globally ignored files


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
