{...}: {
  programs.git = {
    enable = true;
    userName = "Théo Posty";
    userEmail = "theo@posty.fr";

    extraConfig = {
      init.defaultBranch = "main";
      user.signingKey = "~/.ssh/id_ed25519.pub";
      diff.colorMoved = "zebra";
      fetch.prune = true;
      pull.rebase = true;
      rebase.autoStash = true;
      gpg.format = "ssh";
      commit.gpgsign = true;
      tag.gpgsign = true;
      "gpg \"ssh\"" = {
        allowSignersFile = "~/.ssh/allowed_signers";
      };
      "includeIf \"gitdir:~/workspace/idfr/\"" = {
        path = "~/workspace/idfr/.gitconfig";
      };
    };
  };
}
