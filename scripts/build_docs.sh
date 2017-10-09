#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# make sure jazzy is installed
command -v jazzy >/dev/null 2>&1 || { echo >&2 "Jazzy is not installed.  Aborting."; exit 1; }

# build the docs
jazzy --config "${DIR}/../.jazzy.yaml" --output "${DIR}/../docs/"
