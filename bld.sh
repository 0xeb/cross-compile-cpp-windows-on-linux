#!/bin/bash

# Function to print usage and exit
print_usage_and_exit() {
    echo "Usage: $0 [32] [64]"
    exit 1
}

# Check if no arguments or more than two arguments are passed
if [ $# -eq 0 ] || [ $# -gt 2 ]; then
    print_usage_and_exit
fi

# Array to hold valid build types
declare -a VALID_BUILD_TYPES

# Check each argument
for arg in "$@"; do
    if [ "$arg" != "32" ] && [ "$arg" != "64" ]; then
        print_usage_and_exit
    fi
    # Add valid build type to array if not already present
    if [[ ! " ${VALID_BUILD_TYPES[@]} " =~ " ${arg} " ]]; then
        VALID_BUILD_TYPES+=("$arg")
    fi
done

# Iterate over valid build types and perform operations
for BUILD_TYPE in "${VALID_BUILD_TYPES[@]}"; do
    BUILD_DIR="build$BUILD_TYPE"
    if [ "$BUILD_TYPE" == "32" ]; then
        TOOLCHAIN_FILE="../x86_32-w64-mingw32.cmake"
    else
        TOOLCHAIN_FILE="../x86_64-w64-mingw32.cmake"
    fi

    if [ ! -d "$BUILD_DIR" ]; then
        mkdir $BUILD_DIR && cd $BUILD_DIR
        cmake .. -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE
    else
        cd $BUILD_DIR
    fi

    make
    cd ..
done