# LeoJSON Error Smoke Results

## Result

LeoJSON error handling has been smoke-tested on real Mac OS X 10.5.8 PowerPC
hardware.

The test verifies that common failure paths return nil, provide diagnostic
strings when requested, tolerate NULL error pointers, and clear the error string
on success.

## Covered cases

- nil input data
- empty input data
- invalid JSON
- unsupported read option
- nil input object
- unsupported write option
- non-serializable object
- parse failure with NULL error pointer
- write failure with NULL error pointer
- successful parse clears the previous error string

## Interpretation

This confirms that LeoJSON's minimal public API has predictable failure behavior
for the first release-candidate hardening stage.
