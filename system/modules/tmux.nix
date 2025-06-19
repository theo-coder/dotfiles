{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;

    plugins = with pkgs; [
      tmuxPlugins.yank
      tmuxPlugins.sensible
    ];

    extraConfig = ''
      set -ga terminal-overrides ",xterm-256color:RGB"
      set -g default-terminal "tmux-256color"
      set -g mouse on
      set -g history-limit 100000
      set -g focus-events on
      set -gq allow-passthrough on

      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix

      bind -n M-n new-window
      bind -n M-q killp
      bind -n M-Q killw
      bind -n M-e detach

      bind -n "M-Left" select-window -t :-
      bind -n "M-Right" select-window -t :+

      bind -n M-/ split-window -v
      bind -n M-? split-window -h

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind -n M-H resize-pane -L 3
      bind -n M-J resize-pane -D 3
      bind -n M-K resize-pane -U 3
      bind -n M-L resize-pane -R 3

      bind -n M-z resize-pane -Z

      set -g status on
      set -g base-index 1
      setw -g pane-base-index 1
      set -g status-interval 1
      set -g status-justify left
      set -g status-keys vi
      set -g status-position bottom
      set -g status-style fg="#CDD6F4",bg="#11111B"
      set -g status-left-length 20
      set -g status-left "#[bold] #S▕"

      set -g status-right "#[bold] %A, %d %B %Y  %H:%M "
      set -g window-status-separator ""

      set -g window-status-style fg="#585B70",bg="#11111B"
      set -g window-status-format "  #I #W  ▕"

      set -g window-status-current-style fg="#BAC2DE",bg="#1F1F28"
      set -g window-status-current-format "  #I #[bold]#W  ▕"
    '';
  };
}
