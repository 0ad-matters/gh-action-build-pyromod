#!/bin/bash
set -e

ls -l

cd /github/workspace

ls -al

su user0ad --command "/home/user0ad/binaries/system/pyrogenesis -mod=$INPUT_NAME  \
    -archivebuild=/github/workspace  \
    -archivebuild-output=/github/workflow/${INPUT_NAME}-${INPUT_VERSION}.pyromod \
    -archivebuild-compress"
