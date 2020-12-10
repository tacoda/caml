## What is `caml`?

`caml` is a dynamic CLI tool defined with declarative YAML. You write a `caml.yaml` file in a directory and `caml` will build a CLI tool from it.

## Installation

### Cargo

```sh
cargo install caml
```

### Trust

```sh
curl -LSfs https://japaric.github.io/trust/install.sh | \
    sh -s -- --git tacoda/caml
```

### Brew

TODO

## Standard Usage

```sh
caml
```

## Basic Configuration

```yaml
pwd:
  desc: Print the working directory
  execute: pwd
```

This configuration will define a `pwd` command with a help description. It will execute the `pwd` shell command when invoked.

## Basic Usage

TODO

## Advanced Configuration

TODO

## Advanced Usage

TODO
