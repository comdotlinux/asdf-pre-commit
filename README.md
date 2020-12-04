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
- Needs at least python 3.6 or greater. You should check the version you have with : ```readlink -f`command -v python3` ```
- `bash`, `curl`, (linux only) `sha256sum`: generic POSIX utilities.

# Why
The Pre commit hooks seem popular and I would like to use them in as may projects as I can.
However, since it is python and we need pip to install, I would like to avoid that.

Further, since there is a convininent pyzip (pyz) I can use that.
And combined with asdf-vm the versioning is much easier.

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
