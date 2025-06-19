{
  system,
  inputs,
  ...
}: {
  environment.systemPackages = [
    inputs.zen-browser.packages."${system}".default
  ];
}
