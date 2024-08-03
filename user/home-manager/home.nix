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
        aria2
        grim
        slurp

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
        nodejs_22
        pnpm
        python312
        dbeaver-bin
        gh
        mpv-unwrapped
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
      fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
        '';
      };
      #nushell = {
      #  enable = true;
      #  configFile.source = ./nu/config.nu;
      #  envFile.source = ./nu/env.nu;
      #  loginFile.source = ./nu/login.nu;
      #};
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
      # sqlalchemy
      libgcc
      
      # jetbrains
      SDL
      SDL2
      SDL2_image
      SDL2_mixer
      SDL2_ttf
      SDL_image
      SDL_mixer
      SDL_ttf
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      bzip2
      cairo
      cups
      curlWithGnuTls
      dbus
      dbus-glib
      desktop-file-utils
      e2fsprogs
      expat
      flac
      fontconfig
      freeglut
      freetype
      fribidi
      fuse
      fuse3
      gdk-pixbuf
      glew110
      glib
      gmp
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-ugly
      gst_all_1.gstreamer
      gtk2
      harfbuzz
      icu
      keyutils.lib
      libGL
      libGLU
      libappindicator-gtk2
      libcaca
      libcanberra
      libcap
      libclang.lib
      libdbusmenu
      libdrm
      libgcrypt
      libgpg-error
      libidn
      libjack2
      libjpeg
      libmikmod
      libogg
      libpng12
      libpulseaudio
      librsvg
      libsamplerate
      libthai
      libtheora
      libtiff
      libudev0-shim
      libusb1
      libuuid
      libvdpau
      libvorbis
      libvpx
      libxcrypt-legacy
      libxkbcommon
      libxml2
      mesa
      nspr
      nss
      openssl
      p11-kit
      pango
      pixman
      python3
      speex
      stdenv.cc.cc
      tbb
      udev
      vulkan-loader
      wayland
      xorg.libICE
      xorg.libSM
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXft
      xorg.libXi
      xorg.libXinerama
      xorg.libXmu
      xorg.libXrandr
      xorg.libXrender
      xorg.libXt
      xorg.libXtst
      xorg.libXxf86vm
      xorg.libpciaccess
      xorg.libxcb
      xorg.xcbutil
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
      xorg.xkeyboardconfig
      xz
      zlib
      
      # Flet
      gtk3
      # sudo ln -s /nix/store/08a907bw4csdc44408a992lnc9v2802c-mpv-0.38.0/lib/libmpv.so /usr/lib/libmpv.so.1
      mpv
      libepoxy
    ];
  };
}
