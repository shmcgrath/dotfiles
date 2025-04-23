{ pkgs, system }:

let
  vifmPkg = if system == "x86_64-darwin" then pkgs.vifm else pkgs.vifm-full;
in

pkgs.buildEnv {
  name = "shm-darwin";
  paths = with pkgs; [
    bat
    eza
    fd
    fzf
    git
    neomutt
    neovide
    neovim
    pass
    ripgrep
    stow
    tmux
    vifmPkg
    w3m
    yazi
    zoxide
  ];
}

