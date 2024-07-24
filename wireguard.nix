{
  config,
  pkgs,
  lib,
  ...
}: let fwMark = 51820; table = fwMark; nodeIPv4 = "192.168.0.2"; nodeIPv6 = "fdc9:281f:04d7:9ee9::2"; in {
  environment.systemPackages = with pkgs; [wireguard-tools];

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [
        "192.168.0.2"
        "fdc9:281f:04d7:9ee9::2"
      ];
      dns = ["192.168.0.1" "fdc9:281f:04d7:9ee9::1"];
      privateKeyFile = "/opt/keys/nuxt-de";

      peers = [
        {
          publicKey = "f96c1xVzF/cFS/ZNBv6/z3ksR8bZsPL+sMfkgE8mMhc=";
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = "194.28.226.64:33965";
        }
      ];
    };
  };
    
#    systemd.network = {
#      netdevs = {
#        "10-wg0" = {
#          netdevConfig = {
#            Kind = "wireguard";
#            Name = "wg0";
#            #MTUBytes = "1420";
#          };
#  
#          wireguardConfig = {
#            PrivateKeyFile = "/opt/keys/nuxt-de";
#            FirewallMark = fwMark;
#            ListenPort = 51820;
#         };
#  
#          wireguardPeers = [
#            {
#              PublicKey = "f96c1xVzF/cFS/ZNBv6/z3ksR8bZsPL+sMfkgE8mMhc=";
#              AllowedIPs = [
#                "0.0.0.0/0"
#                #"::/0"
#              ];
#              Endpoint = "194.28.226.64:33965";
#              RouteTable="off";
#            }
#          ];
#        };
#      };
#      networks.wg0 = {
#        matchConfig.Name = "wg0";
#        address = [
#          "${nodeIPv4}/32"
#          #nodeIPv6
#        ];
#        dns = [
#          #"8.8.8.8"
#          "192.168.0.1"
#          #"fdc9:281f:04d7:9ee9::1"
#        ];
#  
#        networkConfig = {
#          DNSDefaultRoute = true;
#          Domains = "~.";
#          #DNSSEC = false;
#        };
#        linkConfig = {
#          ActivationPolicy = "manual";
#        };
#        routes = [
#          {
#            #Gateway = "192.168.0.1";
#            Destination = "0.0.0.0/0";
#            #GatewayOnLink = true;
#            #Scope = "link";
#            Table = table;
#          }
#        ];
#        routingPolicyRules = [
#          {
#            Table = table;
#            FirewallMark = fwMark;
#            InvertRule = true;
#            Priority = 10;
#          }
#          {
#            Table = "main";
#            SuppressPrefixLength = 0;
#          }
#        ];
#      };
#    };
#
#  services.networkd-dispatcher = {
#    enable = true;
#    rules = {
#      "prevention-loop-on-wg0" ={
#        onState = ["configured"];
#        script = ''
#          #!${pkgs.runtimeShell}
#          if [[ $IFACE == "wg0" && $AdministrativeState == "configured" ]]; then
#            ${pkgs.iptables}/bin/iptables -t mangle -A PREROUTING -p udp -m comment --comment "wireguard.nix rule for wg0" -j CONNMARK --restore-mark --nfmask 0xffffffff --ctmask 0xffffffff
#            ${pkgs.iptables}/bin/iptables -t mangle -A PREROUTING -p udp -m comment --comment "wireguard.nix rule for wg0" -j TRACE
#            ${pkgs.iptables}/bin/iptables -t mangle -A POSTROUTING -p udp -m mark --mark ${toString fwMark} -m comment --comment "wireguard.nix rule for wg0" -j CONNMARK --save-mark --nfmask 0xffffffff --ctmask 0xffffffff
#            ${pkgs.iptables}/bin/iptables -t mangle -A POSTROUTING -p udp -m mark --mark ${toString fwMark} -m comment --comment "wireguard.nix rule for wg0" -j TRACE
#            ${pkgs.iptables}/bin/iptables -t raw -A PREROUTING -d ${nodeIPv4}/32 ! -i wg0 -m addrtype ! --src-type LOCAL -m comment --comment "wireguard.nix rule for wg0" -j DROP
#            ${pkgs.iptables}/bin/iptables -t raw -A PREROUTING -d ${nodeIPv4}/32 ! -i wg0 -m addrtype ! --src-type LOCAL -m comment --comment "wireguard.nix rule for wg0" -j TRACE
#            echo "wireguard routing loop prevention is enabled"
#          fi
#          exit 0
#        '';
#      };
#      "prevention-loop-off-wg0" ={
#        onState = ["off"];
#        script = ''
#          #!${pkgs.runtimeShell}
#          if [[ $IFACE == "wg0" && $AdministrativeState == "configured" ]]; then
#            ${pkgs.iptables}/bin/iptables -t mangle -D PREROUTING -p udp -m comment --comment "wireguard.nix rule for wg0" -j CONNMARK --restore-mark --nfmask 0xffffffff --ctmask 0xffffffff
#            ${pkgs.iptables}/bin/iptables -t mangle -D PREROUTING -p udp -m comment --comment "wireguard.nix rule for wg0" -j TRACE
#            ${pkgs.iptables}/bin/iptables -t mangle -D POSTROUTING -p udp -m mark --mark ${toString fwMark} -m comment --comment "wireguard.nix rule for wg0" -j CONNMARK --save-mark --nfmask 0xffffffff --ctmask 0xffffffff
#            ${pkgs.iptables}/bin/iptables -t mangle -D POSTROUTING -p udp -m mark --mark ${toString fwMark} -m comment --comment "wireguard.nix rule for wg0" -j TRACE
#            ${pkgs.iptables}/bin/iptables -t raw -D PREROUTING -d ${nodeIPv4}/32 ! -i wg0 -m addrtype ! --src-type LOCAL -m comment --comment "wireguard.nix rule for wg0" -j DROP
#            ${pkgs.iptables}/bin/iptables -t raw -D PREROUTING -d ${nodeIPv4}/32 ! -i wg0 -m addrtype ! --src-type LOCAL -m comment --comment "wireguard.nix rule for wg0" -j TRACE
#            echo "wireguard routing loop prevention is disabled"
#          fi
#          exit 0
#        '';
#      };
#    };
#  };
}
