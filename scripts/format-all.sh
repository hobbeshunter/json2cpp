#!/usr/bin/env bash

# Adopted from https://gitlab.com/VladyslavUsenko/basalt/-/blob/master/scripts/clang-format-all.sh
# original license: BSD 3-Clause License

# Format all source files in the project.
# Optionally take folder as argument; default is full inlude and src dirs.

###################################################
# Format cpp

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

CPP_FOLDER="${1:-$SCRIPT_DIR/../src $SCRIPT_DIR/../test $SCRIPT_DIR/../test_package}"

CLANG_FORMAT_COMMANDS="clang-format clang-format-16 clang-format-15 clang-format-14"

# find the first available command:
for CMD in $CLANG_FORMAT_COMMANDS; do
    if hash $CMD 2>/dev/null; then
        CLANG_FORMAT_CMD=$CMD
        break
    fi
done

if [ -z $CLANG_FORMAT_CMD ]; then
    echo "clang-format not installed..."
    exit 1
fi

# clang format check version
MAJOR_VERSION_NEEDED=14

MAJOR_VERSION_DETECTED=`$CLANG_FORMAT_CMD -version | sed -n -E 's/.*version ([0-9]+).*/\1/p'`
if [ -z $MAJOR_VERSION_DETECTED ]; then
    echo "Failed to parse major version (`$CLANG_FORMAT_CMD -version`)"
    exit 1
fi

echo "clang-format version $MAJOR_VERSION_DETECTED (`$CLANG_FORMAT_CMD -version`)"

if [ $MAJOR_VERSION_DETECTED -lt $MAJOR_VERSION_NEEDED ]; then
    echo "Looks like your clang format is too old; need at least version $MAJOR_VERSION_NEEDED"
    exit 1
fi

find $CPP_FOLDER -type d -name "*build*" -prune -o \(  -iname "*.?pp" -or -iname "*.h" \) -print | \
 xargs $CLANG_FORMAT_CMD -verbose -i


###################################################
# Format cmake

if ! hash cmake-format 2>/dev/null; then
    echo "cmakelang not installed..."
    exit 1
fi

CMAKE_FOLDER="${1:-$SCRIPT_DIR/../}"

find $CMAKE_FOLDER -type d -name "*build*" -prune -o \( -iname "*.cmake" -or -iname "CMakeLists.txt" \) -print | \
 xargs cmake-format -l=info -i --config-file=$SCRIPT_DIR/../cmake-format.py

