#! /usr/bin/env sh

set -e
set -u


SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
REPO_DIR=$(dirname -- "${SCRIPT_DIR}")
SOURCE_FEATURES_DIR="${REPO_DIR}/features"
TARGET_FEATURES_DIR="${SCRIPT_DIR}/features"


if [ ! -d "${SOURCE_FEATURES_DIR}" ]; then
	printf '❌ Features directory not found: %s\n' "${SOURCE_FEATURES_DIR}" >&2
	exit 1
fi


if [ -L "${TARGET_FEATURES_DIR}" ] || [ -f "${TARGET_FEATURES_DIR}" ]; then
	rm -f "${TARGET_FEATURES_DIR}"
fi

mkdir -p "${TARGET_FEATURES_DIR}"

find "${TARGET_FEATURES_DIR}" -mindepth 1 -maxdepth 1 -exec rm -rf {} +


feature_count=0
for feature_dir in "${SOURCE_FEATURES_DIR}"/*; do
	if [ ! -d "${feature_dir}" ]; then
		continue
	fi

	if [ ! -f "${feature_dir}/devcontainer-feature.json" ]; then
		continue
	fi

	feature_name=$(basename -- "${feature_dir}")
	ln -s "../../features/${feature_name}" "${TARGET_FEATURES_DIR}/${feature_name}"
	feature_count=$((feature_count + 1))
done


printf '✅ Linked %s feature(s) in %s\n' "${feature_count}" "${TARGET_FEATURES_DIR}"
