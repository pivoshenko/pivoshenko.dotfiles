# Fish Completions for Gleam
# https://github.com/glpda/gleam-completions/blob/master/gleam.fish

set -l commands add build check clean deps docs export fix format help hex lsp new publish remove run shell test update
set -l commands_with_help deps docs export hex
set -l targets erlang javascript
set -l runtimes nodejs deno bun

function __fish_gleam_project_root
    # get project root (parent dir with gleam.toml)
    for dir in (__fish_parent_directories (pwd --physical))
        if test -f $dir/gleam.toml
            echo $dir
            return 0
        end
    end
    return 1
end

function __fish_gleam_runnable_module
    # TODO list files under src and test with a main function
    # NOTE files under 'build/packages/*/src' can also be run
    # NOTE may handle path completion 'gleam run -m package/module'
end

# TODO add completion for runnable module arguments?
# NOTE maybe too complex (requires parsing gleam)

function __fish_gleam_deps_direct
    # 'gleam deps list' gives all dependencies but 'gleam remove' takes only
    # direct project dependencies listed in 'gleam.toml'
    set -l gleam_version (gleam -V | string split -f2 " " | string split ".")
    if test $gleam_version[1] -eq 1 -a $gleam_version[2] -ge 8
        __fish_gleam_deps_parse_tree
    else
        __fish_gleam_deps_parse_toml
    end
end

function __fish_gleam_deps_parse_tree
    # 'gleam deps tree' gives an error when used outside a gleam project
    if gleam deps tree 2> /dev/null \
        | string replace -f -r '^(├|└)── ' '' \
        | string split -n -f1 " "
        return 0
    else
        return 1
    end
end

function __fish_gleam_deps_parse_toml
    if not set -l project_root (__fish_gleam_project_root)
        return 1
    end
    set -l current_table ''
    # does not properly escape "#" inside a string but it should not matter
    # since we only care about the keys (packages' names) and tables' names
    # and those should not contain any "#"
    string replace -r '#.*' '' <$project_root/gleam.toml | string trim \
    | while read -l line
        if string match -q '[*]' $line
            set current_table $line
        else if string match -q $current_table '[dependencies]' '[dev-dependencies]'
            set -f dependencies $dependencies \
            (string split -n -f1 "=" $line | string trim)
        end
    end
    printf '%s\n' $dependencies
    return 0
end

function __fish_gleam_deps_all
    # 'gleam deps list' gives an error when used outside a gleam project
    if gleam deps list 2> /dev/null \
        | string split -f1 " "
        return 0
    else
        return 1
    end
end

function __fish_gleam_hex_packages
    # TODO list available hex packages
end

complete -c gleam --no-files

complete -c gleam -n __fish_use_subcommand -s V -l version -d 'Print version'

# Subcommands
complete -c gleam -n __fish_use_subcommand -a add     -d "Add new project dependencies"
complete -c gleam -n __fish_use_subcommand -a build   -d "Build the project"
complete -c gleam -n __fish_use_subcommand -a check   -d "Type check the project"
complete -c gleam -n __fish_use_subcommand -a clean   -d "Clean build artifacts"
complete -c gleam -n __fish_use_subcommand -a deps    -d "Work with dependency packages"
complete -c gleam -n __fish_use_subcommand -a docs    -d "Render HTML documentation"
complete -c gleam -n __fish_use_subcommand -a export  -d "Export from the Gleam project"
complete -c gleam -n __fish_use_subcommand -a fix     -d "Rewrite deprecated Gleam code"
complete -c gleam -n __fish_use_subcommand -a format  -d "Format source code"
complete -c gleam -n __fish_use_subcommand -a help    -d "Print help for the given subcommand(s)"
complete -c gleam -n __fish_use_subcommand -a hex     -d "Work with the Hex package manager"
complete -c gleam -n __fish_use_subcommand -a lsp     -d "Run the language server, to be used by editors"
complete -c gleam -n __fish_use_subcommand -a new     -d "Create a new project"
complete -c gleam -n __fish_use_subcommand -a publish -d "Publish the project to the Hex package manager"
complete -c gleam -n __fish_use_subcommand -a remove  -d "Remove project dependencies"
complete -c gleam -n __fish_use_subcommand -a run     -d "Run the project"
complete -c gleam -n __fish_use_subcommand -a shell   -d "Start an Erlang shell"
complete -c gleam -n __fish_use_subcommand -a test    -d "Run the project tests"
complete -c gleam -n __fish_use_subcommand -a update  -d "Update dependencies to their latest versions"

# Help
complete -c gleam -s h -l help -d 'Print help'
complete -c gleam -n "__fish_prev_arg_in help; and __fish_is_nth_token 2" -r -a "$commands"
complete -c gleam -n "__fish_seen_subcommand_from $commands_with_help; and __fish_is_nth_token 2" -a help -d "Print help"
complete -c gleam -n '__fish_seen_subcommand_from deps; and __fish_prev_arg_in help' -a "list tree download update"
complete -c gleam -n '__fish_seen_subcommand_from docs; and __fish_prev_arg_in help' -a "build publish remove"
complete -c gleam -n '__fish_seen_subcommand_from export; and __fish_prev_arg_in help' -a "erlang-shipment hex-tarball javascript-prelude typescript-prelude package-interface package-information"
complete -c gleam -n '__fish_seen_subcommand_from hex; and __fish_prev_arg_in help' -a "retire unretire revert authenticate"

# Compile: build check run test
complete -c gleam -n '__fish_seen_subcommand_from build check run test' -s t -l target -rf -a "$targets" -d "The platform to target"
complete -c gleam -n '__fish_seen_subcommand_from run test' -l runtime -rf -a "$runtimes" -d "The runtime to target"
complete -c gleam -n '__fish_seen_subcommand_from build; and not __fish_seen_subcommand_from docs' -l warnings-as-errors -d "Emit compile time warnings as errors"
complete -c gleam -n '__fish_seen_subcommand_from build run; and not __fish_seen_subcommand_from docs' -l no-print-progress -d "Don't print progress information"
complete -c gleam -n '__fish_seen_subcommand_from run' -s m -l module -rf -a '(__fish_gleam_runnable_module)' -d "The module to run"

# Dependencies: add deps remove update
complete -c gleam -n '__fish_prev_arg_in add' -l dev -rf -a '(__fish_gleam_hex_packages)'
complete -c gleam -n '__fish_prev_arg_in add' -rf -a '(__fish_gleam_hex_packages)'
complete -c gleam -n '__fish_prev_arg_in deps' -a list     -d "List all dependency packages"
complete -c gleam -n '__fish_prev_arg_in deps' -a download -d "Download all dependency packages"
complete -c gleam -n '__fish_prev_arg_in deps' -a update   -d "Update dependencies to their latest versions"
complete -c gleam -n '__fish_prev_arg_in deps' -a tree     -d "Tree of all the dependency packages"
complete -c gleam -n '__fish_prev_arg_in tree' -l package -rfa '(__fish_gleam_deps_all)' -d "Package to be used as the root of the tree"
complete -c gleam -n '__fish_prev_arg_in tree' -l invert  -rfa '(__fish_gleam_deps_all)' -d "Invert the tree direction and focus on the given package"
complete -c gleam -n '__fish_prev_arg_in remove; and __fish_is_nth_token 2' -rf -a '(__fish_gleam_deps_direct)'
complete -c gleam -n '__fish_prev_arg_in update' -rf -a '(__fish_gleam_deps_all)'

# Publish: hex publish
complete -c gleam -n '__fish_prev_arg_in hex' -a authenticate -d "Authenticate with Hex"
complete -c gleam -n '__fish_prev_arg_in hex' -a retire -d "Retire a release from Hex"
complete -c gleam -n '__fish_prev_arg_in retire' -r -a '(__fish_gleam_hex_packages)'
complete -c gleam -n '__fish_prev_arg_in hex' -a unretire -d "Un-retire a release from Hex"
complete -c gleam -n '__fish_prev_arg_in hex' -a revert   -d "Revert a release from Hex"
complete -c gleam -n '__fish_seen_subcommand_from revert' -l package -rf -a '(__fish_gleam_hex_packages)'
complete -c gleam -n '__fish_seen_subcommand_from revert' -l version -rf
complete -c gleam -n '__fish_seen_subcommand_from publish; and not __fish_seen_subcommand_from docs' -l replace
complete -c gleam -n '__fish_seen_subcommand_from publish; and not __fish_seen_subcommand_from docs' -s y -l yes

# docs
complete -c gleam -n '__fish_prev_arg_in docs' -a build   -d "Render HTML docs locally"
complete -c gleam -n '__fish_prev_arg_in docs' -a publish -d "Publish HTML docs to HexDocs"
complete -c gleam -n '__fish_prev_arg_in docs' -a remove  -d "Remove HTML docs from HexDocs"
complete -c gleam -n '__fish_seen_subcommand_from docs; and __fish_seen_subcommand_from build' -l open -d "Open in a browser after rendering"
complete -c gleam -n '__fish_seen_subcommand_from docs; and __fish_seen_subcommand_from remove' -l package -rf -a '(__fish_gleam_hex_packages)' -d "The name of the package"
complete -c gleam -n '__fish_seen_subcommand_from docs; and __fish_seen_subcommand_from remove' -l version -rf -d "The version of the docs to remove"

# export
complete -c gleam -n '__fish_prev_arg_in export' -a erlang-shipment    -d "Precompiled Erlang, suitable for deployment"
complete -c gleam -n '__fish_prev_arg_in export' -a hex-tarball        -d "A bundled tarball, suitable for publishing to Hex"
complete -c gleam -n '__fish_prev_arg_in export' -a javascript-prelude -d "The JavaScript prelude module"
complete -c gleam -n '__fish_prev_arg_in export' -a typescript-prelude -d "The TypeScript prelude module"
complete -c gleam -n '__fish_prev_arg_in export' -a package-interface  -d "Information on the modules in JSON format"
complete -c gleam -n '__fish_prev_arg_in export' -a package-information -d "Information on the package (gleam.toml) in JSON format"
complete -c gleam -n '__fish_prev_arg_in package-interface package-information' -l out -r -F  -d "The path to write the JSON file to"

# format
complete -c gleam -n '__fish_seen_subcommand_from format; and __fish_not_contain_opt stdin' -F
complete -c gleam -n '__fish_seen_subcommand_from format' -l stdin -d "Read source from STDIN"
complete -c gleam -n '__fish_seen_subcommand_from format' -l check -d "Check if inputs are formatted without changing them"

# new
complete -c gleam -n '__fish_seen_subcommand_from new' -l name -r -d "Name of the project"
complete -c gleam -n '__fish_seen_subcommand_from new' -l template -rf -a "$targets" -d "The template to use"
complete -c gleam -n '__fish_seen_subcommand_from new' -l skip-git    -d "Skip git initialization"
complete -c gleam -n '__fish_seen_subcommand_from new' -l skip-github -d "Skip creation of .github/* files"
