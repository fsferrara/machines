# Generic Dev Container

Here is a generic dev container containing my configuration.

## Throuble shooting

### Locale warning

If you are getting the following warning when you start the container:

```shell
bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
```

The problem that your host machine is using a locale that is not installed in the container. In addition, during the container build, it forwards the locale settings from the host machine to the container, which causes the warning. To fix this, you can either install the missing locale in the container or change the locale settings on the host machine.

Setting a compatible locale on the host machine is the easiest solution.  
For macosx, go to: System Preferences > General > Language & Region
Set:

- Preferred languages: English (United States)
- Region: United States

Optionally, you can also set the following settings to match the US locale:

- Calendar: Gregorian
- Temperature unit: Fahrenheit
- Measurement system: US
- First day of week: Sunday
- Date format: 12/31/2024
- Number format: 1,234.56
