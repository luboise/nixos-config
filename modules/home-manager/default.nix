{
  inputs,
  config,
  pkgs,
  pkgs-stable,
  lib,
  ...
}:
with lib; let
  cfg = config.home-manager;
in {
  ###
  imports = [
    ./windowmanagers

    ./dev/tmux.nix
    ./alacritty.nix
  ];

  # TODO: Clean this up a bit
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lucasjr";
  home.homeDirectory = "/home/lucasjr";

  home.stateVersion = "24.05";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {};

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lucasjr/etc/profile.d/hm-session-vars.sh
  #

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Typical User Apps
    qbittorrent

    steam
    discord

    falkon
    chromium

    neofetch

    # Productivity
    texmaker

    drawio
    pinta
    gimp
    # TODO: Fix this
    # ciscoPacketTracer8

    obsidian

    unityhub

    # Maintenance Apps
    gparted
    efibootmgr
    ntfs3g

    htop

    # Godsends
    zoxide

    # CLI Tools
    zip
    unzip
    unrar

    arp-scan
    tree
    progress

    hexyl

    xclip

    drive
    onedrive

    # GUI Tools
    # TODO: Fix this
    # realvnc-vnc-viewer

    # Dev
    jetbrains-mono
  ];

  programs.fish = {
    enable = true;

    shellAliases = {
      fucking = "sudo";
    };

    shellInit = "zoxide init fish --cmd cd | source";

    functions = {
      clip = {
        body = "xclip -selection clipboard $argv";
      };

      ConnectPi = {
        body = ''          set ip (arp -a | grep "on enp46s0" | awk '{print $2}' | tr -d '()')
              				if test -n "$ip"
                  				ssh lucas@$ip
              				else
                  				echo "No IP address found for enp46s0"
              				end'';
      };

      ssh-home = {
        body = "killall ssh-agent; and eval (ssh-agent -c); and ssh-add ~/.ssh/github_luboise $argv";
      };
      ssh-uni = {
        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
        body = "killall ssh-agent; and eval (ssh-agent -c); and ssh-add ~/.ssh/id_ed25519 $argv";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}
