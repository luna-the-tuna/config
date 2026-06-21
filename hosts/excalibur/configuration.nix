{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.homebrew.darwinModules.default
    inputs.oomf-time.darwinModules.default
  ];

  soul.users.luna = {
    primary = true;
    firstName = "Luna";
    lastName = "Heyman";
    email = "contact@luna.fish";
  };

  home-manager = {
    users.luna = ./home.nix;
  };

  programs = {
    oomf-time.enable = true;
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    autoMigrate = true;
    mutableTaps = false;
    user = config.system.primaryUser;

    taps = {
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-core" = inputs.homebrew-core;
    };
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;

    onActivation = {
      cleanup = "zap";
      upgrade = true;
      autoUpdate = true;
    };

    casks = [
      "citrix-workspace"
      "microsoft-outlook"
      "microsoft-teams"
      "sol"
    ];
  };

  fonts.packages = [
    pkgs.work-sans
    pkgs.maple-mono.NF
  ];

  environment.systemPackages = [
    pkgs.vscode
  ];
}
