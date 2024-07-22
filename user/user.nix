{
  config,
  pkgs,
  ...
}: let
  username = "slashfast";
in {
  imports = [
    ./home-manager/home.nix
  ];

  users = {
    defaultUserShell = pkgs.nushell;
    users.${username} = {
      isNormalUser = true;
      initialPassword = "chme";
      extraGroups = ["wheel"];
    };
  };
}
