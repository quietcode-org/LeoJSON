
# LeoJSON Release Layout Results

## Result

LeoJSON can now produce a small release-style static-library layout.

The dist smoke probe links against the generated release package instead of
using source files directly.

## Release layout

```text
dist/LeoJSON-0.6.0/
  include/LeoJSON.h
  lib/libLeoJSON.a
  README.md
  docs/
````

## Interpretation

This confirms that LeoJSON can be consumed as a reusable Leopard-Crew brick:

- consumers include LeoJSON.h
    
- consumers link against libLeoJSON.a
    
- JSONKit remains hidden inside the library
    
- Foundation.framework remains the only public framework dependency  
    

