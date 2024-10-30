# Add nushell support to Topiary (WIP)
[![Build Status](https://img.shields.io/github/actions/workflow/status/blindfs/topiary-nushell/ci.yml?branch=main)](https://github.com/blindfs/topiary-nushell/actions)

* [Topiary](https://github.com/tweag/topiary): tree-sitter based uniform formatter
* This repo contains:
  - languages.ncl: configuration that enables nushell
  - nushell.scm: tree-sitter query DSL that defines the behavior of formatter for nushell
  - stand-alone tests written in nushell

## setup

1. clone to `$env.XDG_CONFIG_HOME/topiary`
2. set environment variables
```nu
$env.TOPIARY_CONFIG_FILE = ($env.XDG_CONFIG_HOME | path join topiary languages.ncl)
$env.TOPIARY_LANGUAGE_DIR = ($env.XDG_CONFIG_HOME | path join topiary languages)
```
