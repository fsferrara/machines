# Cliamp

An opt-in terminal music player for macOS and Ubuntu, adapted from
[Omarchy's Cliamp workflow](https://omarchy.org/manual/tuis/#cliamp).
It plays local music and radio streams using native controls, with one
Tokyo Night dark theme. No desktop launcher, Hyprland binding, shell alias,
or Omarchy runtime is required.

## Installation

Install [core](../../core/README.md) first, then select this feature:

```sh
./install.sh
./features/cliamp/install.sh
```

The feature installs **cliamp, ffmpeg, and yt-dlp**. ffmpeg enables additional
formats such as AAC, ALAC, Opus, and WMA; yt-dlp enables supported online sources.
The default devcontainer is unchanged; audio access in containers and remote
sessions is not assumed.

- **macOS (Apple Silicon or Intel):** Homebrew installs
  `bjarneo/cliamp/cliamp`, its codec libraries, ffmpeg, and yt-dlp.
  Homebrew manages the cliamp version.
- **Ubuntu (ARM64 or x86_64):** The installer downloads cliamp **v2.3.0**,
  checks an architecture-specific SHA-256 digest, and installs it to
  `/usr/local/bin/cliamp`. apt supplies ffmpeg, yt-dlp, and the ALSA runtime
  (`libasound2`, or `libasound2t64` on newer Ubuntu).
  Enable Ubuntu's universe repository if media packages are unavailable.
  Ubuntu 22.04 and 26.04 ARM64 are verified; other releases are not tested.

The Ubuntu installer leaves an identical binary alone and refuses to replace
a different binary or symlink at its destination. Resolve such conflicts
explicitly before installing; there is no automatic migration or removal.
Updating the pinned release requires updating both architecture digests in
[the Ubuntu installer](install/ubuntu.sh) and validating the new binaries.
On macOS use Homebrew's normal upgrade workflow.

Ubuntu's media packages follow the distribution's versions. Older yt-dlp
versions, especially on Ubuntu 22.04, may not work with changing online services.
Installation success does not guarantee every provider works. Updating media
tools beyond the distribution packages is a separate, user-managed choice;
this feature does not install an additional Python package manager.

## Configuration

With the software already installed:

```sh
./features/cliamp/configure.sh
./features/cliamp/configure.sh /path/to/target-home
```

[The configuration hook](pre-configure.sh) sets only the top-level
`theme = "tokyo-night"` in the destination's `.config/cliamp/config.toml`.
It creates missing configuration, or updates the existing file atomically,
preserving other settings, comments, and file permissions. A new live config
is private (mode `0600`). An unchanged live config is not replaced.
An inline comment on the theme setting is moved to its own preceding line:
cliamp v2.3.0 otherwise treats it as part of the theme name.
[The copied example](config/.config/cliamp/config.toml.example) is
feature-managed; the live configuration is never blindly rsynced over.

Each configure run resets the saved theme to Tokyo Night. Cliamp's native
theme picker is not disabled; subsequent configuration restores this default.
Close cliamp before reconfiguring to avoid concurrent writes. Custom themes,
provider credentials, playlists, favorites, and playback state remain
user-managed. Upstream custom themes named `tokyo-night` can override the
built-in palette; this feature does not delete or overwrite them.

For safety, the hook refuses symlinked config paths, non-regular config files,
duplicate root theme keys, and syntax it cannot safely update, including
multiline strings, quoted root theme keys, and commented section headers.
Failures include a diagnostic and leave the original live config intact.
Use cliamp's supported line-oriented configuration syntax; no general TOML
rewriter or automatic cleanup is installed.

Like other repository features, configuration targets a home directory.
`CLIAMP_CONFIG_DIR` and `XDG_CONFIG_HOME` do not redirect the feature's writes.
Cliamp itself honors those overrides, so users of custom config directories
must manage their theme there separately. Configuring another destination never
uses the invoking user's override directories.

## Usage

```sh
cliamp
cliamp ~/Music
cliamp track.mp3
cliamp https://example.com/radio-stream
cliamp --help
cliamp --audio-device list
```

Use `?` or `Ctrl+K` for the native keybinding list in v2.3.0, and
`cliamp setup` for user-managed remote providers. No provider accounts,
credentials, media downloads, or personal library locations are configured
by this feature.

## Ubuntu audio

The ALSA runtime is installed, but sound-server bridge packages and device
routing are not configured automatically. Use the bridge appropriate to the
machine's existing sound server if cliamp reports `audio output unavailable`:

```sh
# Existing PipeWire setup:
sudo apt install pipewire-alsa

# Existing PulseAudio setup:
sudo apt install libasound2-plugins
```

These are alternatives, not instructions to replace the sound stack. Check
`cliamp --audio-device list` and the system's audio settings before choosing a
device. WSL, containers, and remote sessions may need additional host audio
forwarding and permissions; installing a library alone does not provide sound.
See [upstream troubleshooting](https://github.com/bjarneo/cliamp/tree/v2.3.0#troubleshooting).

## Validation

Run the focused shell tests with Bash, jq, rsync, and standard Unix tools:

```sh
./features/cliamp/tests/run.sh
```

They check shared-script equality, metadata, configuration repeatability,
theme enforcement, permissions, user-file preservation, destination isolation,
unsafe-input failures, and mocked installation/error handling for both Ubuntu
architectures and macOS. Installer mocks relocate the binary destination to
an isolated temporary directory; they never install into the host.

With Python 3 and a runnable cliamp binary, also check real TUI startup and
Tokyo Night truecolor output in an isolated pseudo-terminal:

```sh
python3 features/cliamp/tests/runtime.py
# Or provide an explicit binary:
python3 features/cliamp/tests/runtime.py /path/to/cliamp
```

The runtime test uses a temporary home, does not play audio, and terminates
its child process. On Linux it explicitly supplies an isolated ALSA null-device
fixture so a soundless container can render the TUI; no host audio configuration
is changed. Interactive key delivery, audible local/radio playback,
online-provider compatibility, and actual terminal appearance still require
manual checks on an audio-capable machine.

Verified with cliamp v2.3.0 on macOS ARM64 and Ubuntu 22.04/26.04 ARM64:
focused shell tests and real TUI/theme checks pass. Real Ubuntu installation
passed on both releases, including an identical reinstall on 22.04. Intel
architecture selection and Homebrew commands are tested through mocks, not
an Intel machine or a full macOS Homebrew install.

## References

- [Omarchy TUI manual](https://omarchy.org/manual/tuis/#cliamp)
- [Upstream installation and troubleshooting](https://github.com/bjarneo/cliamp/tree/v2.3.0#readme)
- [Configuration](https://github.com/bjarneo/cliamp/blob/v2.3.0/docs/configuration.md)
- [Themes](https://github.com/bjarneo/cliamp/blob/v2.3.0/docs/themes.md)
- [CLI flags](https://github.com/bjarneo/cliamp/blob/v2.3.0/docs/cli.md)
