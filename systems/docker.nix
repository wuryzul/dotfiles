{ config, libs, pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      docker
    ];
  };

  networking.firewall.enable = false;
}
