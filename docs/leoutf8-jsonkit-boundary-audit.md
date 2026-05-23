# LeoJSON / LeoUTF8 / JSONKit Boundary Audit

## Purpose

This audit clarifies the boundary between LeoJSON, LeoUTF8, and JSONKit.

It does not change production behavior.

LeoJSON 0.7.0 intentionally keeps JSONKit unchanged. JSONKit remains the JSON
parser and serializer engine behind the LeoJSON public API boundary.

## Architecture rule

```text
LeoUTF8  = general UTF-8 and text policy authority
JSONKit  = JSON parser, JSON serializer, JSON escape and surrogate handling
LeoJSON  = public API boundary, error behavior, documentation, integration policy
````

## Non-goals

- Do not replace JSONKit's internal ConvertUTF-derived code.
    
- Do not patch JSONKit unless a measured release-critical defect requires it.
    
- Do not introduce JSON-specific special cases into LeoUTF8.
    
- Do not add runtime overhead without measured benefit.
    
- Do not make LeoJSON depend on LeoUTF8 just because it is architecturally neat.
    

## What LeoUTF8 may learn from JSONKit

LeoUTF8 may learn from JSONKit only where JSONKit exposes general UTF-8 truths:

- invalid byte sequences
    
- truncated byte sequences
    
- overlong encodings
    
- invalid Unicode scalar values
    
- valid 4-byte UTF-8 sequences
    
- Big Endian PPC behavior relevant to byte processing
    

LeoUTF8 should not absorb JSON-specific behavior:

- JSON string escape parsing
    
- `\uXXXX` escape decoding
    
- surrogate-pair handling inside JSON strings
    
- JSON parser state handling
    

Those remain JSONKit / LeoJSON territory.

## What "LeoUTF8 at the LeoJSON boundary" means

It does not mean changing JSONKit.

It may mean, after measurement and justification:

- optional input preflight of raw JSON `NSData`
    
- optional output postflight of JSONKit-generated `NSData`
    
- comparison probes used only for validation
    
- improved diagnostics if JSONKit behavior is unclear
    

No such runtime behavior is enabled by this audit.

## Current 0.7.0 behavior

LeoJSON 0.7.0:

- accepts `NSData`
    
- guards nil and empty data
    
- calls JSONKit for parsing
    
- catches JSONKit exceptions
    
- serializes through JSONKit
    
- catches serialization exceptions
    
- does not actively call LeoUTF8
    

This is acceptable for the 0.7.0 baseline because JSONKit is validated as the  
internal engine, and LeoUTF8 integration has not yet been justified by a concrete  
defect or measured benefit.

## Audit questions

1. Which JSONKit code paths handle raw UTF-8 validation?
    
2. Which JSONKit code paths handle JSON `\uXXXX` escapes?
    
3. Which LeoUTF8 APIs are available for raw byte validation?
    
4. Are there UTF-8 byte sequences where LeoUTF8 and JSONKit disagree?
    
5. Does JSONKit throw exceptions for malformed UTF-8 after LeoJSON hardening?
    
6. Would LeoUTF8 preflight improve behavior enough to justify runtime cost?
    
7. Would LeoUTF8 postflight catch realistic serializer defects?
    

## Decision rule

LeoJSON may only add active LeoUTF8 runtime checks if at least one of these is  
true:

- JSONKit accepts invalid UTF-8 that LeoUTF8 correctly rejects.
    
- JSONKit raises exceptions that LeoJSON cannot otherwise contain.
    
- LeoUTF8 produces clearer boundary diagnostics with acceptable overhead.
    
- A consumer project needs explicit LeoUTF8 policy enforcement at the JSON input  
    boundary.
    

Otherwise, keep LeoJSON 0.7.x behavior unchanged.  

