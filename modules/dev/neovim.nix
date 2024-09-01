{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ghc
  ];

  home-manager.users.lucasjr = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;

      plugins = with pkgs; [
        vimPlugins.omnisharp-extended-lsp-nvim
      ];

      extraPackages = with pkgs; [
        # c#
        csharpier
        omnisharp-roslyn

        # Lua
        lua-language-server
        stylua

        # Elixir
        elixir-ls

        # Haskell
        haskell-language-server
      ];
    };
  };
}
