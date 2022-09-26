# GitHub Action to build a 0ad pyromod file

This is a [GitHub Action](https://github.com/features/actions) that
will build a [0ad
pyromod](https://trac.wildfiregames.com/wiki/Modding_Guide#Distributingyourmods).

## Usage

This action requires that the root directory of your mod is in your
repository root (i.e., your 'mod.json' is located in the repository
root).

In this case, when a new a release and tag is created (if the tag
starts with a 'v'), the built mod will get uploaded to the release
page, along with a corresponding sha256sum.

This file needs to be placed in

    <your_repo_root>/.github/workflows/<filename>.yml

(where `<filename>` can be anything you like)

The [release
action](https://github.com/0ad-matters/gh-action-build-pyromod/blob/trunk/README.md)
used in the example below is a separate action (not maintained by this
project) and can be replaced by a different release action if you
like.

```yaml
name: Build Pyromod

on:
  push:
    tags:
      - v**

jobs:
  build-pyromod:
    runs-on: ubuntu-latest
    env:
      MOD_NAME: ${{ github.repository }}
      MOD_VERSION: ${{ github.ref_name }}
    steps:
    - uses: actions/checkout@v3
    - name: Massage Variables
      run: |
        # remove "<owner>/" from repository string
        echo "MOD_NAME=${MOD_NAME#*/}" >> $GITHUB_ENV
        # remove 'v' from version string
        echo "MOD_VERSION=${MOD_VERSION:1}" >> $GITHUB_ENV
    - uses:  0ad-matters/gh-action-build-pyromod@v1.1
      with:
        name: ${{ env.MOD_NAME }}
        version: ${{ env.MOD_VERSION }}
      id: build-pyromod
    - name: Create sha256sum
      run:  |
        OUTPUT_FILE="$MOD_NAME-$MOD_VERSION.pyromod"
        cd output
        sha256sum $OUTPUT_FILE > $OUTPUT_FILE.sha256sum
    - name: Release PyroMod
      uses: ncipollo/release-action@v1.1
      with:
        allowUpdates: True
        prerelease: False
        artifacts: "output/${{ env.MOD_NAME }}*.*"
        token: ${{ secrets.GITHUB_TOKEN }}
        omitNameDuringUpdate: True
        omitBodyDuringUpdate: True
```

## Additional Notes

The docker image used by this action is published from
[0ad-matters/0ad-bin-nodata](https://github.com/0ad-matters/0ad-bin-nodata)
and pulled from
[andy5995/0ad-bin-nodata](https://hub.docker.com/repository/docker/andy5995/0ad-bin-nodata).
