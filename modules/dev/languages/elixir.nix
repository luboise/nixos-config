{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.dev.languages.elixir.enable = mkEnableOption "Enable and all things necessary for elixir";

  config = mkIf config.dev.languages.elixir.enable {
    environment.systemPackages = with pkgs; [
      elixir
    ];
  };
}
