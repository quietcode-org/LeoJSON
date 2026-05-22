# LeoJSON Architecture Decision

LeoJSON does not reimplement JSONKit.

JSONKit remains the internal parser and serializer engine candidate. LeoJSON
provides the Leopard-Crew boundary around it: API naming, parameter style,
error handling, UTF-8 policy integration, and documented PowerPC validation.

## Responsibilities

### JSONKit

- Parse JSON data
- Serialize Foundation objects
- Remain vendored and isolated
- Stay hidden from application code

### LeoJSON

- Provide the public project API
- Normalize options and parameters
- Provide predictable error reporting
- Coordinate text and encoding policy with LeoUTF8
- Keep JSONKit replaceable behind the boundary

### LeoUTF8

- Remain the text and UTF-8 authority
- Validate or normalize input where LeoJSON requires explicit text policy
- Avoid depending on LeoJSON

## Rule

Application code should use LeoJSON, not JSONKit directly.

LeoJSON may use JSONKit internally, but JSONKit categories and implementation
details must not become part of the Leopard-Crew public coding style.
