#!/bin/bash
set -e

su user0ad --command "/home/user0ad/binaries/system/pyrogenesis -mod=$INPUT_NAME  \
    -archivebuild=$PWD  \
    -archivebuild-output=${INPUT_NAME}-${INPUT_VERSION}.pyromod \
    -archivebuild-compress"

# Output the filename
cd ..
ls -l
mkdir -p /github/workspace/output/
# Move the built package into the Docker mounted workspace
mv -v *.{pyromod} /github/workspace/output/
