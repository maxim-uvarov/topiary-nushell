# Add nushell support to Topiary (WIP)
[![Build Status](https://img.shields.io/github/actions/workflow/status/blindfs/topiary-nushell/ci.yml?branch=main)](https://github.com/blindfs/topiary-nushell/actions)

* [Topiary](https://github.com/tweag/topiary): tree-sitter based uniform formatter
* This repo contains:
  - languages.ncl: configuration that enables nushell
  - nushell.scm: tree-sitter query DSL that defines the behavior of formatter for nushell
  - stand-alone tests written in nushell

## setup

1. install topiary-cli (0.5.1 above)
2. clone this repo to `$env.XDG_CONFIG_HOME/topiary`
3. set environment variables
```nu
$env.TOPIARY_CONFIG_FILE = ($env.XDG_CONFIG_HOME | path join topiary languages.ncl)
$env.TOPIARY_LANGUAGE_DIR = ($env.XDG_CONFIG_HOME | path join topiary languages)
```
4. update `languages.ncl` if Nickel error detected: `grammar.source.git` fits recent updates of topiary github
while the latest release of topiary-cli still uses the other way.

```diff
<       grammar = {
---
>       grammar.source.git = {
```

## usage

`topiary format script.nu`

## contribute

Help to find format issues with following method (dry-run, detects parsing/idempotence/semantic breaking):

```nu
source utils.nu
test_format <root-path-of-your-nushell-scripts>
```
