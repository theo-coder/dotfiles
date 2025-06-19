{config, ...}: {
  programs.fzf = {
    enable = true;
    defaultCommand = "rg --files --hidden";
    defaultOptions = ["--no-mouse" "--info=inline-right"];
  };

  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.btop.enable = true;

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
  };
}
