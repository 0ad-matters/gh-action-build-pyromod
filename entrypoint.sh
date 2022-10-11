#!/bin/bash
set -ev

if [ -z "$INPUT_DIRECTORY" ]; then
    INPUT_DIRECTORY="."
fi

OUTPUT_DIR=/github/workspace/output
mkdir -m 777 -p $OUTPUT_DIR
OUTPUT_FILE="$OUTPUT_DIR/$INPUT_NAME-$INPUT_VERSION.pyromod"

# pyrogenesis won't run this as root
su user0ad --command "/home/user0ad/usr/bin/pyrogenesis  \
    -mod=package_mod   \
    -archivebuild=$INPUT_DIRECTORY  \
    -archivebuild-output=$OUTPUT_FILE    \
    -archivebuild-compress" \
    && test -f "$OUTPUT_FILE"

zip -d "$OUTPUT_FILE" ".git*"

for item in $INPUT_REMOVE_FROM_PYROMOD; do
  if [ -z "${item##*.git*}" ]; then
    continue
  fi
  zip -d "$OUTPUT_FILE" "$item"
done
