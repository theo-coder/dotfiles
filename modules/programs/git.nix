{ ... }:
{
  flake.modules.homeManager.git =
    { secrets, ... }:
    {
      programs.git = {
        enable = true;

        settings = {
          user = {
            inherit (secrets.git) name email;
            signingKey = "~/.ssh/id_ed25519.pub";
          };

          init.defaultBranch = "main";
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
        };

        includes = [
          {
            condition = "gitdir:~/workspace/idfr/";
            path = "~/workspace/idfr/.gitconfig";
          }
        ];
      };
    };
}
