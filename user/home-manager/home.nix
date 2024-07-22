{
  config,
  pkgs,
  lib,
  ...
}: let
  username = "slashfast";
  os_version = "24.05";
in {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${username} = {
    home = {
      username = username;
      homeDirectory = "/home/${username}";
      packages = with pkgs; [
        neofetch
        foot
        cinnamon.nemo
        google-chrome
      ];
      stateVersion = os_version;
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Amber";
        size = 25;
      };
    };
    programs = {
      home-manager = {enable = true;};
      nushell = {
        enable = true;
        configFile.source = ./nu/config.nu;
        envFile.source = ./nu/env.nu;
        loginFile.source = ./nu/login.nu;
      };
      #firefox.enable = true;
      vim.enable = true;
      wofi.enable = true;
    };
  };
}
