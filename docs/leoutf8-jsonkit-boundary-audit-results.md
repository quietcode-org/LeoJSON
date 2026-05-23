# LeoJSON / LeoUTF8 / JSONKit Boundary Audit Results

## Result

The UTF-8 boundary inventory confirms that JSONKit contains deeply integrated
UTF-8, UTF-32, Unicode escape, and surrogate-pair handling.

LeoJSON must not replace or patch JSONKit's internal Unicode machinery without a
measured release-critical defect.

## Key findings

JSONKit includes:

- ConvertUTF-derived UTF-8 / UTF-32 conversion and verification
- UTF-8 legality checks
- raw UTF-8 string parsing
- JSON `\uXXXX` escape handling
- surrogate-pair handling inside JSON strings
- strict error paths for illegal UTF-8 and illegal Unicode escape sequences

## Interpretation

JSONKit's Unicode handling is parser-internal behavior, not a replaceable
general text-policy layer.

LeoUTF8 remains the Leopard-Crew general UTF-8 authority, but LeoJSON 0.7.x
should not route JSONKit internals through LeoUTF8.

## Boundary rule

```text
LeoUTF8  = general UTF-8 and text policy
JSONKit  = JSON parser, JSON serializer, JSON escapes, JSON surrogate handling
LeoJSON  = public API boundary, errors, documentation, integration policy
````

## Decision

No production-code integration of LeoUTF8 is added in this audit.

LeoJSON may use LeoUTF8 later only as an external boundary check if a concrete  
need is demonstrated, such as:

- JSONKit accepting invalid raw UTF-8 that LeoUTF8 rejects
    
- JSONKit raising an exception not already contained by LeoJSON
    
- a consumer requiring explicit LeoUTF8 policy enforcement before JSON parsing
    

Until then, JSONKit remains unchanged.  

