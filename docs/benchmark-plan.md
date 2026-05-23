# LeoJSON Benchmark Plan

LeoJSON does not treat JSONKit's historical performance claims as project facts
until they have been re-measured on real Mac OS X 10.5.8 PowerPC hardware.

## Target machine

- Mac OS X 10.5.8 Leopard
- PowerPC G5
- Xcode 3.1.4
- gcc-4.0 baseline
- gcc-4.2 optional comparison

## Benchmark goals

1. Build a minimal JSONKit smoke probe.
2. Measure JSON parsing on PowerPC.
3. Measure JSON serialization on PowerPC.
4. Compare gcc-4.0 and gcc-4.2 builds.
5. Compare conservative optimization flags against performance builds.
6. Compare JSONKit with native plist serialization where useful.

## Non-goals

- No artificial modern macOS benchmark claims.
- No Intel extrapolation.
- No LeoJSON performance promise before local measurements exist.
