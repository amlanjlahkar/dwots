# Dwots 

This is the collection of my personal dotfiles and some simple shell scripts I've been utilizing on my linux machine.

For portability purpose, I've chosen to manage my dotfiles with [stow](https://www.gnu.org/software/stow/ "ganoo stow to be precise").
According to the documentation:
>  Stow is a symlink farm manager which takes distinct sets of software and/or data located in separate directories on the filesystem, and makes them all appear to be installed in a single directory tree. 

This repository or what I should say is that this (stow)directory has been organized in such a way that each individual child directories inside of it represent the name of a specific program/package and mimic the structure of the target directory - which is the parent directory of the stow directory(i.e. I have this stow directory `dwots` placed inside `${HOME}/dwots`,
hence the target directory is going to be `$HOME`, however, it is possible to override this default behaviour).
The purpose of this imitation is simple - so that whenever one of the sub-directories is  ***stow*** ed from the stow directory, its directory hierarchy gets replicated inside the target directory and the respective configuration files are symlinked accordingly.

I've also included a list of explicitly installed native packages on my system to make the process of restoration more straightforward.

```bash
$ git clone https://github.com/amlanjlahkar/dwots.git ~/dwots
$ doas pacman -S --needed $(cat ~/dwots/program_list.txt)
$ cd ~/dwots && stow -n -v --ignore='^archived_.*' */     # check the verbose output of what stow "will" do without modifying the filesystem
```

There are easy ways to make this process even less complicated and more future-proof with the help of scripts or makefiles and I'm working on finding a better solution for it but until then, this will do the work.

In the meantime, if you would like to send any suggestions or even PRs, feel free to suggest them anytime you want!

---
