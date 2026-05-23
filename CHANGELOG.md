# LeoJSON Changelog

## 0.7.3 - Release model policy

- Document the difference between public package baselines and engineering tags.
- Clarify that audit and policy tags do not automatically require new release archives.
- Keep the Makefile version tied to the latest public package baseline unless a new package is prepared.

## 0.7.2 - Private JSONKit engine policy

- Accept JSONKit as LeoJSON's private JSON engine sub-brick.
- Document that vendored JSONKit source remains unchanged.
- Document that JSONKit capabilities do not automatically become public LeoJSON API.
- Keep LeoJSON public API as the only supported contract.

## 0.7.1 - LeoUTF8 / JSONKit boundary audit

- Add LeoUTF8 / JSONKit boundary inventory tooling.
- Record that JSONKit contains deeply integrated UTF-8, UTF-32, Unicode escape,
  and surrogate-pair handling.
- Keep JSONKit unchanged.
- Do not add LeoUTF8 runtime integration without measured need.
- Preserve LeoUTF8 as the general UTF-8 policy authority.

## 0.7.0 - Leopard PowerPC baseline

- Synchronize public version macros and release package version.
- Include LICENSE, NOTICE, and CHANGELOG.md in release packages.
- Include generated HeaderDoc API reference in release packages.
- Strengthen archive verification with SHA256 comparison.
- Build and run a consumer smoke test from the extracted release archive.
- Refresh README for release-package consumption.

## 0.6.9 - Release archive verification

Add release archive target.
Add SHA256 checksum generation.
Add archive verification target.

## 0.6.8 - Version sync baseline

- Synchronize Makefile release version with LeoJSON public version macros.
- Keep release layout naming aligned with the current engineering baseline.

## 0.6.6 - Version and changelog baseline

- Add public version macros.
- Add project changelog.

## 0.6.5 - Release gate checklist

- Add release gate checklist before release-candidate work.

## 0.6.4 - License and notice audit

- Add Apache-2.0 license.
- Add NOTICE file.
- Document JSONKit vendor licensing under the Apache-2.0 option.

## 0.6.3 - Error hardening

- Add error smoke probe.
- Guard empty input data before calling JSONKit.
- Contain JSONKit parser and serializer exceptions behind the LeoJSON boundary.
- Confirm error smoke probe passes on real Mac OS X 10.5.8 PowerPC hardware.

## 0.6.2 - HeaderDoc baseline

- Add HeaderDoc comments to LeoJSON public API.
- Generate Apple-style HeaderDoc API reference.

## 0.6.1 - API contract

- Document public API contract.
- Document usage.
- Document public/private boundary.

## 0.6.0 - Release layout

- Add release-style static-library layout.
- Add dist smoke probe.

## 0.5.1 - Build policy baseline

- Document Leopard-Crew build policy.
- Document optimization profile results.
- Select gcc-4.2 -O2 -fno-common as default release profile.

## 0.5.0 - Static library baseline

- Build LeoJSON as a static library.
- Confirm API smoke probe links against the static library.

## 0.4.1 - API smoke results

- Record LeoJSON API smoke probe results.

## 0.4.0 - Minimal API boundary

- Add initial LeoJSON public API wrapper around JSONKit.

## 0.3.0 - G5 benchmark baseline

- Record first JSONKit benchmark results on real PowerPC G5 hardware.

## 0.2.0 - JSONKit smoke probe

- Confirm vendored JSONKit builds and runs on Mac OS X 10.5.8 PowerPC.

## 0.1.0 - Vendor scope

- Establish JSONKit vendor and benchmark scope.

