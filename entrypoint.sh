#!/bin/bash
set -ev

OUTPUT_DIR=/github/workspace/output
mkdir -m 777 -p $OUTPUT_DIR
OUTPUT_FILE="$OUTPUT_DIR/$INPUT_NAME-$INPUT_VERSION.pyromod"

# pyrogenesis won't run this as root
su user0ad --command  "/home/user0ad/binaries/system/pyrogenesis  \
    -mod=$INPUT_NAME    \
    -archivebuild=$PWD  \
    -archivebuild-output=$OUTPUT_FILE    \
    -archivebuild-compress"

# For some reason this delay might be needed on small mods otherwise
# the "test" will fail.
sleep 1s

test -f "$OUTPUT_FILE"
