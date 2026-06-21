{ self, config, ... }:
let
  versions = {
    linux = "26.11";
    darwin = 6;
  };
in
{
  system = {
    stateVersion = config.lib.soul.systems.switch versions;
    configurationRevision = self.rev or self.dirtRev or null;
  };
}
