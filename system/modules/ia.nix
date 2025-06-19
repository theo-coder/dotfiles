{...}: {
  services.ollama = {
    enable = true;
    loadModels = ["devstral" "codestral"];
  };
}
