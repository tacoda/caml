# caml

> Build CLI apps from a declarative `caml.yaml` file.

`caml` turns well-documented YAML tasks into a runnable CLI. Inspired by `make` and `just`, but YAML-driven.

## Install

```sh
gem install caml
```

Or in a `Gemfile`:

```ruby
gem 'caml'
```

## Quickstart

```sh
caml init                # scaffold a starter caml.yaml
caml                     # list tasks
caml hello               # run the starter task
```

## Tasks

A task has a name, a `desc`, and an `execute` shell command:

```yaml
test:
  desc: Run the test suite
  execute: bundle exec rspec
```

`caml` and `caml help` list every task with its description.

## Multi-line execute

Pass a list to run multiple steps. Steps run with fail-fast semantics — the first non-zero exit aborts:

```yaml
setup:
  desc: Install and migrate
  execute:
    - bundle install
    - bin/rails db:migrate
```

## Arguments

Positional arguments substitute into the `execute` template via `{{name}}`. Values are shell-escaped:

```yaml
greet:
  desc: Say hello to someone
  args:
    name:
      desc: Person to greet
      type: string
  execute: echo Hello, {{name}}!
```

```sh
caml greet world
# Hello, world!
```

## Options

Flags with type, optional aliases, default value, and an optional override `execute`:

```yaml
build:
  desc: Build the project
  opts:
    target:
      type: string
      default: dist
      aliases:
        - t
      desc: Output directory
    verbose:
      type: boolean
      aliases:
        - v
      desc: Print verbose output
  execute: make build TARGET={{target}}
```

```sh
caml build --target release
caml build -t release -v
```

### Option-driven dispatch

When a boolean option has its own `execute`, that command runs instead of the task's default:

```yaml
start:
  desc: Start the app
  opts:
    background:
      type: boolean
      aliases:
        - b
      desc: Run as a daemon
      execute: app start --daemon
  execute: app start
```

```sh
caml start                # app start
caml start --background   # app start --daemon
```

## Aliases

Add shortcut names for a task:

```yaml
test:
  desc: Run the test suite
  aliases:
    - t
  execute: bundle exec rspec
```

```sh
caml t   # same as caml test
```

## Dependencies

A task can declare prerequisites with `needs`. Deps run in declared order, each at most once per invocation; failures abort the run:

```yaml
test:
  desc: Run tests
  execute: bundle exec rspec

lint:
  desc: Check style
  execute: bundle exec rubocop

ci:
  desc: Lint and test
  needs:
    - lint
    - test
```

```sh
caml ci   # runs lint, then test
```

A task with only `needs:` and no `execute` is a pure orchestrator — useful for grouping.

## Discovery

`caml` walks up from the current directory to find a `caml.yaml`, just like `git`. You can run it from any subdirectory of your project.

## Built-in commands

| Command           | Description                                        |
|-------------------|----------------------------------------------------|
| `caml init`       | Scaffold a starter `caml.yaml`                     |
| `caml --version`  | Print the installed version                        |
| `caml help [cmd]` | Show help for a specific task (its args and opts)  |

## License

MIT — see [LICENSE](LICENSE).
