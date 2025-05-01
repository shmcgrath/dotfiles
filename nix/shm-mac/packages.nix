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
	bash
    bat
	calcurse
    eza
    fd
    ffmpeg-full
    fzf
    gcc
    gdb
    git
    jq
	khard
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
	todo-txt-cli
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
