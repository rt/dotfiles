# synchronize-panes

```
ctrl+b: split-window
ctrl+b: setw synchronize-panes on
ctrl+b: clear history

... anything you type in one pane will populate to others

ctrl+b: setw synchronize-panes off
```

setup script to loop over servers, exporting a env variable for the server name.
- ssh
- cd ...
- tail ...



Can also do this for even more convenience

```bash
_tmux_send_keys_all_panes_ () {
  for _pane in $(tmux list-panes -F '#P'); do
    # tmux send-keys -t <session id> <command> C-m  
    tmux send-keys -t ${_pane} "$@"
  done
}
```


utility function to do it, only executing the command when there there is nothing running in the pane.

```bash
#!/bin/bash

_send_bash_command_to_session() {
    if [[ $# -eq 0 || "$1" = "--help" ]] ; then
        echo 'Usage: _send_bash_command_to_session $session_name what ever command you want: '
        return
    fi
    input_session="$1"
    input_command="${@:2}"
    for _pane in $(tmux list-panes -s -t ${input_session} -F '#{window_index}.#{pane_index}'); do
        # only apply the command in bash or zsh panes.
        _current_command=$(tmux display-message -p -t ${input_session}:${_pane} '#{pane_current_command}')
        if [ ${_current_command} = zsh ] || [ ${_current_command} = bash ] ; then
            tmux send-keys -t ${_pane} "${input_command}" Enter
        fi
    done
}

tmux_set_venv() {
    _current_session=$(tmux display-message -p '#{session_name}')
    _send_bash_command_to_session ${_current_session} workon $1
}
```
