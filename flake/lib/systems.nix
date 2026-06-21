{
  flake.lib.systems = {
    switch =
      pkgs:
      { linux, darwin }:
      if pkgs.stdenv.hostPlatform.isLinux then
        linux
      else if pkgs.stdenv.hostPlatform.isDarwin then
        darwin
      else
        throw "unspported system detected";
  };
}
