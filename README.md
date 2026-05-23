# LeoJSON

LeoJSON is a small Leopard-Crew JSON brick for Mac OS X 10.5.8 PowerPC.

It provides a controlled public JSON API boundary for Leopard-Crew projects while
using vendored JSONKit internally as the parser and serializer engine.

## Target

- Mac OS X 10.5.8 Leopard
- PowerPC only
- Big Endian only
- G4/G5 compatible
- no Intel target
- no Universal Binary target
- no Tiger target

## Public API

Application code should include:

```objc
#import "LeoJSON.h"
````

Applications should link against:

```text
libLeoJSON.a
Foundation.framework
```

Application code must not include or call JSONKit directly. JSONKit remains an  
internal implementation detail behind the LeoJSON boundary.

## Minimal usage

```objc
NSString *errorString = nil;

id object = LeoJSONObjectFromData(jsonData,
                                  LeoJSONReadStrict,
                                  &errorString);

if (object == nil) {
    NSLog(@"LeoJSON parse failed: %@", errorString);
    return;
}

NSData *outData = LeoJSONDataFromObject(object,
                                        LeoJSONWriteCompact,
                                        &errorString);

if (outData == nil) {
    NSLog(@"LeoJSON serialization failed: %@", errorString);
    return;
}
```

Returned objects are autoreleased and follow Cocoa memory-management rules.

## Build

Default release build:

```sh
make release-gcc42
```

Full local verification:

```sh
make full-smoke-gcc42
```

Archive generation and verification:

```sh
make verify-archive-gcc42
```

## Release layout

```text
LeoJSON-<version>/
  include/
    LeoJSON.h
    LeoJSONVersion.h
  lib/
    libLeoJSON.a
  docs/
  README.md
  LICENSE
  NOTICE
  CHANGELOG.md
```

## License

LeoJSON is licensed under the Apache License, Version 2.0.

LeoJSON vendors JSONKit under its Apache License, Version 2.0 option. Original  
JSONKit copyright and license notices are preserved in `vendor/JSONKit/`.  

