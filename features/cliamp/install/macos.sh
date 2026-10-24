#! /usr/bin/env sh

set -eu

brew update
brew install bjarneo/cliamp/cliamp ffmpeg yt-dlp
cliamp --version
ffmpeg -version
yt-dlp --version
