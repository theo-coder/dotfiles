{ ... }:
{
  flake.modules.nixos.coding =
    { pkgs, ... }:
    {
      virtualisation.docker.enable = true;

      environment.systemPackages = with pkgs; [
        devenv
        lazygit
        neovim
        gcc
        gnumake
        go
        cargo
        clippy
        luarocks
        stylua
        tree-sitter
        python3
        pyenv
        uv
        pyright
        ruby
        nodejs
        bun
        delta
        taplo
        marksman
        alejandra
        nixfmt
        nil
        ghc
        lua-language-server
        typescript-language-server
        tailwindcss-language-server
        prisma-language-server
        openssl
        openssl.dev
        pkg-config
        nss
        android-studio
        android-tools
        jdk
        sqlite
        sqlitebrowser
        code-cursor
        vscode
        zed-editor
        postman
        beekeeper-studio
        k3sup
        kubectl
        kubernetes-helm
        kustomize
        postgresql
      ];

      environment.variables = {
        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
        QT_SCREEN_SCALE_FACTORS = "0.75";
      };
    };
}
