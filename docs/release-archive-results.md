# LeoJSON Release Archive Results

## Result

LeoJSON can generate and verify a distributable Leopard/PowerPC release archive.

The verification target extracts the generated archive and checks for the public
headers, static library, README, and checksum file.

## Artifact pattern

```text
dist/LeoJSON-<version>-leopard-ppc.tar.gz
dist/LeoJSON-<version>-leopard-ppc.tar.gz.sha256
````

## Interpretation

LeoJSON now has the complete release-candidate packaging path:

- release layout
    
- archive generation
    
- SHA256 checksum
    
- archive verification
    

Generated archives remain build artifacts and are not committed to the  
repository.  

