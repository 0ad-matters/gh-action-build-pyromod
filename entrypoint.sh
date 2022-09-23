#!/bin/bash
set -e

export OUTPUT_DIR=/github/workspace/output
mkdir -m 777 -p $OUTPUT_DIR

# pyrogenesis with throw an error if run as root
su user0ad --command  "/home/user0ad/binaries/system/pyrogenesis  \
    -mod=$INPUT_NAME    \
    -archivebuild=$PWD  \
    -archivebuild-output=${OUTPUT_DIR}/${INPUT_NAME}-${INPUT_VERSION}.pyromod    \
    -archivebuild-compress"
