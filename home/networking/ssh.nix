{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "Host blackstar" = {
        HostName = "toodeluna.net";
        User = "luna";
      };

      "Host crona" = {
        HostName = "crona.local";
        User = "luna";
      };

      "Host tsubaki" = {
        HostName = "tsubaki.local";
        User = "luna";
      };
    };
  };
}
