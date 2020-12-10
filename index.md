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
# Show the help menu
caml
caml --help
# Show the version
caml --version
# Show the help for a subcommand
caml help [subcommand]
```

## Basic Configuration

```yaml
pwd:
  desc: Print the working directory
  execute: pwd
```

This configuration will define a `pwd` command with a help description.
It will execute the `pwd` shell command when invoked.
In addition, help menus will be generated for you.

```sh
caml help pwd
Print the working directory

USAGE:
    caml pwd

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information
```

## Basic Usage

TODO

## Advanced Configuration

TODO

## Advanced Usage

TODO
