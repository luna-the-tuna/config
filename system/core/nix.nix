{ pkgs, config, ... }:
let
  sudoers = config.lib.soul.systems.switch {
    darwin = "@admin";
    linux = "@wheel";
  };
in
{
  nix = {
    channel.enable = false;
    optimise.automatic = true;
    gc.automatic = pkgs.stdenv.hostPlatform.isDarwin;

    settings = {
      warn-dirty = false;
      use-xdg-base-directories = true;

      keep-going = true;
      keep-outputs = true;
      keep-derivations = true;

      allowed-users = [ sudoers ];
      trusted-users = [ sudoers ];

      experimental-features = [
        "lix-custom-sub-commands"
        "flakes"
        "pipe-operator"
        "nix-command"
      ];

      deprecated-features = [
        "broken-string-indentation"
      ];
    };
  };

  environment.systemPackages = [
    pkgs.lix-diff
  ];
}
