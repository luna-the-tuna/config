{ self, config, ... }:
{
  system = {
    stateVersion = config.system.nixos.release;
    configurationRevision = self.rev or self.dirtRev or null;
    disableInstallerTools = true;
  };

  system.tools = {
    nixos-rebuild.enable = true;
    nixos-version.enable = true;
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
  };

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  users.users.luna = {
    isNormalUser = true;
    description = "Luna Heyman";
    extraGroups = [ "wheel" ];
  };
}
