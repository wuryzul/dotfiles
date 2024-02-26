{ config, libs, pkgs, ... }: {
  imports = [ <nixos-wsl/modules> ];

  wsl.enable = true;
  wsl.defaultUser = "wury";
  system.stateVersion = "23.11";
}
