# LeoJSON License and Notice

LeoJSON is licensed under the Apache License, Version 2.0.

SPDX identifier:

```text
Apache-2.0
````

## JSONKit

LeoJSON vendors JSONKit as an internal parser and serializer engine candidate.

JSONKit is dual licensed under either the BSD License or the Apache License,  
Version 2.0. LeoJSON uses the vendored JSONKit source under the Apache License,  
Version 2.0 option.

The original JSONKit copyright and license notices remain preserved in:

```text
vendor/JSONKit/
```

## Public API boundary

JSONKit is not public LeoJSON API.

The supported public API is defined by:

```text
sources/LeoJSON/LeoJSON.h
```

Release packages expose this as:

```text
include/LeoJSON.h
```

Application code must not include JSONKit headers directly.

## Release gate

A public LeoJSON release must include:

- LICENSE
    
- NOTICE
    
- preserved vendor notices
    
- public/private API boundary documentation  
    

