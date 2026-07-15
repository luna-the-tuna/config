{ config, self, ... }:
{
  system = {
    stateVersion = config.system.nixos.release or config.system.darwinRelease;
    configurationRevision = self.rev or self.dirtRev or null;
  };
}
