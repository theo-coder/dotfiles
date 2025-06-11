function check_repo
    if test -d .git
        if not set -q TMUX
            set session_name (basename $(pwd))
            set sessions (tmux list-sessions | awk -F ':' '{ print $1 }')

            if contains $session_name $sessions
                tmux attach -t $session_name
            else
                tmux new-session -s $session_name
            end
        else
            tmux -C attach -c $(basename $(pwd)) -t . </dev/null >/dev/null
        end
    else
        set dir (git rev-parse --git-dir 2>/dev/null)
        if test -n "$dir"
            if not set -q TMUX
                tmux new-session -A -s $(basename $(dirname $dir))
            else
                tmux -C attach -c $(basename $(dirname $dir)) -t . </dev/null >/dev/null
            end
        end
    end
end

