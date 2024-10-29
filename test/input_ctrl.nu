# for
for i in [1, 2, 3] {
  # if
  if (true or false) {
    print "break"; break # break
  } else {
    print "continue"; continue # continue
  }
  return 1 # return
}
# alias
alias ll = ls -l # alias comment
# where
ls | where $in.name == 'foo'
| where {|e| $e.item.name !~ $'^($e.index + 1)' }
# match
let foo = { name: 'bar', count: 7 }
match $foo {
    { name: 'bar' count: $it } if $it < 5 => ($it + 3), # match arm comment
    # match comment
    { name: 'bar' count: $it } if $it >= 5 => ($it + 7),
    _ => {exit 0}
}
# while
mut x = 0; while $x < 10 { $x = $x + 1 }; $x # while comment
# try
try {
 # error
  error make {
    msg: 'Some error info' }}; print 'Resuming'
