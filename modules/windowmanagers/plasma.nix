{
  lib,
  config,
  ...
}:
with lib; {
  config = mkIf (config.systemOptions.windowManager == "plasma") {
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.defaultSession = "plasma";
    services.desktopManager.plasma6.enable = true;
  };
}
