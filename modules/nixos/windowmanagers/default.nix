{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  windowManagers = ["plasma" "hyprland"];

  # Validation function
  validateWindowManager = let
    manager = config.systemOptions.windowManager;
  in
    if (manager == "")
    then throw "You must specify a window manager. Expected one of " + toString windowManagers
    else if ! (builtins.elem manager windowManagers)
    then throw "Invalid window manager received: " + manager + ". Expected one of " + toString windowManagers
    else {};
in {
  imports = [
    ./hyprland.nix
    ./plasma.nix
  ];

  options.systemOptions.windowManager = mkOption {
    type = types.str;
    default = "";
    example = windowManagers;
    description = "Choose the window manager";
  };

  options.systemOptions.throwables = validateWindowManager;
}
