#!/usr/bin/env bash

# script to provide an easy to deploy interface
# when migrating the files from my dotfiles directory dwots

# Pre-check important conditionals
if [[ "$EUID" -eq 0 ]]
then
    printf "%s\n%s\n" "Running the script as root user can cause problems!" \
        "Aborting..."
    exit 2
fi
detectOS="$(grep "^ID" /etc/os-release | cut -d'=' -f2)"

## FUNCTIONS ##
# Function to check for availability of packages.
function checkDep() {
    [[ -z "$(whereis "$1" | cut -d':' -f2)" ]] && return 2 || return 0
}

# Function to get a valid yes/no choice from stdin.
function getChoice() {
    read -t20 -r -p "$1" user_choice
    if [[ $? -ne 0 ]]
    then
        printf "\n%s\n" "Timeout! Aborting..."
        exit 2
    elif [[ -z "$user_choice" ]]
    then
        printf "%s\n" "No input provided! Skipping..."
        return 2
    fi
    case "$user_choice" in
        n|N|no|No)
            printf "%s\n" "Skipping..." && return 2 ;;
        y|Y|yes|Yes)
            return 0 ;;
        *)
            printf "%s\n" "Invalid input! Skipping..." && return 2 ;;
    esac
}

# Function to call when there's only one pkg_dir inside a group.
function stowDir() {
    printf "\n%s\n" "The \"${1}\" directory contains the package directory for \"${2}\"."
    if getChoice "Do you want to link it? [Y/n] "
    then
        printf "%s\n" "Linking files for \"${2}\"..."
        stow --restow --dir="${1}" --target="$HOME" --verbose "${2}"
    fi
}

# Function to call when there's multiple pkg_dirs inside a group.
# The first argument is the name of the group
# The second argument is the array containing indexes of the directories to be linked
function stowMultiDirs() {
    usr_arr=("${!2}")
    # check whether the second argument is 'a(all)' or 'n(none)' 
    if [[ "${#usr_arr[@]}" -eq 1 && "${usr_arr[*]}" = 'n' ]]
    then
        printf "%s\n" "Skipping..."
        return 2
    elif [[ "${#usr_arr[@]}" -eq 1 && "${usr_arr[*]}" = 'a' ]]
    then
        if getChoice "Do you want to link every directory under \"${1}\"? [Y/n] "
        then
            printf "%s\n" "Linking directories..."
            declare -a dirs=()
            getDirs "$1" dirs 0
            for (( i=0; i < "${#dirs[@]}"; i++ )); do
                stow --restow --dir="$1" --target="$HOME" --verbose "${dirs[$i]}"
            done
        fi
    fi
    declare -a sub_pkg_dirs=()
    # store indexed directory names under $1 inside $sub_pkg_dirs
    getDirs "$1" sub_pkg_dirs 1
    # compare indexes from usr_arr with indexes from sub_pkg_dir
    # and link the successive dirs if they match
    for dir in "${sub_pkg_dirs[@]}"; do
        for index in "${usr_arr[@]}"; do
            if [[ $index -eq ${dir::1} ]]
            then
                printf "%s\n" "Linking files for \"${dir:2}\"..."
                stow --restow --dir="${1}" --target="$HOME" --verbose "${dir:2}"
            else
                continue
            fi
        done
    done
}

# Function to store pkg_dirs in a sub array.
# The first argument is the name of the group directory
# the second argument(used as a namref) is where the sub-array is stored
# the last argument(1 for true, 0 for false)
# determines whether to number the resultant directories or not
function getDirs() {
    declare -n dir_list="$2"; declare -i i=0
    for dir in ./"${1}"/*; do
        for (( ; i < "$(find ./"${1}"/*/ -mindepth 1 -maxdepth 1 -type d | wc -l)"; i++ )); do
            [ -d "$dir" ] || continue
            if [ "$3" -eq 1 ]
            then
                dir_list[${i}]="$(printf "%d %s\n" "$((i+1))" "${dir#\./*/}")"
            else
                dir_list[${i}]="$(printf "%s\n" "${dir#\./*/}")"
            fi
            i+=1
            break
        done
    done
}

# Function for comparing two arrays.
# The first argument is the user provided array of indexes for the chosen pkg directories
# The second argument is the array of indexes for the pkg directories
# Return error if any element from first array
# excedes the total number of elements in second array
function cmprArrs() {
    chosen_pkg_index=("${!1}")
    pkg_index=("${!2}")
    for (( i=0; i < "${#chosen_pkg_index[@]}"; i++)); do
        if [[ "${chosen_pkg_index[i]}" = '0' \
            || "${chosen_pkg_index[i]}" -gt "${#pkg_index[@]}" ]]
        then
            printf "%s\n" "Invalid input! Skipping..."
            return 2
        else
            continue
        fi
    done
}


## INTERFACE ##
# Import OS-specific packages
case "$detectOS" in
    'arch')
        # pacman and yay
        printf "\n%s\n%s\n" "Preparing to install packages..." \
            "======================"

        if getChoice "Contnue to install all the listed packages in \"./pkg_lists/arch-pkglist_native.txt\"? [Y/n] "
        then
            sudo pacman -Sy --needed - $(cat ./pkg_lists/pkglist_native.txt)
        fi
        if ! checkDep yay
        then
            printf "\n"
            if getChoice "Yay(AUR helper program) is missing from PATH. Install it? [Y/n] "
            then
                sudo pacman -S --needed git base-devel && \
                    git clone https://aur.archlinux.org/yay.git ~/yay \
                    && cd ~/yay && makepkg -si
            fi
        fi
        printf "\n"
        if getChoice "Install AUR packages from \"pkg_lists/pkglist_foreign.txt\"? [Y/n] "
        then
            yay -Sy - < ./pkg_lists/pkglist_foreign.txt
        fi
    ;;
    '"void"')
        # xbps
        printf "\n%s\n%s\n" "Preparing to install packages..." \
            "======================"

        if getChoice "Contnue to install all the listed packages in \"./pkg_lists/void-pkglist.txt\"? [Y/n] "
        then
            sudo xbps-install -S $(cat ./pkg_lists/void-pkglist.txt)
        fi
    ;;
esac

# Link configuration files
if ! checkDep stow
then
printf "%s\n%s\n" "GNU stow is missing from PATH!" \
    "Install stow to continue the process. Aborting..."
    exit 2
fi

# Array to contain group names
declare -a pkg_groups=(); declare -i i=0
for dir in ~/dwots/*/; do
    [[ -d "$dir" ]] || continue
    pkg_groups[$((i++))]="$(basename "$dir")"
done

# Check for -u(for unstow) flag.
# If provided, remove existing symlinks and exit
if getopts 'u' unstow_flag; then
    case "$unstow_flag" in
        'u')
            if getChoice "Delete symbolic links for ALL exisiting configuration files under ${XDG_CONFIG_HOME:?$HOME/.config}? [y/N] "
            then
                printf "%s\n" "Removing symlimks..."
                for group in "${pkg_groups[@]}"; do
                    if [[ "$group" = 'X11' || "$group" = user-dirs.dirs ]]; then
                        stow --delete --verbose */
                    else
                        declare -a group_childs=(); declare -i j=0
                        for child_dir in "${group}"/*/; do
                            [[ -d "$child_dir" ]] || continue
                            group_childs[$((j++))]="$(basename "$child_dir")"
                        done
                        for (( k = 0; k < "${#group_childs}"; k++ )); do
                            stow --dir="$group" --target="$HOME" --delete --verbose "${group_childs[$k]}"
                        done
                    fi
                done
                printf "%s\n" "Done!" ; exit
            else
                exit 2
            fi
        ;;
        *)
            printf "%s\n" "(use the \"-u\" flag for removing symlinks)"
            exit 2
        ;;
    esac
fi

printf "\n%s\n%s\n" "Preparing to link configuration files..." \
    "======================"
for group in "${pkg_groups[@]}"; do
    [[ ! -d "$group" || "$group" = 'pkg_lists' ]] && continue

    # don't take user input for these
    if [[ "$group" = 'X11' || "$group" = 'xdg-user-dirs' ]]
    then
        printf "\n%s\n" "Linking \"$group\" conf files..."
        stow --restow --verbose "$group"
        [[ "$group" = 'X11' ]] && printf "%s\n" \
            "(make sure the startup programs specified in xinitrc are installed on the system!)"
    # if the group contains only one pkg_dir
    elif [[ "$(find ./"${group}"/*/ -mindepth 1 -maxdepth 1 -type d | wc -l)" -eq 1 ]]
    then
        pkg_dir="$(basename "$group"/*/)"
        stowDir "$group" "$pkg_dir"
    else
        # if the group contains multiple pkg_dirs
        # $pkg_dirs is used for holding the name of the dirs with indexing
        declare -a pkg_dirs=()
        getDirs "$group" pkg_dirs 1
        printf "\n%s\n" "The \"${group}\" directory contains the following package directories: "
        printf "\t%s\n" "${pkg_dirs[@]}"

        read -t20 -r -p "Indexes of the directories to link (or a for all, n for none): " -a chosen_pkgs
        if [[ $? -ne 0 ]]
        then
            printf "\n%s\n" "Timeout! Aborting..."
            exit 2
        elif [[ "${#chosen_pkgs[@]}" -eq 0 ]]
        then
            printf "%s\n" "No input provided! Skipping..."
            continue
        fi
        # check for non-valid inputs
        cmprArrs chosen_pkgs[@] pkg_dirs[@]
        [[ $? -eq 2 ]] && continue

        stowMultiDirs "$group" chosen_pkgs[@]
        # resetting $pkg_dir is necessary,
        # otherwise it'll continue to hold elements from the preceding getDirs() call
        unset pkg_dirs
    fi
done

## END ##
printf "\n\n%s\n%s\n%s\n%s\n\n" "The installation routine has ended successfully." \
    "Verify whether the configuration files have been symlinked properly or not" \
    "with \`ls -l ~/.config\`" \
    "==============================================="
