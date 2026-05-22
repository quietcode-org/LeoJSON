# LeoJSON API Smoke Probe Results

## Result

The minimal LeoJSON public API boundary builds and runs successfully on real
Mac OS X 10.5.8 PowerPC hardware.

This confirms that application code can use LeoJSON directly without importing
or calling JSONKit APIs.

## Test system

- Machine: PowerPC G5 iMac
- OS: Mac OS X 10.5.8 Leopard
- SDK: /Developer/SDKs/MacOSX10.5.sdk
- Architecture: ppc
- Deployment target: 10.5

## gcc-4.0 result

Command:

```sh
make api-smoke-gcc40
./build/leojson_api_smoke_gcc40
````

Output:

```text
OK: LeoJSON API smoke probe passed
Roundtrip JSON: {"name":"LeoJSON","purpose":"Leopard-Crew JSON boundary","unicode":"Grüße vom G5","values":[1,2,3]}
```

## gcc-4.2 result

Command:

```sh
make api-smoke-gcc42
./build/leojson_api_smoke_gcc42
```

Output:

```text
OK: LeoJSON API smoke probe passed
Roundtrip JSON: {"name":"LeoJSON","purpose":"Leopard-Crew JSON boundary","unicode":"Grüße vom G5","values":[1,2,3]}
```

## Interpretation

The LeoJSON API boundary works as intended:

- Application code includes LeoJSON.h.
    
- Application code does not include JSONKit.h.
    
- JSONKit remains internal implementation detail.
    
- UTF-8 roundtrip smoke behavior remains intact.  
    

