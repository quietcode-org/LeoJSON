# LeoJSON Release Gate Checklist

This checklist defines the gate before LeoJSON may move from engineering
baseline to release-candidate status.

## Current validated baselines

- v0.6.1-api-contract
- v0.6.2-headerdoc-baseline
- v0.6.3-error-hardening
- v0.6.4-license-notice-audit

## Required before v0.7.0 release candidate

### API

- [x] Public API documented in `sources/LeoJSON/LeoJSON.h`
- [x] API contract documented in `docs/api-contract.md`
- [x] Public/private boundary documented in `docs/public-boundary.md`
- [x] JSONKit hidden behind LeoJSON boundary
- [x] Version macros available in public header or companion header

### Documentation

- [x] Usage documented in `docs/usage.md`
- [x] HeaderDoc comments added
- [x] HeaderDoc output generated under `docs/api/`
- [x] Build policy documented
- [x] Optimization profile results documented
- [x] Release layout documented
- [x] Changelog added

### Hardening

- [x] API smoke probe passes
- [x] Dist smoke probe passes
- [x] Error smoke probe passes
- [x] JSONKit parser exceptions are contained by LeoJSON
- [x] Release-candidate full smoke target exists

### Build and release layout

- [x] Static library build works
- [x] Release layout works
- [x] Dist consumer smoke works
- [x] Release archive target exists
- [x] SHA256 checksum generation exists
- [x] Generated release archive verified

### Licensing

- [x] Top-level LICENSE present
- [x] Top-level NOTICE present
- [x] JSONKit vendor notices preserved
- [x] JSONKit Apache-2.0 option documented
- [x] LeoJSON Apache-2.0 license documented

## Release candidate rule

LeoJSON may become a release candidate only after the unchecked items above are
either completed or explicitly deferred with justification.

A release candidate must be usable by a consumer project using only:

- `include/LeoJSON.h`
- `lib/libLeoJSON.a`
- `Foundation.framework`

Consumer code must not require `sources/` or `vendor/`.
