#! /usr/bin/env sh

set -eu

case "$(uname -m)" in
    aarch64|arm64)
        architecture=arm64
        checksum=827b4aa879feecab33ea621dc1460c60ffa765c210b5046d679ce5a4073d2b32
        ;;
    x86_64|amd64)
        architecture=amd64
        checksum=5c59b5380c5165b473c06148c108ee60a18a1f9961f8013e38b4a68ed5def641
        ;;
    *)
        printf 'cliamp: Ubuntu ARM64 and x86_64 are supported only.\n' >&2
        exit 1
        ;;
esac

sudo apt update
alsa=libasound2
if apt-cache show libasound2t64 >/dev/null 2>&1; then
    alsa=libasound2t64
fi
sudo apt install -y ca-certificates curl coreutils "$alsa" ffmpeg yt-dlp

version=2.3.0
temporary=$(mktemp -d)
trap 'rm -f "$temporary/cliamp"; rmdir "$temporary"' 0
trap 'exit 1' HUP INT TERM
curl --fail --location --show-error \
    "https://github.com/bjarneo/cliamp/releases/download/v${version}/cliamp-linux-${architecture}" \
    -o "$temporary/cliamp"
if ! printf '%s  %s\n' "$checksum" "$temporary/cliamp" | sha256sum --check; then
    printf 'cliamp: binary checksum verification failed.\n' >&2
    exit 1
fi
chmod +x "$temporary/cliamp"
"$temporary/cliamp" --version

if [ -L /usr/local/bin/cliamp ] ||
    { [ -e /usr/local/bin/cliamp ] && ! cmp -s "$temporary/cliamp" /usr/local/bin/cliamp; }; then
    printf 'cliamp: refusing to replace an existing /usr/local/bin/cliamp; resolve it explicitly before installation.\n' >&2
    exit 1
fi
if [ ! -e /usr/local/bin/cliamp ]; then
    sudo install -m 0755 "$temporary/cliamp" /usr/local/bin/cliamp
fi
ffmpeg -version
yt-dlp --version
