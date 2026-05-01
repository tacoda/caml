# Changelog

All notable changes follow [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and [Semantic Versioning](https://semver.org/).

## [1.0.0] — 2026-05-01

First stable release.

### Added
- Positional arguments with `{{name}}` interpolation, shell-escaped via `Shellwords`
- Typed options (string / boolean / numeric) with aliases, defaults, and per-option `execute` overrides
- Task-level command aliases via Thor's `map`
- Multi-line `execute:` arrays joined with `&&` for fail-fast semantics
- Task dependencies via `needs:`, resolved with cycle detection and dedup
- Pure orchestrator tasks (only `needs:`, no `execute:`)
- `caml init` scaffolds a starter `caml.yaml`
- `caml --version` prints the installed version
- Walks up from the current directory to find `caml.yaml`
- Friendly errors for missing or malformed YAML

### Changed
- Replaced the `class_eval`-of-source-strings command generator with a typed pipeline (Config → Task → Runner → Plan → Thor adapter)
- Single canonical "no such task" error: `Caml::Plan::UnknownTask`
- Minimum Ruby is now 3.0
- Runtime deps declared in the gemspec; dev deps in the Gemfile

### Security
- YAML loads via `safe_yaml` with `raise_on_unknown_tag: true`; `!ruby/object` tags are stripped, never instantiated
- Argument interpolation always shell-escapes substituted values; the only place caml shells out is `Caml::Shell#run`

## [0.1.1]

Initial scaffolding (pre-1.0; experimental).
