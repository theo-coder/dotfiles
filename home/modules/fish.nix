{...}: {
  config = {
    home.file.".config/fish/functions".source = ../config/fish/functions;

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # suppress fish's intro message
        set -Ux PYENV_ROOT $HOME/.pyenv
        set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
        set TERM "xterm-256color"

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

        pyenv init - fish | source
        zoxide init fish | source
        source "$HOME/.cargo/env.fish"
      '';

      shellAliases = {
        # Nixos
        nrs = "sudo nixos-rebuild switch --flake /etc/nixos --impure";

        # VPN
        vpn-up = "sudo wg-quick up wg-home";
        vpn-down = "sudo wg-quick down wg-home";

        # Navigation
        ".." = "cd ..";
        "..." = "cd ../..";
        ".3" = "cd ../../..";
        ".4" = "cd ../../../..";
        ".5" = "cd ../../../../..";

        # Nvim
        vim = "nvim";

        # Ls
        ls = "eza -al --color=always --group-directories-first";
        la = "eza -a --color=always --group-directories-first";
        ll = "eza -l --color=always --group-directories-first";
        lt = "eza -aT --color=always --group-directories-first";
        "l." = "eza -a | grep -E \"^\.\"";

        # Confirmation
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";

        # Ps
        psa = "ps auxf";
        psgrep = "ps aux | grep -v grep | grep -i -e VSZ -e";
        psmem = "ps auxf | sort -nr -k 4";
        pscpu = "ps auxf | sort -nr -k 3";

        # Git
        ga = "git add .";
        gb = "git branch";
        gco = "git checkout";
        gcl = "git clone";
        gcm = "git commit -m";
        gf = "git fetch";
        gl = "git pull origin";
        gp = "git push origin";
        gt = "git tag";
        gtn = "git tag -a";

        # Misc
        grep = "grep --color=auto";
        df = "df -h";
        free = "free -m";
        jctl = "journalctl -p 3 -xb";
        mpv = "mpv --hwdec=vaapi";
        tb = "nc termbin.com 9999";
        myip = "curl ipinfo.io";
      };
    };
  };
}
