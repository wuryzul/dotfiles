{ config, lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking = {
    usePredictableInterfaceNames = true;

    hostName = "template";

    interfaces = {
      enp6s18.ipv4.addresses = [ {
        address = "10.32.10.99";
        prefixLength = 16;
      } ];
    };

    defaultGateway = "10.32.0.1";

    nameservers = [
      "10.32.0.100"
      "10.160.0.100"
      "10.32.0.101"
      "10.160.0.101"
    ];
  };

  system.stateVersion = "23.11";
}

