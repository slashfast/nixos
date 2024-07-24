{
  config,
  pkgs,
  lib,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Name = "slashfast-pc";
        ControllerMode = "bredr";       
        MultiProfile = "off";
        Experimental = true;
      };
    };
    disabledPlugins = ["bap" "bass" "mcp" "vcp" "micp" "ccp" "csip"];
  };
  #services.blueman.enable = true;

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
}
