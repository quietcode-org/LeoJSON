
# LeoJSON Release Archive

LeoJSON release archives are generated from the release layout.

## Archive target

```sh
make archive-gcc42
````

## Verification target

```sh
make verify-archive-gcc42
```

## Archive name

```text
LeoJSON-<version>-leopard-ppc.tar.gz
```

## Checksum

Each archive receives a SHA256 checksum file:

```text
LeoJSON-<version>-leopard-ppc.tar.gz.sha256
```

## Rule

Generated release archives are build artifacts. They are not committed to the  
repository. They are intended for GitHub Releases or quietcode.org distribution.  

