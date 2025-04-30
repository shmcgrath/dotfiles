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
    gcc
    gdb
    git
    jq
    minify
    shmNeomutt
    neovim
    p7zip
    pandoc
    pass
    pkgconf
    poppler
    restish
    ripgrep
    stow
    tmux
    vifm
    w3m
    yazi
	zig
	zls
    zola
    zoxide
  ];
}
