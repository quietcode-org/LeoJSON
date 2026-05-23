# LeoUTF8 Boundary

LeoUTF8 remains the text and UTF-8 authority for the Leopard-Crew brick stack.

LeoJSON may use JSONKit internally, including its existing Unicode handling, but
JSONKit must not become a second project-wide UTF-8 policy layer.

## Rule

- LeoUTF8 owns general UTF-8 validation and policy.
- LeoJSON owns JSON parsing and serialization.
- JSONKit is an internal parser engine candidate.
- Applications should use LeoJSON, not JSONKit directly.
