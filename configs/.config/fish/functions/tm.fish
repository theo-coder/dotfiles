function tm
    if not set -q TMUX
        if test -d .git
            set name (basename $(pwd))
            set sessions (tmux list-sessions | awk -F ':' '{ print $1 }')

            if contains $name $sessions
                tmux attach -t $name
            else
                tmux new-session -s $name
            end
        else
            set git_dir (git rev-parse --git-dir 2>/dev/null)

            if test -n "$git_dir"
                tmux new-session -A -s $(basename $(dirname $git_dir))
            else
                tmux new-session -A -s $(basename $(pwd))
            end
        end
    else
        if test -d .git
            set name (basename $(pwd))
            set sessions (tmux list-sessions | awk -F ':' '{ print $1 }')

            if contains $name $sessions
                tmux switch -t $name
            else
                tmux new-session -s $name -d </dev/null
                tmux switch -t $name
            end
        else
            set git_dir (git rev-parse --git-dir 2>/dev/null)

            if test -n "$git_dir"
                tmux new-session -A -s $(basename $(dirname $git_dir))
            else
                tmux new-session -A -s $(basename $(pwd))
            end
        end

    end
end
