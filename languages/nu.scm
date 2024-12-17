;; leaf nodes are left intact
[
  (cell_path)
  (comment)
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

;; FIXME: temp workaround for the whitespace issue
[
  ":"
  ";"
  "do"
  "if"
  "match"
  "try"
  "while"
] @append_space

[
  "="
  (match_guard)
  (short_flag)
  (long_flag)
] @prepend_space

(assignment
  opr: _
  rhs: (pipeline
    (pipe_element
      (val_string
        (raw_string_begin)
      )
    )
  ) @prepend_space
)

(
  "="
  .
  (pipeline
    (pipe_element
      (val_string
        (raw_string_begin)
      )
    )
  ) @prepend_space
)

[
  "->"
  "=>"
  "alias"
  "as"
  "catch"
  "const"
  "def"
  "else"
  "error"
  "export"
  "export-env"
  "extern"
  "for"
  "hide"
  "hide-env"
  "in"
  "let"
  "loop"
  "make"
  "module"
  "mut"
  "new"
  "overlay"
  "return"
  "source"
  "source-env"
  "use"
  "where"
] @prepend_space @append_space

(pipeline
  "|" @append_space @prepend_input_softline
)

;; add spaces to left & right sides of operators
(expr_binary
  opr: _ @append_input_softline @prepend_input_softline
)

(assignment
  opr: _ @prepend_space
)

(where_command
  opr: _ @append_input_softline @prepend_input_softline
)

;; special flags
(_
  [
    (short_flag)
    (long_flag)
  ] @append_space
  .
  (_)
)

;; indentation
[
  "["
  "("
  "...("
  "...["
  "...{"
] @append_indent_start @append_empty_softline

[
  "]"
  "}"
  ")"
] @prepend_indent_end @prepend_empty_softline

;;; change line happens after || for closure
"{" @append_indent_start
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

;; new-line
(comment) @prepend_input_softline @append_hardline

(nu_script
  (_) @append_begin_scope
  .
  (_) @prepend_end_scope @prepend_empty_scoped_softline
  (#scope_id! "consecutive_scope")
)

(block
  (_) @append_begin_scope
  .
  (_) @prepend_end_scope @prepend_empty_scoped_softline
  (#scope_id! "consecutive_scope")
)

(val_closure
  (_) @append_begin_scope
  .
  (_) @prepend_end_scope @prepend_empty_scoped_softline
  (#scope_id! "consecutive_scope")
)

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

;; data structures
(command_list
  [
    (cmd_identifier)
    (val_string)
  ] @append_space @prepend_spaced_softline
)

(command
  flag: _? @prepend_input_softline
  arg_str: _? @prepend_input_softline
  arg_spread: _? @prepend_input_softline
  arg: _? @prepend_input_softline
  redir: (_
    file_path: _? @prepend_input_softline
  )? @prepend_input_softline
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

