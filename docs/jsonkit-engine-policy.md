# LeoJSON JSONKit Engine Policy

## Purpose

LeoJSON accepts JSONKit as its private JSON engine sub-brick.

This does not make JSONKit part of the public LeoJSON API.

## Rule

```text
Application code -> LeoJSON public API -> private JSONKit engine
````

Application code must not include JSONKit headers or call JSONKit APIs directly.

## Vendor rule

The vendored JSONKit source remains unchanged.

LeoJSON must not edit JSONKit for local style, formatting, naming, or  
Cupertino-2009 cosmetic reasons.

JSONKit may only be patched if a measured release-critical defect requires it,  
and such a patch must be documented.

## Public API rule

A JSONKit capability does not automatically become a LeoJSON public API.

Before a JSONKit capability may cross the boundary, LeoJSON must document:

- why the capability is needed by real Leopard-Crew consumers
    
- how it maps to LeoJSON naming and error conventions
    
- its ownership behavior
    
- its failure behavior
    
- its test coverage
    

If those conditions are not met, the capability remains private.

## Private adapter rule

LeoJSON may introduce a private adapter layer around JSONKit if it simplifies  
the public boundary implementation.

Such an adapter must remain private and must not add public behavior by itself.

Possible future layout:

```text
sources/LeoJSON/Private/
  LeoJSONKitEngine.h
  LeoJSONKitEngine.m
```

The adapter may contain:

- JSONKit imports
    
- JSONKit calls
    
- JSONKit exception containment
    
- JSONKit error normalization
    

The adapter must not expose JSONKit as public API.

## UTF-8 / Unicode rule

JSONKit owns JSON-internal Unicode behavior, including:

- JSON string parsing
    
- raw UTF-8 inside JSON strings
    
- `\uXXXX` escape handling
    
- surrogate-pair handling
    

LeoUTF8 remains the general Leopard-Crew UTF-8 policy authority.

LeoJSON must not force LeoUTF8 into JSONKit internals. LeoUTF8 may only be used  
at the LeoJSON boundary if a concrete need is measured and documented.

## Design principle

The public API must stay small.

The private engine may be capable.

Only the public LeoJSON boundary is the contract.  

