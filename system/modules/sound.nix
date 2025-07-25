{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
  };
}
