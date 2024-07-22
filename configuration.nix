{
  config,
  pkgs,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
    ./gpu.nix
    ./audio.nix
    ./user/user.nix
  ];

  boot.loader = {
    grub = {
      efiSupport = true;
      device = "/dev/nvme0n1";
    };
  };

  zramSwap.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Moscow";
  environment.systemPackages = with pkgs; [curl ripgrep bat git];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      trusted-users = ["@wheel"];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };

  hardware.upower.enable = true;
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
