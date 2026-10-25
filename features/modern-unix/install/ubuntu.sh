#! /usr/bin/env sh

set -eu

case "$(uname -m)" in
    aarch64|arm64)
        architecture=aarch64
        checksum=a7ba6bce1f1d16392b4c9f385e7439deda71627ed3c55eb09d5dfcbe6b481a58
        hunk_architecture=arm64
        hunk_checksum=eaaba9f5c0c184db4a8493ac386b112ee8cbb553884c4a0e5e04138def5e2d29
        ;;
    x86_64|amd64)
        architecture=x86_64
        checksum=4f284a388a063a99f938c6e0f5ea8d932868e1f9a4224622d97488f4ec671b41
        hunk_architecture=x64
        hunk_checksum=7656402a8ebbd5117ad24e12bda1af045fc9c85c3b40e72dbfde4dea79b60c69
        ;;
    *)
        printf 'modern-unix: dua and Hunk support Ubuntu ARM64 and x86_64 only.\n' >&2
        exit 1
        ;;
esac

##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}

candidate=$(apt-cache policy fzf | sed -n 's/^[[:space:]]*Candidate: //p')
if [ -z "$candidate" ] || [ "$candidate" = "(none)" ] ||
    ! dpkg --compare-versions "$candidate" ge 0.48; then
    printf 'modern-unix: fzf >= 0.48 is required; apt candidate: %s. Use Ubuntu 26.04 with universe enabled.\n' "${candidate:-missing}" >&2
    exit 1
fi

###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
${CMD_INSTALL} lazygit fd-find fzf ripgrep bat eza zoxide tealdeer btop fastfetch \
    ca-certificates curl tar coreutils gping glow duf sd httpie 

install_release() (
    name=$1
    url=$2
    digest=$3
    member=$4
    temporary=$(mktemp -d)
    trap 'rm -f "$temporary/$name.tar.gz" "$temporary/$name"; rmdir "$temporary"' 0
    trap 'exit 1' HUP INT TERM
    curl --fail --location --show-error "$url" -o "$temporary/$name.tar.gz"
    if ! printf '%s  %s\n' "$digest" "$temporary/$name.tar.gz" | sha256sum --check; then
        printf 'modern-unix: %s archive checksum verification failed.\n' "$name" >&2
        exit 1
    fi
    tar -xOf "$temporary/$name.tar.gz" "$member" > "$temporary/$name"
    chmod +x "$temporary/$name"
    "$temporary/$name" --version

    if [ -L "/usr/local/bin/$name" ] ||
        { [ -e "/usr/local/bin/$name" ] && ! cmp -s "$temporary/$name" "/usr/local/bin/$name"; }; then
        printf 'modern-unix: refusing to replace an existing /usr/local/bin/%s; resolve it explicitly before installation.\n' "$name" >&2
        exit 1
    fi
    if [ ! -e "/usr/local/bin/$name" ]; then
        sudo install -m 0755 "$temporary/$name" "/usr/local/bin/$name"
    fi
)

version=2.46.0
archive="dua-v${version}-${architecture}-unknown-linux-musl"
install_release dua \
    "https://github.com/Byron/dua-cli/releases/download/v${version}/${archive}.tar.gz" \
    "$checksum" "$archive/dua"

hunk_version=0.24.0
hunk_archive="hunkdiff-linux-${hunk_architecture}"
install_release hunk \
    "https://github.com/modem-dev/hunk/releases/download/v${hunk_version}/${hunk_archive}.tar.gz" \
    "$hunk_checksum" "$hunk_archive/hunk"


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
