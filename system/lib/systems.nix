{ self, pkgs, ... }:
{
  lib.soul.systems.switch = self.lib.systems.switch pkgs;
}
