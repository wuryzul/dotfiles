{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wury";
  home.homeDirectory = "/home/wury";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [ 
    direnv
    fd
    fish
    fishPlugins.done
    fishPlugins.grc
    fishPlugins.tide
    fishPlugins.z
    fishPlugins.forgit
    git
    grc
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    ranger
    ripgrep
    tmux
    wget
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    neovim = {
      recursive = true;
      source = ../../nvim;
      target = ".config/nvim";
    };
    tmux = {
      source = ../../tmux/tmux.conf;
      target = ".config/tmux/tmux.conf";
    };
    fish_themes = {
      recursive = true;
      source = ../../fish/themes;
      target = ".config/fish/themes";
    };
    gitignore = {
      source = ../../git/config;
      target = ".config/git/config";
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wury/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -gx DIRENV_LOG_FORMAT ""
    '';
    shellAliases = {
      vi = "nvim";
      vim = "nvim";
      l = "ls -l";
      la = "ls -la";
    };
    plugins = [
      {
        name = "catppuccin";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "fish";
          rev = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
          sha256 = "Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
        };
      }
      { name = "done"; src = pkgs.fishPlugins.done.src; }
      { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
      { name = "z"; src = pkgs.fishPlugins.z.src; }
    ];
  };

# programs.starship = {
#    enable = true;
#    enableFishIntegration = true;
#    settings = {
#      add_newline = true;
#      scan_timeout = 10;
#      palette = "catppuccin_mocha";
#      palettes."catppuccin_mocha" = {
#        rosewater = "#f5e0dc";
#        flamingo = "#f2cdcd";
#        pink = "#f5c2e7";
#        mauve = "#cba6f7";
#        red = "#f38ba8";
#        maroon = "#eba0ac";
#        peach = "#fab387";
#        yellow = "#f9e2af";
#        green = "#a6e3a1";
#        teal = "#94e2d5";
#        sky = "#89dceb";
#        sapphire = "#74c7ec";
#        blue = "#89b4fa";
#        lavender = "#b4befe";
#        text = "#cdd6f4";
#        subtext1 = "#bac2de";
#        subtext0 = "#a6adc8";
#        overlay2 = "#9399b2";
#        overlay1 = "#7f849c";
#        overlay0 = "#6c7086";
#        surface2 = "#585b70";
#        surface1 = "#45475a";
#        surface0 = "#313244";
#        base = "#1e1e2e";
#        mantle = "#181825";
#        crust = "#11111b";
#      };
#      character = {
#        success_symbol = "[➜](bold green)";
#        error_symbol = "[➜](bold red)";
#      };
#    };
#  };
  programs.home-manager.enable = true;
}
