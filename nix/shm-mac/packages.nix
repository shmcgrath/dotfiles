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
    ffmpeg-full
    fzf
    git
    jq
    shmNeomutt
    neovide
    neovim
    pass
    poppler
    ripgrep
    stow
    tmux
    vifm
    w3m
    yazi
    zoxide
  ];
}

