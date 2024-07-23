{config,lib,...}: {
  networking.useDHCP = false;

  systemd.network.networks."10-enp3s0" = {
    matchConfig.Name = "enp3s0";
    dns = ["10.0.0.1"];
    networkConfig = {
      # start a DHCP Client for IPv4 Addressing/Routing
      DHCP = "ipv4";
      # accept Router Advertisements for Stateless IPv6 Autoconfiguraton (SLAAC)
      IPv6AcceptRA = true;
    };
    # make routing on this interface a dependency for network-online.target
    linkConfig.RequiredForOnline = "routable";
  };
}
