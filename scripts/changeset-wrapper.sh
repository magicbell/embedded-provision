#!/usr/bin/env bash

# make sure the script runs relative to the repo root
set -euo pipefail && cd "$(dirname "${BASH_SOURCE[0]}")/.."

# some helpers and error handling:
info()  { printf "%s\n" "$*" >&1; }
error() { printf "%s\n" "$*" >&2; }
trap 'echo Changeset interrupted >&2; exit 2' INT TERM

# pass all arguments to changeset
./node_modules/.bin/changeset "$@"

changeset_exit=$?
if [ ${changeset_exit} -gt 0 ];
then
    error "Changeset finished with error"
    exit ${changeset_exit}
fi

# if first argument was `version` also run the `update-version.ts` script
args=("$@")
if [ $# -gt 0 ] && [ ${args[0]} = "version" ]
then
    yarn tsx scripts/update-version.ts
fi