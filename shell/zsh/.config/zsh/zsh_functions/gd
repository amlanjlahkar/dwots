# Function to go up n directories.
function gd () {
    declare godir; declare limit="$1"
    [ "$limit" = 'top' ] && cd "${HOME}/$(pwd | cut -d'/' -f4)"
    [[ -z "$limit" || "$limit" -le 0 ]] && limit=1

    for (( i=1; i < limit; i++ )); do
        godir="../$godir"
    done

    if ! cd "$godir"; then
        printf "%s\n" "Couldn't go up \"$limit\" directories."
    fi
}
