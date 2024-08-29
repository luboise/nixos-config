{
  lib,
  fetchFromGitHub,
  config,
  ...
}: {
  options.tmux.enable = lib.mkEnableOption "TMUX Multiplexer";

  config = lib.mkIf config.tmux.enable {
    home-manager.users.lucasjr.home.programs.tmux = {
      keyMode = "vi";
      mouse = true;
      prefix = "C-n";

      tmuxp.enable = true;

      plugins = [
        (lib.mkTmuxPlugin {
          pluginName = "monokai-pro";
          src = fetchFromGitHub {
            owner = "";
            repo = "";
            hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          };
        })
      ];

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

        # tmux plugins
        # set -g @plugin 'tmux_plugins/tpm'

        # Smart pane switching with awareness of Vim splits.
        # See: https://github.com/christoomey/vim-tmux-navigator
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -U
        bind-key -T copy-mode-vi 'C-k' select-pane -D
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l

        # run '~/.tmux/plugins/tpm/tpm'
      '';
    };
  };
}
