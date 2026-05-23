# LeoJSON Package Hardening Results

## Result

LeoJSON 0.7.0 package hardening has been verified on real Mac OS X 10.5.8
PowerPC hardware.

## Verified

- full smoke target passes
- API smoke passes
- error smoke passes
- dist smoke passes
- HeaderDoc generation completes with broken: 0
- release archive is generated
- SHA256 checksum is generated
- SHA256 checksum is compared against the generated archive
- archive extracts successfully
- required release files exist after extraction
- generated HeaderDoc API reference is included in the archive
- consumer smoke builds against the extracted archive
- consumer smoke runs successfully

## Artifact

```text
dist/LeoJSON-0.7.0-leopard-ppc.tar.gz
````

## SHA256

```text
0802e97f91415957c777287a4a5fa96dc4522d5464539298e19c66d91b2dbc6c
```

## Interpretation

LeoJSON 0.7.0 is suitable as the first Leopard/PowerPC developer-package  
baseline.  

