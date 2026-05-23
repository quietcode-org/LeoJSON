# LeoJSON Changelog

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

