{ inputs, pkgs, ... }:
{
  imports = [
    inputs.catppuccin.nixosModules.default
    inputs.disko.nixosModules.default

    ./hardware-configuration.nix
    ./disk-configuration.nix
  ];

  soul.hardware = {
    amdgpu.enable = true;
    audio.enable = true;
    bluetooth.enable = true;
    intelcpu.enable = true;
  };

  soul.users.luna = {
    primary = true;
    firstName = "Luna";
    lastName = "Heyman";
  };

  programs.git.enable = true;

  fonts.enableDefaultPackages = false;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = false;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  users.users.luna = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "mocha";
    accent = "mauve";

    sources.palette = inputs.catppuccin-palette;
    plymouth.enable = false;
  };

  home-manager = {
    users.luna = ./home.nix;
  };

  fonts.packages = [
    pkgs.maple-mono.NF
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.work-sans
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [ "Maple Mono NF" ];
      emoji = [ "Noto Color Emoji" ];

      serif = [
        "Noto Serif"
        "Noto Cjk Serif"
      ];

      sansSerif = [
        "Work Sans"
        "Noto Cjk Sans"
      ];
    };
  };
}
