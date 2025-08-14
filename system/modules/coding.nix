{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    gcc
    gnumake
    go
    cargo
    rustfmt
    luarocks
    stylua
    tree-sitter
    python3
    ruby
    nodejs
    delta
    pyright
    cargo
    clippy
    rustc
    rustup
    taplo
    marksman
    alejandra
    bun
    fishPlugins.fzf-fish
    fishPlugins.nvm
    pyenv
    ghc
    lua-language-server
    openssl
    openssl.dev
    pkg-config
    android-studio
    jdk
    sqlite
    sqlitebrowser
    code-cursor
    jmtpfs
    android-tools
    vscode
    k3sup
    kubectl
    kubernetes-helm
    kustomize
  ];

  programs.adb.enable = true;

  environment.variables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    QT_SCREEN_SCALE_FACTORS = "0.75";
  };
}
