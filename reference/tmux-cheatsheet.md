title: tmux Cheat Sheet
date: 2017-04-15 22:49
tags: #tmux #cli #commandline

- - - - -

# tmux Cheat Sheet

- - - - -

tmux prefix: Crtl + space

## tmux Default Commands and Keybindings

### General tmux Commands

|                    tmux Function                    |         tmux Command         |
|:---------------------------------------------------:|:----------------------------:|
|display list of keyboard shortcuts                   |<prefix> ?                    |
|command prompt                                       |<prefix> :                    |
|copy mode                                            |<prefix> [                    |
|list every outbound key and command it runs          |tmux list-keys                |
|lists out every tmux command and its arguments       |tmux list-commands            |
|lists out every session, window, pane, its pid, etc. |tmux info                     |
|reloads the current tmux configuration               |tmux source-file ~/.tmux.conf |

### Session Commands

|            tmux Function            |         tmux Command         |
|:-----------------------------------:|:----------------------------:|
|start new session                    |tmux new -s name              |
|attach to named session              |tmux attach -t name           |
|list sessions                        |tmux ls OR <leader> s         |
|kill session                         |tmux kill-session -t name     |
|detach                               |<prefix> d                    |
|kill all sessions but current        |tmux kill-session -a          |
|rename session                       |<prefix> $                    |
|move to previous session             |<prefix> (                    |
|move to next session                 |<prefix> )                    |

### tmux Windows

|            tmux Function            |         tmux Command         |
|:-----------------------------------:|:----------------------------:|
|create window                        |<prefix> c                    |
|list windows                         |<prefix> w                    |
|next window                          |<prefix> n                    |
|previous window                      |<prefix> p                    |
|find window                          |<prefix> f                    |
|name window                          |<prefix> ,                    |
|kill window                          |<prefix> &                    |
|swap windows                         |:swap-window -s {src} -t {dst}|
|move current window left by X pos    |:swap-window -t -X            |

### tmux Panes

|            tmux Function            |         tmux Command         |
|:-----------------------------------:|:----------------------------:|
|vertical split                       |<prefix> %                    |
|horizontal split                     |<prefix> "                    |
|kill pane                            |<prefix> x                    |
|break pane into window               |<prefix> +                    |
|show pane numbers                    |<prefix> q                    |
|swap pane                            |<prefix> o                    |
|restore pane from window             |<prefix> -                    |
|move current pane left               |<prefix> {                    |
|move current pane right              |<prefix> }                    |
|switch to the pane in direction      |<prefix> {arrow key}          |

## My tmux Keybindings

|            tmux Function            |         tmux Command         |
|:-----------------------------------:|:----------------------------:|
|reload tmux config                   |<leader> r                    |
