{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.extraModulePackages = [config.boot.kernelPackages.wireguard];
  systemd.network = {
    enable = true;
    netdevs = {
      "10-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
          MTUBytes = "1420";
        };
        
        wireguardConfig = {
          PrivateKeyFile = "/run/keys/wireguard-privkey";
        };

        wireguardPeers = [
          {
            PublicKey = "f96c1xVzF/cFS/ZNBv6/z3ksR8bZsPL+sMfkgE8mMhc=";
            AllowedIPs = ["0.0.0.0/0" "::/0"];
            Endpoint = "194.28.226.64:33965";
          }
        ];
      };
    };
    networks.wg0 = {
      matchConfig.Name = "wg0";
      address = [
        "192.168.0.2/24" "fdc9:281f:04d7:9ee9::2/64"
      ];
      DHCP = "no";
      dns = ["192.168.0.1" "fdc9:281f:04d7:9ee9::1"];
      networkConfig = {
        IPv6AcceptRA = false;
      };
    };
  };
}
