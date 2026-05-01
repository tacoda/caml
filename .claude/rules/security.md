---
description: OWASP Top 10 mapped to caml
---

# Security

Security review is required when a change touches: authentication, authorization, queries (SQL or otherwise), file I/O, external API calls, or response shapes.

## Access Control
- Every new route is behind the right middleware
- Authorization decisions go through policies, not inline checks
- Default-deny: opt in to access, never opt out

## Injection
- No string concatenation into queries — use parameterized queries / query builders
- No string concatenation into shell commands — use argv arrays
- No string concatenation into file paths — validate against an allowlist of base directories
- HTML output escapes by default; opt in to raw output explicitly

## Data Exposure
- Response shapes (resources, serializers, DTOs) only expose fields that the caller is authorized to see
- Sensitive fields (passwords, tokens, PII) never leave the database in logs, errors, or responses
- Error messages do not leak internal state to unauthorized callers

## Configuration
- Secrets come from environment variables, never from source
- Features default to **off**; opt in via configuration
- `env()` is read in config layers only — application code reads from config

## Dependencies
- Pin dependency versions
- Run dependency audit (`bundle audit`) regularly
- Update on a cadence; security patches promptly

## Project-Specific Security Notes

- Use `safe_yaml` for all YAML loading; never call `YAML.load` directly. The `caml.yaml` file is parsed at startup and drives command registration.
- The CLI executes shell commands via `system` with strings derived from YAML directives. Treat `caml.yaml` as trusted input — it is the user's own project file, not external input. Do not extend the runtime to load YAML from URLs or untrusted sources without sandboxing.
- Argument and option values flow into the shell command string. Avoid interpolation patterns that would let argument values inject additional shell tokens; prefer argv-style execution where feasible.
- No network or web exposure; no persistent storage; no auth surface.
