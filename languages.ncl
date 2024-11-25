{
  languages = {
    nushell = {
      extensions = ["nu"],
      grammar = {
        source.git = {
          git = "https://github.com/nushell/tree-sitter-nu.git",
          rev = "7e0f16f608a9e804fae61430ade734f9f849fb80",
        },
        symbol = "tree_sitter_nu",
      },
    },
  },
}
