---
description: Core design principles governing all code in caml
---

# Design Principles

## Core Philosophy
- **Manage complexity ruthlessly.** Every decision should reduce cognitive load. Optimize for the reader.
- **Make change easy, then make the easy change.** Localize modifications, minimize risk.
- **Empiricism over dogma.** Validate through working software and fast feedback.
- **Pull complexity downward.** Simple interfaces over simple implementations (deep modules).
- **When in doubt, choose the boring solution.**

## Construction
- Names reveal intent; length proportional to scope; use domain vocabulary
- Functions: small, **one level of abstraction**, few arguments (<=3), no hidden side effects
- Command-Query Separation: do something OR answer something, not both
- **Program to interfaces, not implementations.** Depend on abstractions; create implementations behind interfaces rather than branching on type.
- **SOLID** — Single Responsibility, Open/Closed, Liskov, Interface Segregation, Dependency Inversion
- **DRY** — every piece of knowledge has one authoritative representation
- **Rule of Three** — tolerate duplication twice; extract on the third occurrence
- **YAGNI** — don't build for hypothetical future requirements
- **KISS** — the simplest solution that works is the best solution
- Comments explain **why**, not what. Delete commented-out code.

## Tell, Don't Ask
Tell objects what to do instead of querying their state and deciding for them. Encapsulate state checks as named methods on the object that owns the state. The caller should never reach through an object's internals to make decisions.

## Error Handling
- Fail fast: detect and report at the earliest point
- Provide context: what happened, where, and what to do
- Don't return null; don't pass null — use null objects, optionals, or throw
- Validate inputs at boundaries; assert invariants internally

## Anti-Patterns
- Premature optimization and premature abstraction
- Speculative generality ("we might need this someday")
- Big bang rewrites — prefer incremental improvement
- Clever code that's hard to understand
- Shallow modules with complex interfaces
- Anemic domain models (data without behavior)
- Forced DRY on incidental duplication

## Project-Specific Patterns

- **Thor-based CLI.** `CamlCli` extends `Thor` and registers commands via `class_eval` at load time, driven by `Caml::Config` (the parsed `caml.yaml`).
- **Small domain types.** `Config`, `Argument`, `Option`, and `Command` each model a single concept. Keep them that way — resist adding behavior that belongs to a sibling.
- **Safe YAML loading only.** Use `safe_yaml`; never `YAML.load`.
- **Shell execution via `system`.** Commands ultimately shell out. Keep the shell-string construction in one place so it can be reviewed for injection risk.
- **Metaprogramming is intentional, not casual.** `class_eval` is used to translate declarative YAML into Thor commands. Other dynamic dispatch should be justified — prefer explicit code unless the declarative model demands generation.
