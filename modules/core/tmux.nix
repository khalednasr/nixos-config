# Home Manager Module
{ pkgs, ... }:
{
  programs = {
    tmux  = {
      enable = true;
      mouse = true;
      clock24 = true;
      disableConfirmationPrompt = true;

      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator # C-{h,j,k,l} for pane navigation
        sensible
        gruvbox
      ];

      extraConfig = ''
        bind -n C-q killp

        bind -n C-p previous-window
        bind -n C-n next-window

        bind -n M-Up resize-pane -U 5
        bind -n M-Down resize-pane -D 5
        bind -n M-Left resize-pane -L 5
        bind -n M-Right resize-pane -R 5

        set-option -g prefix C-Space
        bind r command-prompt -I "#W" "rename-window '%%'"
        bind < split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
      '';
    };
  };
}
