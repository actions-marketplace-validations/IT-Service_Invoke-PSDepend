# GitHub Action "Invoke-PSDepend"

[![GitHub release](https://img.shields.io/github/v/release/IT-Service/Invoke-PSDepend.svg?sort=semver&logo=github)](https://github.com/IT-Service/Invoke-PSDepend/releases)

[![Semantic Versioning](https://img.shields.io/static/v1?label=Semantic%20Versioning&message=v2.0.0&color=green&logo=semver)](https://semver.org/lang/ru/spec/v2.0.0.html)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-v1.0.0-yellow.svg?logo=git)](https://conventionalcommits.org)

This action install and invoke [PSDepend][] for installing dependencies.

## Usage

See [action.yml](action.yml)

Basic:

```yaml
steps:
- uses: actions/checkout@v3
- uses: actions/Invoke-PSDepend@v1
  with:
    version: 'latest' # PSDepend version
    recurse: true
    verbose: true
```

## License

The scripts and documentation in this project are released under the [MIT License](LICENSE).

## Contributions

Contributions are welcome! See [Contributor's Guide](.github/CONTRIBUTING.md).

PSDepend: https://github.com/RamblingCookieMonster/PSDepend
