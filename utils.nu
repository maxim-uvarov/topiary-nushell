use std assert

# Test the topiary formatter with all nu files within a directory
# each script should pass the idempotent check as well as the linter
export def test_format [
  path: path # path to test
  break: bool = false # break on first error
] {
  let files = glob $'($path | str trim -r -c '/')/**/*.nu'
  let target = "./test.nu"
  for file in $files {
    try {
      cp $file $target
      topiary format $target
      let errors = nu --ide-check 9999 $target
      | lines
      | each {$in | from json}
      | flatten
      | (
        where severity? == Error
        and message? !~ '((File|Module|Variable) not found|Unknown command)'
      )
      if ($errors | length) > 0 {
        print $errors
      }
      assert (($errors | length) == 0)
    } catch {
      print $file
      if $break {
        break
      }
    }
  }
}
