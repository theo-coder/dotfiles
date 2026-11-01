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
        starship
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
}
