let
  keys = import ./keys.nix;
in
{
  "crona/passwords/luna.age".publicKeys = [
    keys.crona.root
    keys.crona.luna
  ];

  "crona/passwords/root.age".publicKeys = [
    keys.crona.root
    keys.crona.luna
  ];
}
