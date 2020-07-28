# Contents

- [CONFIG](#CONFIG)
    - [setup](#CONFIG#setup)
    - [show commit tree](#CONFIG#show commit tree)
    - [.gitconfig example](#CONFIG#.gitconfig example)
- [.gitmodules](#.gitmodules)
    - [ignore files in submodules](#.gitmodules#ignore files in submodules)
- [REMOTE](#REMOTE)
    - [get and set url](#REMOTE#get and set url)
    - [update remote url](#REMOTE#update remote url)
- [CLONE](#CLONE)
    - [get git repo to a nonempty directory](#CLONE#get git repo to a nonempty directory)
- [CHANGES](#CHANGES)
    - [view changes](#CHANGES#view changes)
    - [view changed branches on github](#CHANGES#view changed branches on github)
- [SUBMODULES](#SUBMODULES)
    - [update an individual submodule](#SUBMODULES#update an individual submodule)
    - [remove a submodule](#SUBMODULES#remove a submodule)
    - [git clone including submodules](#SUBMODULES#git clone including submodules)
    - [init from .gitmodules](#SUBMODULES#init from .gitmodules)
- [HISTORY](#HISTORY)
    - [delete files from history](#HISTORY#delete files from history)
- [SPLIT](#SPLIT)
    - [create a new repo from subdirectory](#SPLIT#create a new repo from subdirectory)

# CONFIG
## setup
```bash
#!/bin/bash

git config --global user.email "rpi3.tomek@protonmail.com"
git config --global user.name "Jan Tomek"
```

## show commit tree
shows commits in a graphical manner

`log --graph --decorate --pretty=oneline --abbrev-commit`

## .gitconfig example
```gitconfig
[user]
	name = honzatomek
	email = rpi3.tomek@protonmail.com
[alias]
        tree = log --graph --decorate --pretty=oneline --abbrev-commit
	vlog = log --no-color
	vdiff = diff --no-color
        pp = "!git pull && git push"
[core]
        autocrlf = input
[core]
	editor = vim
	# pager = vim -c 'set ft=git' -c AnsiEsc -
	# pager = vim -c 'set ft=git' -
[diff]
	tool = vimdiff
[merge]
	tool = vimdiff
[difftool]
	prompt = false
#[difftool "vimdiff"]
#	# cmd = vimdiff $LOCAL $REMOTE $MERGED $BASE
#        cmd = vimdiff $LOCAL $MERGED $REMOTE
```

# .gitmodules
## ignore files in submodules
This is helpful when for example vim creates help tags in a doc directory of a plugin added as a git submodule.
The easy approach is to set ignore to dirty in .gitmodules file.

The standard `git status` output:
```git
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)
  (commit or discard the untracked or modified content in submodules)

	modified:   bundle/bash-support (untracked content)

no changes added to commit (use "git add" and/or "git commit -a")
```

And `git status` output from inside of the submodule:
```git
HEAD detached at 309d6fe
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	doc/tags
	doc/tags-te

nothing added to commit but untracked files present (use "git add" to track)
```

**Solution:**
```gitconfig
[submodule "bundle/bash-support"]
	path = bundle/bash-support
	url = https://github.com/vim-scripts/bash-support.vim
	branch = master
	ignore = dirty
```

# REMOTE
## get and set url
```bash
git remote get-url origin
git remote set-url origin <newurl> [<oldurl>]
```

## update remote url
Updating the **remote git repository url**:
```bash
#!/bin/bash

new_url='git@github.com:honzatomek/linux_config.git'

git remote remove origin
git remote add origin "${new_url}"
git push --set-upstream origin master
git push
git log | head -n 15
```

# CLONE
## get git repo to a nonempty directory
Clone just the repository's .git folder (excluding files as they are
already in `existing-dir`) into an empty temporary directory:

`git clone --no-checkout repo-to-clone existing-dir/existing-dir.tmp`

might want `-no-hardlinks` for cloning local repo

Move the .git folder to the directory with the files. This makes
`existing-dir` a git repo:

`mv existing-dir/existing-dir.tmp/.git existing-dir/`

Delete the temporary directory:

`rmdir existing-dir/existing-dir.tmp`
`cd existing-dir`

Git thinks all files are deleted, this reverts the state of the repo
to HEAD. WARNING: any local changes to the files will be lost.

`git reset --hard HEAD`

to update all submodules:

`git submodule foreach git pull origin master`

# CHANGES
## view changes
to let git generate the patches for each log entry:

`git log -p filename`

To get just the **diff** for a specific commit you can:

`git show HEAD`

or use:

`gitk`

## view changed branches on github
you can see which branches got updated, so you don't really need any
further commands:

`git remote -v update`

will tell you whether the branch you are tracking is ahead, behind or has
diverged. If it says nothing, the local and remote are the same:

`git status -uno`

will show you the commits in all of the branches whose names end in **master**
(eg. master and origin/master):

`git show-branch *master`

I suggest you go see the script https://github.com/badele/gitcheck
I have coded this script for check in one pass all your Git repositories,
and it shows who has not committed and who has not pushed/pulled.

# SUBMODULES
## update an individual submodule
Get the submodule initially:

```bash
git submodule add ssh://bla submodule_dir
git submodule init
```

Time passes, submodule upstream is updated and you now want to update.
Change to the submodule directory:

`cd submodule_dir`

Checkout desired branch:

`git checkout master`

Update:

`git pull`

Get back to your project root:

`cd ..`

Now the submodules are in the state you want, so:

`git commit -am "Pulled down update to submodule_dir"`

## remove a submodule
Remove the submodule entry from **.git/config**:

`git submodule deinit -f path/to/submodule`

Remove the submodule directory from the superproject's **.git/modules**
directory:

`rm -rf .git/modules/path/to/submodule`

Remove the entry in **.gitmodules** and remove the submodule directory located
at **path/to/submodule**:

`git rm -f path/to/submodule`

## git clone including submodules
With version 2.13 of Git and later, `--recurse-submodules` can be used
instead of `--recursive`:

`git clone --recurse-submodules -j8 git://github.com/foo/bar.git`
`cd bar`

`-j8` is an optional performance optimization that became available in
version 2.8, and fetches up to 8 submodules at a time in parallel — see
`man git-clone`.

With version 1.9 of Git up until version 2.12 (`-j` flag only available in
version 2.8+):

`git clone --recursive -j8 git://github.com/foo/bar.git`
`cd bar`

With version 1.6.5 of Git and later, you can use:

`git clone --recursive git://github.com/foo/bar.git`
`cd bar`

For already cloned repos, or older Git versions, use:

`git clone git://github.com/foo/bar.git`
`cd bar`
`git submodule update --init --recursive`

## init from .gitmodules
FROM: https://stackoverflow.com/a/59634978

A script to initialise git **submodules* from an existing *.gitmodules** file.

The concept is to parse the **.gitmodules** file and for each entry run
`git submodule add -f -b <branch> <url> <path>`
if the submodule is not yet in the git tree, otherwise run **git checkout**.

```bash
#!/bin/bash
# From: https://stackoverflow.com/a/59634978

git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
  while read path_key path
  do
    url_key=$(echo $path_key | sed 's/\.path/.url/');
    branch_key=$(echo $path_key | sed 's/\.path/.branch/');
    # If the url_key doesn't yet exist then backup up the existing
    # directory if necessary and add the submodule
    if [ ! $(git config --get "$url_key") ]; then
      if [ -d "$path" ] && [ ! $(git config --get "$url_key") ]; then
        mv "$path" "$path""_backup_""$(date +'%Y%m%d%H%M%S')";
      fi;
      url=$(git config -f .gitmodules --get "$url_key");
      # If a branch is specified then use that one, otherwise
      # default to master
      branch=$(git config -f .gitmodules --get "$branch_key");
      if [ ! "$branch" ]; then branch="master"; fi;
      git submodule add -f -b "$branch" "$url" "$path";
    fi;
  done;

# In case the submodule exists in .git/config but the url is out of date

git submodule sync;

# Now actually pull all the modules. I used to use this...
#
# git submodule update --init --remote --force --recursive
# ...but the submodules would check out in detached HEAD state and I
# didn't like that, so now I do this...

git submodule foreach --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)';
```

# HISTORY
## delete files from history
when you accidentally forget to ignore a file with credentials, temp files etc.
before several commits - **remove a file that is already embedded in git history**:

`git filter-branch --index-filter 'git rm -q --cached --ignore-unmatch *.tmp *~' -- --all`

To push the changed git history onto github `--force` option is needed:

`git push --force`

To delete backup created by `git filter-branch` use:

`git update-ref -d refs/original/refs/heads/master`

# SPLIT
## create a new repo from subdirectory
split subdirectory from main repo to a new repository using `git subtree split`

```bash
#!/bin/env bash

# Script to split a directory from a repository
# Must be run from root of the repo
# IN: directory to split
#     link to github repo
# USE: git_split_repo DIR GITHUB_REPO

# 1. Prepare the old repo
# cd <big-repo>
# git subtree split -P <name-of-folder> -b <name-of-new-branch>
# Note: <name-of-folder> must NOT contain leading or trailing characters. For instance, the folder named subproject MUST be passed as subproject, NOT ./subproject/
cwd="$(pwd)"
git subtree split -P "$1" -b 'subtree_'"$1"

# 2. Create the new repo
mkdir -P ~/tmp/"$1" && cd ~/tmp/"$1"
git init
git pull "${cwd}"  'subtree_'"$1"

# 3. Link the new repo to GitHub or wherever
# git remote add origin <git@github.com:user/new-repo.git>
# git push -u origin master

git remote add origin "$2"
git push -u origin master

# 4. Cleanup inside <big-repo>, if desired
# git rm -rf <name-of-folder>
git rm -rf "${cwd}/$1"
```

[back to index](index.md)
