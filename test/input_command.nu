# local command
ls | get -i name
| length; ls # multiline command
| length
# external command
^git add (ls
  | get -i name)
^$cmd  --arg1 -arg2  arg=value arg=($arg3)
cat unknown.txt o+e> (null-device)
