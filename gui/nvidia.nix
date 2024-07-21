{config}: {
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32 = true;
  };

  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };
  };
}
