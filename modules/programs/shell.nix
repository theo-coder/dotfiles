{ ... }:
{
  flake.modules.nixos.shell =
    {
      pkgs,
      secrets,
      ...
    }:
    {
      users.defaultUserShell = pkgs.fish;
      environment.shells = with pkgs; [ fish ];
      environment.variables = {
        EDITOR = "nvim";
        TERMINAL = "kitty -1";
        TERM = "xterm-kitty";
      };

      environment.sessionVariables = rec {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/state";
        XDG_BIN_HOME = "$HOME/.local/bin";
        PATH = [
          "${XDG_BIN_HOME}"
          "$HOME/.cargo/bin"
        ];
        OPENAI_BASE_URL = secrets.openai.baseUrl;
        OPENAI_API_KEY = secrets.openai.apiKey;
        OPENAI_MODEL = secrets.openai.model;
        CHROME_ALLOCATOR = "ANON";
        PASSWORD_STORE = "gnome-libsecret";
      };

      environment.systemPackages = with pkgs; [
        fish
        fishPlugins.fzf-fish
        fishPlugins.nvm
        eza
        keychain
        zoxide
        fira-code
        pass
        gnupg
        pinentry-tty
        bat-extras.batman
        bat-extras.batwatch
        sysz
        systemctl-tui
        chafa
        direnv
        nix-direnv
      ];

      programs.fish.enable = true;
    };

  flake.modules.homeManager.shell =
    { ... }:
    {
      home.file.".config/fish/functions".source = ../../configs/fish/functions;

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
          set -Ux PYENV_ROOT $HOME/.pyenv
          set -U fish_user_paths $PYENV_ROOT/bin $HOME/go/bin $HOME/.pixi/bin $fish_user_paths
          set TERM "xterm-256color"
          set -gx DIRENV_LOG_FORMAT ""

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
          # NixOS
          nrs = "sudo nixos-rebuild switch --flake /home/theo/nixos#alpha --impure";

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

      programs.starship = {
        enable = true;
        settings = {
          username = {
            style_user = "green bold";
            style_root = "red bold";
            format = "[$user]($style) ";
            disabled = false;
            show_always = true;
          };
          hostname = {
            ssh_only = true;
            format = "on [$hostname](bold purple) ";
            trim_at = ".";
            disabled = false;
          };
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[✗](bold red)";
          };
          directory = {
            read_only = " ";
            truncation_length = 10;
            truncate_to_repo = true;
            style = "bold italic blue";
          };
          cmd_duration = {
            min_time = 4;
            show_milliseconds = false;
            disabled = false;
            style = "bold italic red";
          };
          aws = {
            symbol = "  ";
          };
          conda = {
            symbol = " ";
          };
          dart = {
            symbol = " ";
          };
          docker_context = {
            symbol = " ";
            format = "via [$symbol$context]($style) ";
            style = "blue bold";
            only_with_files = true;
            detect_files = [
              "docker-compose.yml"
              "docker-compose.yaml"
              "Dockerfile"
            ];
            detect_folders = [ ];
            disabled = false;
          };
          elixir = {
            symbol = " ";
          };
          elm = {
            symbol = " ";
          };
          git_branch = {
            symbol = " ";
          };
          git_status = {
            format = "([$all_status$ahead_behind]($style) )";
            stashed = "[\${count}*](green)";
            modified = "[\${count}+](yellow)";
            deleted = "[\${count}-](red)";
            conflicted = "[\${count}~](red)";
            ahead = "⇡\${count}";
            behind = "⇣\${count}";
            untracked = "[\${count}?](blue)";
            staged = "[\${count}+](green)";
          };
          git_state = {
            style = "bold red";
            format = "[$state( $progress_current/$progress_total) ]($style)";
            rebase = "rebase";
            merge = "merge";
            revert = "revert";
            cherry_pick = "cherry";
            bisect = "bisect";
            am = "am";
            am_or_rebase = "am/rebase";
          };
          golang = {
            symbol = " ";
          };
          hg_branch = {
            symbol = " ";
          };
          java = {
            symbol = " ";
          };
          julia = {
            symbol = " ";
          };
          haskell = {
            symbol = "λ ";
          };
          memory_usage = {
            symbol = "󰍛 ";
          };
          nim = {
            symbol = " ";
          };
          nix_shell = {
            symbol = " ";
          };
          package = {
            symbol = " ";
          };
          perl = {
            symbol = " ";
          };
          php = {
            symbol = " ";
          };
          python = {
            symbol = "🐍 ";
            format = "via [\${symbol}python (\${version} )(\($virtualenv\) )]($style)";
            style = "bold yellow";
            pyenv_prefix = "venv ";
            python_binary = [
              "./venv/bin/python"
              "python"
              "python3"
              "python2"
            ];
            detect_extensions = [ "py" ];
            version_format = "v\${raw}";
          };
          ruby = {
            symbol = " ";
          };
          rust = {
            symbol = " ";
          };
          scala = {
            symbol = " ";
          };
          shlvl = {
            symbol = " ";
          };
          swift = {
            symbol = "ﯣ ";
          };
          nodejs = {
            format = "via [󰎙 Node.js $version](bold green) ";
            detect_files = [
              "package.json"
              ".node-version"
            ];
            detect_folders = [ "node_modules" ];
          };
        };
      };
    };
}
