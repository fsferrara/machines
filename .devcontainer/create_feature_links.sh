#! /usr/bin/env sh

set -e
set -u


SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
REPO_DIR=$(dirname -- "${SCRIPT_DIR}")
SOURCE_FEATURES_DIR="${REPO_DIR}/features"


if [ ! -d "${SOURCE_FEATURES_DIR}" ]; then
	printf '❌ Features directory not found: %s\n' "${SOURCE_FEATURES_DIR}" >&2
	exit 1
fi


if [ -L "${SCRIPT_DIR}/features" ] || [ -f "${SCRIPT_DIR}/features" ]; then
	rm -f "${SCRIPT_DIR}/features"
fi

if [ -d "${SCRIPT_DIR}/features" ]; then
	rm -rf "${SCRIPT_DIR}/features"
fi

for existing_link in "${SCRIPT_DIR}"/*; do
	if [ ! -L "${existing_link}" ]; then
		continue
	fi

	link_target=$(readlink "${existing_link}")
	case "${link_target}" in
		../features/*)
			rm -f "${existing_link}"
			;;
	esac
done


feature_count=0
for feature_dir in "${SOURCE_FEATURES_DIR}"/*; do
	if [ ! -d "${feature_dir}" ]; then
		continue
	fi

	if [ ! -f "${feature_dir}/devcontainer-feature.json" ]; then
		continue
	fi

	feature_name=$(basename -- "${feature_dir}")
	ln -s "../features/${feature_name}" "${SCRIPT_DIR}/${feature_name}"
	feature_count=$((feature_count + 1))
done


printf '✅ Linked %s feature(s) in %s\n' "${feature_count}" "${SCRIPT_DIR}"
