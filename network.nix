{
  config,
  lib,
  pkgs,
  ...
}: let
  interface = "enp6s0";
in {
  networking = {
    useDHCP = false;
    #interfaces."${interface}" = {
    #  wakeOnLan.enable = true;
    #};
  };
  #networking.resolvconf = { enable = true; package = lib.mkForce pkgs.openresolv; };
  services.resolved.enable = true;
  #services.resolved.dnssec = "allow-downgrade";
  systemd.network.enable = true;
  systemd.network = {
    networks."10-${interface}" = {
      matchConfig.Name = interface;
      networkConfig = {
        DHCP = "yes";
        IPv6AcceptRA = true;
      };
    };
    links."10-wired" = {
      linkConfig = {
        WakeOnLan = "magic";
      };
    };
  };
}
