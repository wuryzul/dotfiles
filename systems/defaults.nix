{ config, libs, pkgs, ... }: {
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  environment = {
    systemPackages = with pkgs; [
      docker
      fish
      git
      neovim
      wget
    ];
    variables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  programs = {
    ssh.startAgent = true;

    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  };

  services.openssh.enable = true;
  virtualisation.docker.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "23.11";
}
