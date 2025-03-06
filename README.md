# Add nushell support to Topiary
[![Build Status](https://img.shields.io/github/actions/workflow/status/blindfs/topiary-nushell/ci.yml?branch=main)](https://github.com/blindfs/topiary-nushell/actions)

* [Topiary](https://github.com/tweag/topiary): tree-sitter based uniform formatter
* This repo contains:
  - languages.ncl: configuration that enables nushell
  - nu.scm: tree-sitter query DSL that defines the behavior of the formatter for nushell
  - stand-alone tests written in nushell

## status

* Supposed to work well with all language features of latest nushell
  - Note: there're corner cases that `tree-sitter-nu` would fail with errors, if you encounter them, please open an issue [there](https://github.com/nushell/tree-sitter-nu).
  - If you encounter any style/format issue other than parsing error, please report in this repo, any feedback is appreciated.

## setup

```nushell
# install topiary-cli (0.6.0+ suggested)
# for example, installing with cargo
cargo install --git https://github.com/tweag/topiary topiary-cli

# clone this repo to `$env.XDG_CONFIG_HOME/topiary`
git clone https://github.com/blindFS/topiary-nushell ($env.XDG_CONFIG_HOME | path join topiary)

# set environment variables
$env.TOPIARY_CONFIG_FILE = ($env.XDG_CONFIG_HOME | path join topiary languages.ncl)
$env.TOPIARY_LANGUAGE_DIR = ($env.XDG_CONFIG_HOME | path join topiary languages)
```

## usage

```nushell
topiary format script.nu
```

### neovim

Format on save with [conform.nvim](https://github.com/stevearc/conform.nvim):

```lua
-- lazy.nvim setup
{
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = "VeryLazy",
  opts = {
    formatters_by_ft = {
      nu = { "topiary_nu" },
    },
    formatters = {
      topiary_nu = {
        command = "topiary",
        args = { "format", "--language", "nu" },
      },
    },
  },
},
```

### helix

To format on save in Helix, add this configuration to your `helix/languages.toml`.

```toml
[[language]]
name = "nu"
auto-format = true
formatter = { command = "topiary", args = ["format", "--language", "nu"] }
```

## contribute

Help to find format issues with following method (dry-run, detects parsing/idempotence/semantic breaking):

```nushell
source toolkit.nu
test_format <root-path-of-your-nushell-scripts>
```
