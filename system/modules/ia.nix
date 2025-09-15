{...}: {
  services.ollama = {
    enable = false;
    loadModels = ["devstral" "codestral"];
  };
}
