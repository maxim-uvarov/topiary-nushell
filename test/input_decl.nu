# decl_extern
export extern hello [name: string] {
    $"hello ($name)!"
}
extern hi [name: string --long (-s) # flags
] {
    $"hi ($name)!"
}

# env
hide-env   ABC
with-env {ABC: 'hello'} {
do -i --env {| | print $env.ABC
  }
}

# closure
let cls = {| foo bar  baz|
  (
    $foo +
    $bar + $baz
  )
}

# decl_export
export-env  {
$env.hello = 'hello'
}

# decl_def
def "hi there" [where: string]:
nothing -> string {
    $"hi ($where)!"
}

# decl_use
use greetings.nu hello
export use greetings.nu *

# decl_module
module greetings {
    export def hello [name: string] {
        $"hello ($name)!"
    }

    export def hi [where: string] {
        $"hi ($where)!"
    }
};
