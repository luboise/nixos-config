{pkgs, ...}: let
  monokai-pro = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "monokai-pro";
    rtpFilePath = "monokai.tmux";
    version = "please";
    src = pkgs.fetchFromGitHub {
      owner = "maxpetretta";
      repo = "tmux-monokai-pro";
      rev = "de4b251f413c17cc01b2eee32a0f9eab92703836";
      sha256 = "sha256-STILIv6L+SLsMe/ka8VPca41H8OzxHQG3BBlerRCcEk=";
    };
  };
in {
  home.packages = [
    pkgs.tmux
    pkgs.tmuxp
  ];

  programs.tmux = {
    enable = true;
    keyMode = "vi";

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      monokai-pro
    ];

    baseIndex = 1;
    mouse = true;
    prefix = "C-n";
    tmuxp.enable = true;

    extraConfig = ''
      unbind r
      bind r source-file ~/.tmux.conf

      bind-key h select-pane -L
      bind-key l select-pane -R
      bind-key j select-pane -D
      bind-key k select-pane -U

      unbind C-Tab
      unbind C-S-Tab
      # bind-key C-Tab next-window
      # bind-key C-S-Tab previous-window

      bind-key -T prefix C-x kill-window
      bind-key -T prefix C-X kill-session

      set-option -g status-position top
    '';
  };
}
