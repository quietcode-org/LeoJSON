# LeoJSON Package Hardening

LeoJSON 0.7.0 hardens the release package so the archive can be treated as a
developer-facing artifact instead of only an engineering build product.

## Hardened package contents

The release package includes:

- public headers
- static library
- README.md
- LICENSE
- NOTICE
- CHANGELOG.md
- hand-written project documentation
- generated HeaderDoc API reference

## Verification

The archive verification target checks that:

- required release files exist after extraction
- the SHA256 file exists
- the SHA256 digest matches the generated archive
- a consumer smoke binary builds against the extracted archive
- the consumer smoke binary runs successfully

## Target

```sh
make verify-archive-gcc42
```

