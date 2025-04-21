# 🐪 caml

> Build CLI apps with YAML

`caml` allows you to build command line applications using declarative yaml.
`caml` aims to be like `make`, but by using descriptive, declarative yaml.

<!-- ## Installation -->

<!-- TODO -->

<!-- ```sh -->
<!-- gem install caml -->
<!-- ``` -->

## Usage

Running the command without any arguments displays the commands defined in the `caml.yaml` file:

```sh
bin/caml
```

## Declaring commands

`caml` reads a file called `caml.yaml` in the current directory and converts those commands into a unified CLI command.

The basic structure is to have a `command`, which has a `desc` and an `execute` for the bash command to execute.

```yaml
command:
  desc: Command description
  execute: script.sh
```

This yaml will create the following command:

```yaml
bin/caml command # Command description
```

And it will run any bash command defined.

Arguments may be added under `args` in a nested fashion as displayed below.

```yaml
command:
  args:
    one:
      desc: First argument
      type: string
    two:
      desc: Second argument
      type: string
```

## Examples

```yaml
build:
  desc: Build our project
  execute: make
clean:
  desc: Clean our project
  execute: make clean
```

```yaml
build:
  desc: Bundle
  execute: bundle install
migrate:
  desc: Migrate the test database
  execute: rails db:migrate RAILS_ENV=test
test:
  desc: Run tests
  execute: rspec
```
