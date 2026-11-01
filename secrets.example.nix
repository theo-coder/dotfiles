# Copy this file to `secrets.nix` and fill in your personal values.
# `secrets.nix` is ignored by git so personal information and API keys stay local.
{
  git = {
    name = "Your Name";
    email = "you@example.com";
  };

  openai = {
    baseUrl = "https://api.openai.com/v1";
    apiKey = "sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
    model = "gpt-4o";
  };

  hosts = {
    # "127.0.0.1" = [ "my-local-site.local" ];
    # "192.168.1.100" = [ "homelab.example.com" ];
  };
}
