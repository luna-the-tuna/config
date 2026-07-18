let
  keys = import ./keys.nix;
in
{
  # keep-sorted start block=yes newline_separated=yes
  "blackstar/passwords/luna.age".publicKeys = [
    keys.blackstar.root
    keys.blackstar.luna
  ];

  "blackstar/passwords/root.age".publicKeys = [
    keys.blackstar.root
    keys.blackstar.luna
  ];

  "blackstar/wireguard/private-key.age".publicKeys = [
    keys.blackstar.root
    keys.blackstar.luna
  ];

  "crona/passwords/luna.age".publicKeys = [
    keys.crona.root
    keys.crona.luna
  ];

  "crona/passwords/root.age".publicKeys = [
    keys.crona.root
    keys.crona.luna
  ];

  "tsubaki/passwords/luna.age".publicKeys = [
    keys.tsubaki.root
    keys.tsubaki.luna
  ];

  "tsubaki/passwords/root.age".publicKeys = [
    keys.tsubaki.root
    keys.tsubaki.luna
  ];

  "tsubaki/protonvpn/private-key.age".publicKeys = [
    keys.tsubaki.root
    keys.tsubaki.luna
  ];

  "tsubaki/wireguard/private-key.age".publicKeys = [
    keys.tsubaki.root
    keys.tsubaki.luna
  ];
  # keep-sorted end
}
