# LeoJSON Versioning

LeoJSON exposes simple preprocessor version macros in:

```text
sources/LeoJSON/LeoJSONVersion.h
````

Release packages expose this header through the public include directory.

## Macros

```c
LEOJSON_VERSION_MAJOR
LEOJSON_VERSION_MINOR
LEOJSON_VERSION_PATCH
LEOJSON_VERSION_STRING
LEOJSON_VERSION_NUMBER
```

## Version number format

```text
major * 10000 + minor * 100 + patch
```

For example:

```text
0.7.0 -> 700
```

LeoJSON is still pre-1.0. Public API details may still change before the first  
stable release.  

