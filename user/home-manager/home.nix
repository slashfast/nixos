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
        cinnamon.nemo
        google-chrome
        telegram-desktop
        wl-clipboard
        wl-clip-persist
        clipse

        # appearance
        noto-fonts
        hack-font
        jetbrains-mono
        corefonts
        cm_unicode
        font-awesome
        adwaita-icon-theme

        # work
        jetbrains-toolbox
        # jetbrains.pycharm-community
        # jetbrains.webstorm
        nodejs_22
        pnpm
        python312
      ];
      stateVersion = os_version;
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
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
      firefox.enable = true;
      #vim.enable = true;
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
      };
      waybar.enable = true;
      alacritty.enable = true;
      ruff = {
        enable = true;
        settings = {
          line-length = 120;
          indent-width = 4;
          target-version = "py312";

          format = {
            quote-style = "double";
            indent-style = "space";
            skip-magic-trailing-comma = false;
            line-ending = "auto";
          };
        };
      };
      poetry = {enable = true;};
    };
    services.remmina.enable = true;
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = ["noto-emoji" "font-awesome"];
        monospace = ["hack"];
        sansSerif = ["noto"];
        serif = ["Times New Roman"];
      };
    };
  };
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libgcc # sqlalchemy
    ];
  };
}
