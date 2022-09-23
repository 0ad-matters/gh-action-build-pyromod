# GitHub Action to build a 0ad pyromod file

This is a [GitHub Action](https://github.com/features/actions) that
will build a [0ad
pyromod](https://trac.wildfiregames.com/wiki/Modding_Guide#Distributingyourmods)

## Usage

In this case, when a new a release and tag is created (if the tag
starts with a 'v'), the built mod will get uploaded to the release
page, along with a corresponding sha256sum.

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
      MOD_NAME: <mod-name>
      MOD_VERSION: ${{ github.ref_name }}
    steps:
    - uses: actions/checkout@v3
    - run: echo "MOD_VERSION=${MOD_VERSION:1}" >> $GITHUB_ENV
    - uses:  0ad-matters/gh-action-build-pyromod@v1
      with:
        name: ${{ env.MOD_NAME }}
        version: ${{ env.MOD_VERSION }}
      id: build-pyromod
    - run: |
        OUTPUT_FILE="$MOD_NAME-${MOD_VERSION}.pyromod"
        cd output
        sha256sum $OUTPUT_FILE > ${OUTPUT_FILE}.sha256sum
    - name: Release PyroMod
      uses: ncipollo/release-action@v1
      with:
        allowUpdates: True
        prerelease: False
        artifacts: "output/${{ env.MOD_NAME }}*.*"
        token: ${{ secrets.GITHUB_TOKEN }}
        omitNameDuringUpdate: True
        omitBodyDuringUpdate: True
```
