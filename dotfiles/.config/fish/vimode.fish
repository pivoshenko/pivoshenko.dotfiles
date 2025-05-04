function fish_user_key_bindings
    # execute this once per mode that `emacs` bindings should be used in
    fish_default_key_bindings -M insert

    # then execute the `vi` bindings so they take precedence when there's a conflict
    # without `--no-erase`, `fish_vi_key_bindings` will default to
    # resetting all bindings
    # the argument specifies the initial mode (`insert`, `default` or `visual`)
    fish_vi_key_bindings --no-erase insert
end

# emulates `vim`'s cursor shape behavior
set fish_cursor_default block
# set the insert mode cursor to a line
set fish_cursor_insert line
# set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
# set the external cursor to a line. The external cursor appears when a command is started
# the cursor shape takes the value of `fish_cursor_default` when `fish_cursor_external` is not specified
set fish_cursor_external line
# the following variable can be used to configure cursor shape in
# visual mode, but due to `fish_cursor_default`, is redundant here
set fish_cursor_visual block
