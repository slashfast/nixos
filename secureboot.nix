{ pkgs, lib, ... }: 
{
  environment.systemPackages = [
     # For debugging and troubleshooting Secure Boot.
     pkgs.sbctl
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}