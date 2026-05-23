# LeoJSON HeaderDoc Results

## Result

LeoJSON now includes HeaderDoc comments for its public API and can generate an
Apple-style API reference from `sources/LeoJSON/LeoJSON.h`.

## Public API documented

- LeoJSONReadOptions
- LeoJSONWriteOptions
- LeoJSONObjectFromData
- LeoJSONDataFromObject

## Interpretation

This confirms that LeoJSON's public API has an explicit documentation boundary.

Application developers should use the generated HeaderDoc reference together
with:

- docs/api-contract.md
- docs/usage.md
- docs/public-boundary.md
