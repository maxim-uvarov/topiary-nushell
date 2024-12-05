;; leaf nodes are left intact
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

;; keep empty lines
(_) @allow_blank_line_before

[
  ":"
  ";"
] @append_space

[
  "->"
  "="
  "=>"
  "alias"
  "as"
  "break"
  "catch"
  "const"
  "continue"
  "def"
  "do"
  "else"
  "error"
  "export"
  "export-env"
  "extern"
  "for"
  "hide"
  "hide-env"
  "if"
  "in"
  "let"
  "loop"
  "make"
  "match"
  "module"
  "mut"
  "not"
  "new"
  "overlay"
  "return"
  "source"
  "source-env"
  "try"
  "use"
  "where"
  "while"
  (comment)
] @prepend_space @append_space

;; add spaces to left & right sides of operators
(pipe_element
  "|" @prepend_space @append_space @prepend_empty_softline
)

(expr_binary
  lhs: _ @append_space
  opr: _ @append_spaced_softline ; multiline in expr_parenthesized
  rhs: _ @prepend_space
)

(assignment
  lhs: _ @append_space
  opr: _
  rhs: _ @prepend_space
)

(where_command
  opr: _ @prepend_space @append_space
)

;; special flags
(overlay_use
  (short_flag)? @append_space
  (long_flag)? @append_space
)

(ctrl_error
  (short_flag)? @append_space
  (long_flag)? @append_space
)

(ctrl_do
  (short_flag)? @append_space
  (long_flag)? @append_space
)

;; indentation
[
  "["
  "("
] @append_indent_start @append_empty_softline

"{" @append_indent_start

[
  "]"
  "}"
  ")"
] @prepend_indent_end @prepend_empty_softline

; change line happens after || for closure
(
  "{" @append_empty_softline
  .
  (parameter_pipes)? @do_nothing
)

;; space/new-line between parameters
(parameter_pipes
  (
    (parameter) @append_space
    .
    (parameter)
  )?
) @append_space @append_spaced_softline

(parameter_bracks
  (parameter) @append_space
  .
  (parameter) @prepend_empty_softline
)

(parameter
  param_long_flag: _? @prepend_space
  .
  flag_capsule: _? @prepend_space
)

;; declarations
(decl_def
  (long_flag)? @prepend_space @append_space
  quoted_name: _? @prepend_space @append_space
  unquoted_name: _? @prepend_space @append_space
  (returns)?
  (block) @prepend_space
)

(decl_use
  module: _? @prepend_space @append_space
  import_pattern: _? @prepend_space @append_space
)

(decl_extern
  "export"?
  quoted_name: _? @prepend_space @append_space
  unquoted_name: _? @prepend_space @append_space
  (block) @prepend_space
)

(decl_module
  "export"?
  quoted_name: _? @prepend_space @append_space
  unquoted_name: _? @prepend_space @append_space
  (block)? @prepend_space
)

;; forced new-line
[
  (decl_def)
  (decl_export)
  (decl_extern)
  (shebang)
] @append_hardline

[
  (comment)
  (pipeline)
  (overlay_use)
  (overlay_hide)
  (overlay_list)
  (overlay_new)
  (hide_env)
  (hide_mod)
  (decl_use)
  (stmt_source)
] @append_empty_softline

;; control flow
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

(ctrl_match
  "match" @append_space
  scrutinee: _? @append_space
  (match_arm)? @prepend_spaced_softline
  (default_arm)? @prepend_spaced_softline
)

(match_guard
  "if" @prepend_space @append_space
)

;; data structures
(command_list
  [(cmd_identifier) (val_string)] @append_space @prepend_spaced_softline
)

(command
  flag: _? @prepend_space
  arg_str: _? @prepend_space
  arg: _? @prepend_space
  redir: (_
    file_path: _? @prepend_space
  )? @prepend_space
)

(command
  arg_str: _
  .
  (expr_parenthesized)? @do_nothing
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
