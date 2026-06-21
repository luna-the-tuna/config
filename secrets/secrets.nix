let
  keys = import ./keys.nix;
in
{
  "crona/users/luna.age".publicKeys = [
    keys.crona.luna
    keys.crona.root
  ];

  "crona/users/root.age".publicKeys = [
    keys.crona.luna
    keys.crona.root
  ];
}
