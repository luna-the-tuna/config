{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.unrar
    pkgs.unzip
  ];
}
