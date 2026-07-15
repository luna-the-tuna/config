{ pkgs, ... }:
{
  security.sudo = {
    enable = pkgs.stdenv.hostPlatform.isDarwin;
    extraConfig = "Defaults env_reset,pwfeedback";
  };
}
