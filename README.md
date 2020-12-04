<div align="center">

# asdf-pre-commit ![Build](https://github.com/comdotlinux/asdf-pre-commit/workflows/Build/badge.svg) ![Lint](https://github.com/comdotlinux/asdf-pre-commit/workflows/Lint/badge.svg)

[pre-commit](https://pre-commit.com/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add pre-commit
# or
asdf plugin add https://github.com/comdotlinux/asdf-pre-commit.git
```

pre-commit:

```shell
# Show all installable versions
asdf list-all pre-commit

# Install specific version
asdf install pre-commit latest

# Set a version globally (on your ~/.tool-versions file)
asdf global pre-commit latest

# Now pre-commit commands are available
pre-commit -V
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/comdotlinux/asdf-pre-commit/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Guruprasad Kulkarni](https://github.com/comdotlinux/)
