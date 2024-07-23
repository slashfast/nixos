{
  config,
  pkgs,
  lib,
  ...
}: let
  wgFwMark = 51820;
  wgTable = 51820;
in {
  environment.systemPackages = with pkgs; [wireguard-tools];

#  networking.wg-quick.interfaces = {
#    wg0 = {
#      address = [
#        "192.168.0.2"
#      ];
#      dns = ["192.168.0.1"];
#      privateKeyFile = "/opt/keys/nuxt-de";
#
#      peers = [
#        {
#          publicKey = "f96c1xVzF/cFS/ZNBv6/z3ksR8bZsPL+sMfkgE8mMhc=";
#          allowedIPs = ["0.0.0.0/0"];
#          endpoint = "194.28.226.64:33965";
#        }
#      ];
#    };
#  };

    systemd.network = {
      netdevs = {
        "10-wg0" = {
          netdevConfig = {
            Kind = "wireguard";
            Name = "wg0";
            MTUBytes = "1420";
          };
  
          wireguardConfig = {
            PrivateKeyFile = "/opt/keys/nuxt-de";
            FirewallMark = wgFwMark;
            ListenPort = 51820;
         };
  
          wireguardPeers = [
            {
              PublicKey = "f96c1xVzF/cFS/ZNBv6/z3ksR8bZsPL+sMfkgE8mMhc=";
              AllowedIPs = [
                "0.0.0.0/0"
                #"::/0"
              ];
              Endpoint = "194.28.226.64:33965";
              PersistentKeepalive = 25;
            }
          ];
        };
      };
      networks.wg0 = {
        matchConfig.Name = "wg0";
        address = [
          "192.168.0.2"
          #"fdc9:281f:04d7:9ee9::2"
        ];
        dns = [
          "192.168.0.1"
          #"fdc9:281f:04d7:9ee9::1"
        ];
  
        networkConfig = {
          DNSDefaultRoute = true;
          Domains = "~.";
        };
        linkConfig = {
          ActivationPolicy = "manual";
        };
        routes = [
          {
            Destination = "0.0.0.0/0";
            Table = wgTable;
          }
        ];
        routingPolicyRules = [
          {
            Table = wgTable;
            FirewallMark = wgFwMark;
            InvertRule = true;
            Priority = 10;
          }
          {
            To = "10.0.0.0/24";
            Priority = 9;
          }
          {
            To = "194.29.226.64/32";
            Priority = 9;
          }
        ];
      };
    };
}
