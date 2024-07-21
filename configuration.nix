{ config, pkgs, lib, modulesPath, ... }:
let 
  os_version = "24.05";
in 
{ imports = [
    ./hardware-configuration.nix
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
  environment.systemPackages = with pkgs; [ curl ripgrep bat git ];
  
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings.trusted-users = [ "@wheel" ];
  };

  system.stateVersion = os_version;
}
