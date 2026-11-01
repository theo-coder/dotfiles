function __attach_tmux
    set session (tmux list-sessions 2>/dev/null | awk -F ':' '{ print $1 }' | fzf --height 40% --layout=reverse --info=inline --border --margin 10% --padding 1)
    if test -n "$session"
        if not set -q TMUX
            tmux attach -t $session
        else
            tmux switch -t $session
        end
    end
end
