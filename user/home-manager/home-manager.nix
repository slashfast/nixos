{ config, pkgs, ... }:
let 
  username = "slashfast";
  os_version = "24.05";
in 
{ home-manager.users.${username} = {
    home = {
      username = username;
      homeDirectory = "/home/${username}";
      packages = with pkgs; [ neofetch ];
      stateVersion = os_version;
    };
    programs = {
      home-manager = { enable = true; };
      nushell = {
        enable = true;
        configFile.source = ./nu/config.nu;
        envFile.source = ./nu/env.nu;
        loginFile.source = ./nu/login.nu;
      };
    };
  };
}
