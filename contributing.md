# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test pre-commit https://github.com/comdotlinux/asdf-pre-commit.git "pre-commit -V"
```

Tests are automatically run in GitHub Actions on push and PR.
