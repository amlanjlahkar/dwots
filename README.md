# Dwots 

This is the collection of my personal dotfiles and some simple shell scripts I've been utilizing on my linux machine.

For portability purpose, I've chosen to manage my dotfiles with [stow](https://www.gnu.org/software/stow/ "ganoo stow to be precise").
According to the documentation:
>  Stow is a symlink farm manager which takes distinct sets of software and/or data located in separate directories on the filesystem, and makes them all appear to be installed in a single directory tree. 

This repository or what I should say is that this (stow)directory has been organized in a way that each individual child directories inside of it represent the name of a specific program/package and mimic the structure of the target directory - which is the `$HOME` directory by default. The purpose of this imitation is simple - so that whenever one of these sub-directories is  ***stow*** ed from the parent stow directory, their directory hierarchy is replicated inside the target(`$HOME`) directory and the respective configuration files are symlinked accordingly.

I've also included a list of explicitly installed native packages on my system to make the process of restoration more straightforward.
```bash
$ git clone https://gitlab.com/amlanjyotilahkar/dwots.git
$ doas pacman -S --needed - < ~/dwots/program_list.txt
$ cd dwots && stow -nv */	# for safety purpose
```
There are easy ways to make this process even less complicated and more future-proof with the help of scripts or makefiles and I'm working on finding a better solution for it but until then, this will do the work.

In the meantime, if you would like to send any suggestions or even PRs, feel free to suggest them anytime you want!

---
