{ pkgs, system }:

let
  shmNotmuch = pkgs.notmuch.override {
    withEmacs = false;
  };

  shmNeomutt = pkgs.neomutt.override {
    notmuch = shmNotmuch;
  };

in pkgs.buildEnv {
  name = "shm-darwin";
  paths = with pkgs; [
    bat
    eza
    fd
    fzf
    git
    shmNeomutt
    neovide
    neovim
    pass
    ripgrep
    stow
    tmux
    vifm
    w3m
    yazi
    zoxide
  ];
}

