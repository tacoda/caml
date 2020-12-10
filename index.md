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

## Crash Course

Create a new folder.

```sh
cd $HOME
mkdir caml-crash
cd caml-crash
```

Create a `caml.yaml` file.

```sh
touch caml.yaml
```

**`caml.yaml`**

```yaml
pwd:
  desc: Print the working directory
  execute: pwd
```

Make sure to save the file!

This configuration will define a `pwd` subcommand.

```sh
caml help
# ...
#
# SUBCOMMANDS:
#     ...
#     pwd       Print the working directory
#     help      Prints this message or the help of the given subcommand(s)
```

Help will be generated for you.

```sh
caml help pwd
caml pwd --help
# Print the working directory
#
# USAGE:
#     caml pwd
# 
# FLAGS:
#     -h, --help       Prints help information
#     -V, --version    Prints version information
```

It will execute the `pwd` shell command when invoked.

```sh
caml pwd
# $HOME
```


## Full Configuration Documentation

TODO
