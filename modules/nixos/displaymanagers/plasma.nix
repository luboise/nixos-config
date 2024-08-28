{
  lib,
  config,
  pkgs,
  ...
}:
with lib; {
  config = mkIf (config.systemOptions.windowManager == "plasma") {
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.defaultSession = "plasma";
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
