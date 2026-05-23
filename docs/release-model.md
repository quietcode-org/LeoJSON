# LeoJSON Release Model

LeoJSON distinguishes between public package baselines and engineering tags.

## Public package baseline

A public package baseline produces a distributable archive.

Example:

```text
v0.7.0-leopard-ppc-baseline
````

This tag corresponds to:

```text
dist/LeoJSON-0.7.0-Leopard-PPC.tar.gz
dist/LeoJSON-0.7.0-Leopard-PPC.tar.gz.sha256
```

The Makefile `VERSION` value follows the latest public package baseline unless a
new public package is being prepared.

## Engineering tags

Engineering tags document validated project state, audits, or policy decisions.

Examples:

```text
v0.7.1-leoutf8-jsonkit-boundary-audit
v0.7.2-private-jsonkit-engine-policy
```

These tags do not automatically imply a new public release archive.

They may add documentation, policy, audit results, or internal structure without
changing the packaged public library.

## Rule

Do not generate a new public archive only because an engineering tag exists.

A new public archive requires an explicit package decision, version sync, full
smoke, archive verification, checksum generation, and release notes.

## Current state

The current public package baseline is:

```text
LeoJSON 0.7.0 Leopard PPC
```

The current engineering state may be newer than the packaged baseline.
