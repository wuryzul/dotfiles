{ config, lib, pkgs, ... }: {
  users.users.wury = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = [ "docker" "wheel" ]; # Enable ‘sudo’ for the user.
  };
}
