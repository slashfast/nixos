{
  config,
  lib,
  ...
}: {
  networking.useDHCP = false;
  systemd.network.enable = true;
  systemd.network.networks."10-enp6s0" = {
    matchConfig.Name = "enp6s0";
    networkConfig = {
      DHCP = "yes";
      IPv6AcceptRA = true;
    };
  };
}
