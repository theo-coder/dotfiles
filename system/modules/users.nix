{...}: {
  users.users.theo = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "docker"];
  };
}
