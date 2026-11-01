{ ... }:
{
  flake.modules.nixos.locale = {
    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "fr_FR.UTF-8";
  };
}
