{ config, self, ... }:
{
  system = {
    stateVersion = config.system.nixos.release or config.system.maxStateVersion;
    configurationRevision = self.rev or self.dirtRev or null;
  };
}
