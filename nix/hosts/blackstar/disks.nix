{
  disko.devices.disk.sda = {
    type = "disk";
    device = "/dev/sda";

    content = {
      type = "gpt";

      partitions.boot = {
        name = "boot";
        size = "1M";
        type = "EF02";
      };

      partitions.esp = {
        name = "ESP";
        size = "1G";
        type = "EF00";

        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
        };
      };

      partitions.root = {
        name = "root";
        size = "100%";

        content = {
          type = "filesystem";
          format = "btrfs";
          mountpoint = "/";
        };
      };
    };
  };
}
