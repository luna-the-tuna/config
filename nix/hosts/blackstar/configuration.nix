{
  soul.boot = {
    loader.program = "grub";
  };

  soul.hardware = {
    amdcpu.enable = true;
  };

  soul.users.accounts.luna = {
    firstName = "Luna";
    lastName = "Heyman";
    email = "contact@luna.fish";
  };

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "sd_mod"
    "uhci_hcd"
    "virtio_pci"
    "virtio_scsi"
  ];
}
