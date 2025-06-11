{pkgs, ...}: {
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [fish];
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
    PATH = ["${XDG_BIN_HOME}" "$HOME/.cargo/bin"];
  };

  environment.systemPackages = with pkgs; [
    kitty
    fish
    eza
    keychain
    zoxide
    fira-code
    pass
    gnupg
    pinentry-tty
    bat-extras.batman
    bat-extras.batwatch
    tmux
    sysz
    systemctl-tui
    chafa
    direnv
  ];

  programs.fish.enable = true;
}
