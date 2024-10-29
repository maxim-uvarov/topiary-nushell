# decl_extern
export extern hello [name: string] {
    $"hello ($name)!"
}
extern hi [name: string] {
    $"hi ($name)!"
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
