# git Reference

- [Pro Git](https://git-scm.com/book/en/v2)
- [Using the Fork-and-Branch Git Workflow](Using the Fork-and-Branch Git Workflow)

## [Fork a Repo](https://help.github.com/en/articles/fork-a-repo) and [Syncing a Fork](https://help.github.com/en/articles/syncing-a-fork)


Type git remote -v and press Enter. You'll see the current configured remote repository for your fork.

$ git remote -v
> origin  https://github.com/YOUR_USERNAME/YOUR_FORK.git (fetch)
> origin  https://github.com/YOUR_USERNAME/YOUR_FORK.git (push)

Type git remote add upstream, and then paste the URL you copied in Step 2 and press Enter. It will look like this:

$ git remote add upstream https://github.com/octocat/Spoon-Knife.git

To verify the new upstream repository you've specified for your fork, type git remote -v again. You should see the URL for your fork as origin, and the URL for the original repository as upstream.

$ git remote -v
> origin    https://github.com/YOUR_USERNAME/YOUR_FORK.git (fetch)
> origin    https://github.com/YOUR_USERNAME/YOUR_FORK.git (push)
> upstream  https://github.com/ORIGINAL_OWNER/ORIGINAL_REPOSITORY.git (fetch)
> upstream  https://github.com/ORIGINAL_OWNER/ORIGINAL_REPOSITORY.git (push)

Fetch the branches and their respective commits from the upstream repository. Commits to master will be stored in a local branch, upstream/master.

$ git fetch upstream

Check out your fork's local master branch.

$ git checkout master
> Switched to branch 'master'

Merge the changes from upstream/master into your local master branch. This brings your fork's master branch into sync with the upstream repository, without losing your local changes.

$ git merge upstream/master

If your local branch didn't have any unique commits, Git will instead perform a "fast-forward":

$ git merge upstream/master

## [Git Cheat Sheet](http://cheat.errtheblog.com/s/git)

### Setup

git clone <repo>
  clone the repository specified by <repo>; this is similar to "checkout" in
  some other version control systems such as Subversion and CVS

Add colors to your ~/.gitconfig file:

  [color]
    ui = auto
  [color "branch"]
    current = yellow reverse
    local = yellow
    remote = green
  [color "diff"]
    meta = yellow bold
    frag = magenta bold
    old = red bold
    new = green bold
  [color "status"]
    added = yellow
    changed = green
    untracked = cyan

Highlight whitespace in diffs

  [color]
    ui = true
  [color "diff"]
    whitespace = red reverse
  [core]
    whitespace=fix,-indent-with-non-tab,trailing-space,cr-at-eol

Add aliases to your ~/.gitconfig file:

  [alias]
    st = status
    ci = commit
    br = branch
    co = checkout
    df = diff
    dc = diff --cached
    lg = log -p
    lol = log --graph --decorate --pretty=oneline --abbrev-commit
    lola = log --graph --decorate --pretty=oneline --abbrev-commit --all
    ls = ls-files

    # Show files ignored by git:
    ign = ls-files -o -i --exclude-standard


### Configuration

git config -e [--global]
  edit the .git/config [or ~/.gitconfig] file in your $EDITOR

git config --global user.name 'John Doe'
git config --global user.email johndoe@example.com
  sets your name and email for commit messages

git config branch.autosetupmerge true
  tells git-branch and git-checkout to setup new branches so that git-pull(1)
  will appropriately merge from that remote branch.  Recommended.  Without this,
  you will have to add --track to your branch command or manually merge remote
  tracking branches with "fetch" and then "merge".

git config core.autocrlf true
  This setting tells git to convert the newlines to the system's standard
  when checking out files, and to LF newlines when committing in

git config --list
  To view all options

git config apply.whitespace nowarn
  To ignore whitespace

You can add "--global" after "git config" to any of these commands to make it
apply to all git repos (writes to ~/.gitconfig).


### Info
git reflog
  Use this to recover from *major* mess ups! It's basically a log of the
  last few actions and you might have luck and find old commits that
  have been lost by doing a complex merge.

git diff
  show a diff of the changes made since your last commit
  to diff one file: "git diff -- <filename>"
  to show a diff between staging area and HEAD: `git diff --cached`

git status
  show files added to the staging area, files with changes, and untracked files

git log
  show recent commits, most recent on top. Useful options:
  --color       with color
  --graph       with an ASCII-art commit graph on the left
  --decorate    with branch and tag names on appropriate commits
  --stat        with stats (files changed, insertions, and deletions)
  -p            with full diffs
  --author=foo  only by a certain author
  --after="MMM DD YYYY" ex. ("Jun 20 2008") only commits after a certain date
  --before="MMM DD YYYY" only commits that occur before a certain date
  --merge       only the commits involved in the current merge conflicts

git log <ref>..<ref>
  show commits between the specified range. Useful for seeing changes from remotes:
  git log HEAD..origin/master # after git remote update

git show <rev>
  show the changeset (diff) of a commit specified by <rev>, which can be any
  SHA1 commit ID, branch name, or tag (shows the last commit (HEAD) by default)

  also to show the contents of a file at a specific revision, use 
     git show <rev>:<filename>
  this is similar to cat-file but much simpler syntax.

git show --name-only <rev>
  show only the names of the files that changed, no diff information.

git blame <file>
  show who authored each line in <file>

git blame <file> <rev>
  show who authored each line in <file> as of <rev> (allows blame to go back in
  time)

git gui blame
  really nice GUI interface to git blame

git whatchanged <file>
  show only the commits which affected <file> listing the most recent first
  E.g. view all changes made to a file on a branch:
    git whatchanged <branch> <file>  | grep commit | \
         colrm 1 7 | xargs -I % git show % <file>
  this could be combined with git remote show <remote> to find all changes on
  all branches to a particular file.

git diff <commit> head path/to/fubar
  show the diff between a file on the current branch and potentially another branch

git diff --cached [<file>]
  shows diff for staged (git-add'ed) files (which includes uncommitted git cherry-pick'ed files)

git ls-files
  list all files in the index and under version control.

git ls-remote <remote> [HEAD]
  show the current version on the remote repo. This can be used to check whether
  a local is required by comparing the local head revision.

### Adding / Deleting

git add <file1> <file2> ...
  add <file1>, <file2>, etc... to the project

git add <dir>
  add all files under directory <dir> to the project, including subdirectories

git add .
  add all files under the current directory to the project
  *WARNING*: including untracked files.

git rm <file1> <file2> ...
  remove <file1>, <file2>, etc... from the project

git rm $(git ls-files --deleted)
  remove all deleted files from the project

git rm --cached <file1> <file2> ...
  commits absence of <file1>, <file2>, etc... from the project

### Moving / Renaming Directories

git mv oldfolder newfolder

### Ignoring

Option 1:

Edit $GIT_DIR/.git/info/exclude. See Environment Variables below for explanation on $GIT_DIR.

Option 2:

Add a file .gitignore to the root of your project. This file will be checked in.

Either way you need to add patterns to exclude to these files.

### Staging

git add <file1> <file2> ...
git stage <file1> <file2> ...
  add changes in <file1>, <file2> ... to the staging area (to be included in
  the next commit

git add -p
git stage --patch
  interactively walk through the current changes (hunks) in the working
  tree, and decide which changes to add to the staging area.

git add -i
git stage --interactive
  interactively add files/changes to the staging area. For a simpler
  mode (no menu), try `git add --patch` (above)

### Unstaging

git reset HEAD <file1> <file2> ...
  remove the specified files from the next commit)
