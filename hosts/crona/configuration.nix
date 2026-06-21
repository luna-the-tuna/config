{ inputs, pkgs, ... }:
{
  imports = [
    inputs.catppuccin.nixosModules.default

    ./hardware-configuration.nix
    ./disk-configuration.nix
  ];

  hardware.graphics.extraPackages = [ pkgs.rocmPackages.clr.icd ];

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
    email = "luna@toodeluna.net";
  };

  soul.programs = {
    obs.enable = true;
  };

  programs.git.enable = true;

  fonts.enableDefaultPackages = false;

  networking.useDHCP = true;

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
    extraCompatPackages = [ pkgs.proton-ge-bin ];
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

  environment.systemPackages = [
    pkgs.davinci-resolve
    pkgs.gimp
    pkgs.kdePackages.kdenlive
    pkgs.pcsx2
    pkgs.qbittorrent
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
