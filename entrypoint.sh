#!/bin/bash
set -ev

# Set the default input directory if not provided
if [ -z "$INPUT_DIRECTORY" ]; then
    INPUT_DIRECTORY="."
fi

# Create the output directory
OUTPUT_DIR=/github/workspace/output
mkdir -m 777 -p $OUTPUT_DIR

# Set the output file path/filename
OUTPUT_FILE="$OUTPUT_DIR/$INPUT_NAME-$INPUT_VERSION.pyromod"

# pyrogenesis won't run this as root. run as non-root user
su user0ad --command "/home/user0ad/usr/bin/pyrogenesis \
    -mod=package_mod \
    -archivebuild=$INPUT_DIRECTORY \
    -archivebuild-output=$OUTPUT_FILE \
    -archivebuild-compress" \
    && test -f "$OUTPUT_FILE"

# Remove git-related files from the output file
zip -d "$OUTPUT_FILE" ".git*"

# Remove additional specified files from the output file
for item in $INPUT_REMOVE_FROM_PYROMOD; do
  if [ -z "${item##*.git*}" ]; then
    continue
  fi
  zip -d "$OUTPUT_FILE" "$item"
done
