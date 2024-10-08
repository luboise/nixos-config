{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.lucasjr = {
    home = {
      file = {};

      packages = with pkgs; [
        # Typical User Apps
        qbittorrent

        steam
        discord
        armcord
        vesktop

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
      # TODO: Clean this up
      stateVersion = "24.05";
    };

    programs.home-manager.enable = true;
  };
}
