#!/usr/bin/env bash

# script to provide an easy to deploy interface
# when migrating the files from my dotfiles directory dwots
# with GNU Stow

# Array to contain group names #
declare -a pkg_groups=( $(ls -d ./*/ | tr -d './') )

## Function to call when there's only one pkg_dir inside a group ##
function stowDir() {
    printf "\n%s\n" "The \"${1}\" directory contains the package directory for \"${2}\"."
    read -p "Do you want to stow it?(yes/no) "  usr_inpt
    if [[ ! "${usr_inpt}" =~ ^y$|^yes$  ]]
    then
        printf "%s\n" "Skipped"
    else
        printf "%s\n" "Stowing files for \"${2}\"..."
        stow --dir="${1}" --target="$HOME" --no --verbose "${2}"
    fi
}

## Function to call when there's multiple pkg_dirs inside a group ##
# The first argument is the name of the group
# The second argument is the array containing indexes of the directories to be stowed
function stowMultiDirs() {
    usr_arr=("${!2}")
    # check whether the second argument is 'a(all)' or 'n(none)' 
    if [[ "${#usr_arr[*]}" -eq 1 && "${usr_arr[*]}" = 'n' ]]
    then
        printf "%s\n" "Skipped" && return
    elif [[ "${#usr_arr[*]}" -eq 1 && "${usr_arr[*]}" = 'a' ]]
    then
        read -p "Do you want to stow every directory under \"${1}\"?(yes/no) " usr_inpt
        if [[ ! "${usr_inpt}" =~ ^y$|^yes$  ]]
        then
            # TODO: needs improvement(if possible)
            printf "%s\n" "Aborted" && return
        else
            printf "%s\n" "Stowing directories..."
            stow --dir="${1}" --no --verbose */
            return
        fi
    fi
    declare -a sub_pkg_dirs
    # store indexed directory names under $1 inside $sub_pkg_dirs
    getDirs "$1" sub_pkg_dirs
    # compare indexes from usr_arr with indexes from sub_pkg_dir
    # and stow the successive dirs if they match
    for dir in "${sub_pkg_dirs[@]}"; do
        for index in "${usr_arr[@]}"; do
            if [[ $index -eq ${dir::1} ]]; then
                printf "%s\n" "Stowing files for ${dir:2}..."
                stow --dir="${1}" --target="$HOME" --no --verbose "${dir:2}"
            else
                continue
            fi
        done
    done
}

## Function to store pkg_dirs in a sub array ##
# The first argument is the name of the group directory
# the second argument(used as a namref) is where the sub-array is stored
function getDirs() {
    declare -n dir_list=$2
    declare -i i=0
    for dir in ./${1}/*; do
        for (( ; i < "$(ls "${1}" | wc -l)"; i++ )); do
            [ -d "$dir" ] || continue
            dir_list[${i}]="$(printf "%d %s\n" "$((i+1))" "${dir#\./*/}")"
            i+=1
            break
        done
    done
}

## Function for comparing two arrays ##
# The first argument is the user provided array of indexes for the chosen pkg directories
# The second argument is the array of indexes for the pkg directories
# Return error if any element from first array
# excedes the total number of elements in second array
function cmprArrs() {
    param01=("${!1}")
    param02=("${!2}")
    for (( i=0; i < "${#param01[@]}"; i++)); do
        if [[ "${param01[i]}" -gt "${#param02[*]}" ]]
        then
            printf "%s\n%s\n\n" "Invalid input!" "Skipping..."
            return 2
        else
            continue
        fi
    done
}

## Actual loop to cycle through the pkg_groups ##
for group in "${pkg_groups[@]}"; do
    if [[ "$group" = 'pkg_lists' ]]; then continue

    # don't take user input for these
    elif [[ "$group" = 'X11' || "$group" = 'xdg-user-dirs' ]]
    then
        printf "%s\n" "stowing "$group" conf files..."
        stow --no --verbose "$group"
    # if the group contains only one pkg_dir
    elif [[ "$(ls ${group} | wc -l)" -eq 1 ]]
    then
        pkg_dir="$(ls "$group")"
        stowDir "$group" "$pkg_dir"
    else
        # if the group contains multiple pkg_dirs
        # $pkg_dirs is used for holding the name of the dirs with indexing
        declare -a pkg_dirs
        getDirs "$group" pkg_dirs
        printf "\n%s\n" "The \"${group}\" directory contains the following package directories: "
        printf "\t%s\n" "${pkg_dirs[@]}"

        read -p "Indexes of the directories to stow(or a for all, n for none): " -a choice_two
        # check for non-valid inputs
        cmprArrs choice_two[@] pkg_dirs[@]
        [[ $? -eq 2 ]] && continue

        stowMultiDirs "$group" choice_two[@]
        # resetting $pkg_dir is necessary,
        # otherwise it'll continue to hold elements from the preceding getDirs() call
        unset pkg_dirs
    fi
done

printf "\n\n%s\n%s\n%s\n%s\n\n" "The setup has ended successfully." \
    "Verify whether the configuration files have been symlinked properly or not" \
    "with \`ls -l ~/.config\`" \
    "==============================================="
