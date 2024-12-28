use std assert

def run_ide_check [
  file: path
] {
  nu --ide-check 9999 $file
  | lines
  | each { $in | from json }
  | flatten
  | where severity? == Error
  | reject start end
}

def str_repeat [
  char: string
  count: int
] {
  if $count < 1 { return '' }
  1..$count | each { $char } | str join
}

def print_progress [
  ratio: float
  length: int = 20
] {
  let done = '▓'
  let empty = '░'
  let count = [1 (($ratio * $length) | into int)] | math max
  (
    print -n
    (str_repeat $done $count)
    (str_repeat $empty ($length - $count))
    ($ratio * 100 | into string --decimals 0) %
  )
}

# Test the topiary formatter with all nu files within a directory
# each script should pass the idempotent check as well as the linter
export def test_format [
  path: path # path to test
  break: bool = false # break on first error
] {
  let files = glob $'($path | str trim -r -c '/')/**/*.nu'
  let target = "./test.nu"
  let len = $files | length
  $env.format_detected_error = false
  for i in 1..$len {
    let file = $files | get ($i - 1)
    print_progress ($i / $len)
    print -n $"(ansi -e '1000D')"
    try {
      cp $file $target
      let err_before = run_ide_check $target
      topiary format $target
      let err_after = run_ide_check $target
      assert ($err_before == $err_after)
    } catch {
      $env.format_detected_error = true
      print $"(ansi red)Error detected: (ansi yellow)($file)(ansi reset)"
      if $break {
        rm $target
        break
      }
    }
    rm $target
  }
  if not $env.format_detected_error {
    print ''
    print $"(ansi green)All nu scripts successfully passed the check, but style issues are still possible."
  }
}
