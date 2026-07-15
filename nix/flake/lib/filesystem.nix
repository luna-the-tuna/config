{ lib, ... }:
{
  flake.lib.filesystem.getRequiredPath =
    path: lib.throwIfNot (builtins.pathExists path) "no file or directory found at '${path}'" path;
}
