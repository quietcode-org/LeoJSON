# JSONKit Vendor Notes

LeoJSON vendors JSONKit as a frozen research and implementation candidate.

JSONKit is not exposed directly as the public LeoJSON API. LeoJSON will provide
its own controlled boundary so applications do not depend on JSONKit categories
or internal behavior.

## Policy

- Keep the vendor snapshot unchanged.
- Document any local patch before applying it.
- Prefer adapter code outside vendor/.
- Treat JSONKit performance claims as historical until measured on Leopard/PPC.
