function fish_user_key_bindings
    # Execute this once per mode that `emacs` bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the `vi` bindings so they take precedence when there's a conflict
    # Without `--no-erase`, `fish_vi_key_bindings` will default to
    # Resetting all bindings
    # The argument specifies the initial mode (`insert`, `default` or `visual`)
    fish_vi_key_bindings --no-erase insert
end

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block
