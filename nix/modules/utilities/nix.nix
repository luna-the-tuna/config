{ pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  sudoers = if isDarwin then [ "@admin" ] else [ "@wheel" ];
in
{
  nix = {
    channel.enable = false;
    optimise.automatic = true;
    gc.automatic = isDarwin;
  };

  nix.settings = {
    keep-going = true;
    keep-outputs = true;
    keep-derivations = true;

    use-xdg-base-directories = true;
    warn-dirty = false;

    allowed-users = sudoers;
    trusted-users = sudoers;

    experimental-features = [
      "flakes"
      "lix-custom-sub-commands"
      "nix-command"
      "pipe-operator"
    ];
  };
}
