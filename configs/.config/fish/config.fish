status is-interactive; and begin
    set fish_greeting
    set -Ux PYENV_ROOT $HOME/.pyenv
    set -U fish_user_paths $PYENV_ROOT/bin $HOME/go/bin $HOME/.pixi/bin $fish_user_paths
    set TERM "xterm-256color"
    set -gx DIRENV_LOG_FORMAT ""
    set -gx FZF_DEFAULT_COMMAND "rg --files --hidden"
    set -gx FZF_DEFAULT_OPTS "--no-mouse --info=inline-right"
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -gx MANROFFOPT "-c"
    set -gx STARSHIP_CACHE "$HOME/.cache/starship"

    # NixOS
    alias nrs 'sudo nixos-rebuild switch --flake /home/theo/nixos#alpha --impure'

    # VPN
    alias vpn-up 'sudo wg-quick up wg-home'
    alias vpn-down 'sudo wg-quick down wg-home'

    # Navigation
    alias .. 'cd ..'
    alias ... 'cd ../..'
    alias .3 'cd ../../..'
    alias .4 'cd ../../../..'
    alias .5 'cd ../../../../..'

    # Nvim
    alias vim 'nvim'

    # Ls
    alias ls 'eza -al --color=always --group-directories-first'
    alias la 'eza -a --color=always --group-directories-first'
    alias ll 'eza -l --color=always --group-directories-first'
    alias lt 'eza -aT --color=always --group-directories-first'
    alias l. 'eza -a | grep -E "^\."'

    # Confirmation
    alias cp 'cp -i'
    alias mv 'mv -i'
    alias rm 'rm -i'

    # Ps
    alias psa 'ps auxf'
    alias psgrep 'ps aux | grep -v grep | grep -i -e VSZ -e'
    alias psmem 'ps auxf | sort -nr -k 4'
    alias pscpu 'ps auxf | sort -nr -k 3'

    # Git
    alias ga 'git add .'
    alias gb 'git branch'
    alias gco 'git checkout'
    alias gcl 'git clone'
    alias gcm 'git commit -m'
    alias gf 'git fetch'
    alias gl 'git pull origin'
    alias gp 'git push origin'
    alias gt 'git tag'
    alias gtn 'git tag -a'

    # Misc
    alias grep 'grep --color=auto'
    alias df 'df -h'
    alias free 'free -m'
    alias jctl 'journalctl -p 3 -xb'
    alias mpv 'mpv --hwdec=vaapi'
    alias tb 'nc termbin.com 9999'
    alias myip 'curl ipinfo.io'

    function fish_user_key_bindings
        fish_vi_key_bindings

        bind -M insert \en 'if not set -q TMUX; tm; else; tmux new-window; end'
        bind -M insert \ep __attach_tmux
    end

    set fish_color_normal brcyan
    set fish_color_autosuggestion '#7d7d7d'
    set fish_color_command brcyan
    set fish_color_error '#ff6c6b'
    set fish_color_param brcyan

    bind -Minsert '$' __history_previous_command_arguments
    bind -Minsert ! __history_previous_command

    if command -q fzf
        fzf --fish | source
    end
    if command -q pyenv
        pyenv init - fish | source
    end
    if command -q zoxide
        zoxide init fish | source
    end
    if test -f "$HOME/.cargo/env.fish"
        source "$HOME/.cargo/env.fish"
    end
    if test "$TERM" != dumb; and command -q starship
        starship init fish | source
    end
end
