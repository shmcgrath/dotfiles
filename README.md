# Dotfiles

This is a collection of my dotfiles. I am just starting to build them up in March of 2017. I am currently running an [Arch Linux](https://www.archlinux.org/) pseudo-server and am using an Apple laptop. I sync the dotfiles with [Dropbox.](https://www.dropbox.com/) I use git for version control and keep non-sensitive dotfiles in [this](https://github.com/shmcgrath/dotfiles) public GitHub repo.

I will update this README with more links, tips, and information as I grow my dotfiles. 

## Dotfile Management with GNU Stow and GitHub

I use [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) to manage my dotfiles. This allows me to easily create symlinks on any \*nix-based system I am using. I chose Stow because it is easily and universally available on \*nix machines. I do use Windows boxes, but I don't see myself needing the majority of my dotfiles on those machines. One tool I found when looking for Windows alternatives is [stow-lite](https://github.com/ericsubach/stow-lite) but I have not used it yet. I also chose stow because I would be able to use it to manage config files that are not in ~/. In the future, I can use stow to deploy centralized config files across my system(s). 
 
### GNU Stow and .DS\_Store Files

I ran into a bit of an issue when creating the symlinks on Sierra. I kept getting an error message referencing .DS\_Store files. After some Googling, I found that if you run Stow with an --ignore flag for .DS\_Store, that error will not pop.

``` bash
$ stow -v --ignore ".DS_Store" -t ~/ folder

```

You can also create a [.stow-global-ignore file](https://www.gnu.org/software/stow/manual/stow.html#Ignore-Lists) in your home directory and add .DS_Store to that file.

## Useful Links for Dotfile Management and Creation
These are some of the links that I found useful when figuring out how to manage dotfiles and when setting up the programs they configure.

### Dotfiles
- [Arch Linux Wiki on dotfiles](https://wiki.archlinux.org/index.php/Dotfiles)
- [GitHub Dotfiles](https://dotfiles.github.io/)
- [Hacker News - Using GNU Stow to manage your dotfiles](https://news.ycombinator.com/item?id=8487840)
- [Hacker News - What do you use to manage dotfiles?](https://news.ycombinator.com/item?id=11070797)
- [Hacker News - Managing dotfiles with GNU Stow](https://news.ycombinator.com/item?id=11515222)

### [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html)
- [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
- [Managing Dotfiles with GNU Stow](https://taihen.org/managing-dotfiles-with-gnu-stow/)
- [Stow Your Dotfiles - GNW Stow for Managing Symlinks](https://spin.atomicobject.com/2014/12/26/manage-dotfiles-gnu-stow/)
- [Stow](http://onethingwell.org/post/39744163899/stow-your-dotfiles)
- [Using GNU Stow to Manage Your Dotfiles](http://www.kianmeng.org/2014/03/using-gnu-stow-to-manage-your-dotfiles.html)

### Bash
- [Nathaniel Landau's Bash Profile Gist](https://gist.github.com/natelandau/10654137/)

### [Vim](http://www.vim.org/)
- [A Good Vimrc](https://dougblack.io/words/a-good-vimrc.html)
- [Learn Vimscript the Hard Way](http://learnvimscriptthehardway.stevelosh.com)
- [Best of My Vimrc](http://sts10.github.io/blog/2016/02/12/best-of-my-vimrc/)

## My Config Notes:
- Current iTerm colorscheme: base16 tomorrownight dark 256
- When bootstraping a new machine, change the $HOME in .stowrc to the actual home path of the machine
- Make sure to mark stowrc and newsblur-pass as [assume-unchnaged](https://www.git-scm.com/docs/git-update-index)
