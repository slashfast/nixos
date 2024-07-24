{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.useDHCP = false;
  #networking.resolvconf = { enable = true; package = lib.mkForce pkgs.openresolv; };
  services.resolved.enable = true;
  #services.resolved.dnssec = "allow-downgrade";
  systemd.network.enable = true;
  systemd.network.networks."10-enp6s0" = {
    matchConfig.Name = "enp6s0";
    networkConfig = {
      DHCP = "yes";
      IPv6AcceptRA = true;
    };
  };
}
