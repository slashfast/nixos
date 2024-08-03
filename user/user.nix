{
  config,
  pkgs,
  ...
}: let
  username = "slashfast";
in {
  imports = [
    ./home-manager/home.nix
    ./hyprland.nix
    ./spotify.nix
  ];
  programs.fish.enable = true;
  users = {
    defaultUserShell = pkgs.fish;
    users.${username} = {
      isNormalUser = true;
      initialPassword = "chme";
      extraGroups = ["wheel" "input"];
    };
  };
}
