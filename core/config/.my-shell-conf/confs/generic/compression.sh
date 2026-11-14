# Compression
#
# Usage:
#   compress [file/dir]: Create a tar.gz archive from the file/dir.
#   decompress [file.tar.gz]: Expand a tar.gz file.
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"
