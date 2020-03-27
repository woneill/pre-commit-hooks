#!/usr/bin/env bash
set -eu

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
	set -x
fi

ERROR=0

if [ $# -gt 0 ]; then
	for FILE in "${@}"; do
		if ! grep -C10000 "sops:" "$FILE" | grep -q "version:"; then
			echo "[ERROR] ${FILE} is not encrypted"
			echo "        Run: helm secrets enc $FILE"
			ERROR=1
		fi
	done
fi

if [ $ERROR -gt 0 ]; then
	exit 1
fi
