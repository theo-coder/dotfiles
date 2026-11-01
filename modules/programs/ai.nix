{ ... }:
{
  flake.modules.nixos.ai = {
    services.ollama = {
      enable = false;
      loadModels = [
        "devstral"
        "codestral"
      ];
    };
  };
}
