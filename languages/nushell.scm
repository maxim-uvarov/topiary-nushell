[
  (cell_path)
  (comment)
  (long_flag_equals_value)
  (shebang)
  (unquoted)
  (val_binary)
  (val_bool)
  (val_date)
  (val_duration)
  (val_filesize)
  (val_nothing)
  (val_number)
  (val_string)
  (val_variable)
] @leaf

[
  (assignment)
  (comment)
  (decl_def)
  (decl_export)
  (decl_extern)
  (decl_module)
  (decl_use)
  (pipeline)
  (stmt_const)
  (stmt_let)
] @allow_blank_line_before

[
  ":"
  ";"
  "alias"
  "const"
  "error"
  "export-env"
  "let"
  "mut"
  "return"
  "source"
  "try"
  "where"
] @append_space

[
  "->"
  "="
  "=>"
  "catch"
  "else"
  "make"
  (comment)
] @prepend_space @append_space

(expr_binary
  lhs: _ @append_space
  opr: _
  rhs: _ @prepend_space
)

(assignment
  lhs: _ @append_space
  opr: _
  rhs: _ @prepend_space
)

(where_command
  lhs: _ @append_space
  opr: _
  rhs: _ @prepend_space
)

[
  "["
  "{"
  "("
] @append_indent_start @append_empty_softline

[
  "]"
  "}"
  ")"
] @prepend_indent_end @prepend_empty_softline

(decl_def
  "export"? @append_space
  (long_flag)? @prepend_space @append_space
  quoted_name: _? @prepend_space @append_space
  unquoted_name: _? @prepend_space @append_space
  (parameter_bracks)?
  (returns)?
  (block) @prepend_space
)

(decl_use
  "export"? @append_space
  module: _? @prepend_space @append_space
  import_pattern: _? @prepend_space @append_space
)

(decl_extern
  "export"? @append_space
  quoted_name: _? @prepend_space @append_space
  unquoted_name: _? @prepend_space @append_space
  (parameter_bracks)?
  (block) @prepend_space
)

(decl_module
  "export"? @append_space
  quoted_name: _? @prepend_space @append_space
  unquoted_name: _? @prepend_space @append_space
  (block) @prepend_space
)

[
  "\n"
  (decl_def)
  (decl_export)
  (decl_extern)
  (decl_use)
  (shebang)
] @append_hardline

(pipe_element
  "|" @prepend_space @append_space
)

(ctrl_if
  "if" @append_space
  condition: _ @append_space
)

(ctrl_for
  "for" @append_space
  "in" @prepend_space @append_space
  body: _ @prepend_space
)

(ctrl_while
  "while" @append_space
  condition: _ @append_space
)

(match_guard
  "if" @prepend_space @append_space
)

(ctrl_match
  "match" @append_space
  scrutinee: _? @append_space
  (match_arm)? @prepend_spaced_softline
  (default_arm)? @prepend_spaced_softline
)

(command_list
  (cmd_identifier) @append_space @prepend_spaced_softline
)

(command
  flag: _? @prepend_space
  arg_str: _? @prepend_space
  arg: _? @prepend_space
  redir: (_
    file_path: _? @prepend_space
  )? @prepend_space
)

(list_body
  entry: _ @append_space
  .
  entry: _ @prepend_spaced_softline
)

(val_list
  item: _ @append_space @prepend_spaced_softline
)

(val_table
  row: _ @prepend_spaced_softline
)

(val_record
  entry: (record_entry) @append_space @prepend_spaced_softline
)

(record_body
  entry: (record_entry) @append_space @prepend_spaced_softline
)

(
  (comment) @append_empty_softline
  .
  "\n"? @do_nothing
)

[
  (parameter_pipes)
] @append_space @prepend_empty_softline

(parameter_bracks
  (parameter) @append_space
  .
  (parameter) @prepend_empty_softline
)
