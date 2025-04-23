{ pkgs }:

pkgs.buildEnv {
  name = "shm-darwin";
  paths = with pkgs; [
    git
    stow
    bat
    eza
    fd
    neovim
    ripgrep
    tmux
  ];
}

