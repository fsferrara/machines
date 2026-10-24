# Nerd Fonts

Installs [getnf](https://github.com/ronniedroid/getnf) and uses it to install
**JetBrainsMono** on macOS and Ubuntu. This is the font prerequisite for the
[Ghostty feature](../ghostty/README.md).

Install [core](../../core/README.md) first, then:

```sh
./features/nerdfonts/install.sh
```

JetBrainsMono is this feature's default selection. Installation does not remove
other fonts or change other applications' font preferences.

When getnf is already installed, the same font can be installed directly:

```sh
~/.local/bin/getnf -i JetBrainsMono
```

Ghostty uses the family `JetBrainsMono Nerd Font`, style `Regular`. Verify the
family using `ghostty +list-fonts --family='JetBrainsMono Nerd Font' --style=Regular`
(or the Ghostty app-bundle executable on macOS). Check family resolution rather
than assuming that successful download output proves the font is available.
