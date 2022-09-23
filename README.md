# GitHub Action to build a 0ad pyromod file

This is a [GitHub Action](https://github.com/features/actions) that
will build a [0ad
pyromod](https://trac.wildfiregames.com/wiki/Modding_Guide#Distributingyourmods)

## Usage

```yaml
on: [push]

jobs:
  build-deb:
    runs-on: ubuntu-20.04
    steps:
      - uses: actions/checkout@v3

      - uses: 0ad/0ad-bin-nodata
        id: build-pyromod
```
