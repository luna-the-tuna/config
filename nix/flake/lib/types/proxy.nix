{ lib, ... }:
{
  flake.lib.types.proxy = lib.types.submodule (
    { name, ... }: {
      options = {
        subdomain = lib.mkOption {
          description = "The subdomain to host this proxy on.";
          example = "jellyfin";
          type = lib.types.str;
          defaultText = "<name>";
        };

        target = lib.mkOption {
          description = "The target URL for this proxy.";
          example = "10.0.0.2:6767";
          type = lib.types.str;
        };
      };

      config = {
        subdomain = lib.mkDefault name;
      };
    }
  );
}
