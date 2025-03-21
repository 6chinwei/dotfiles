# Custom functions

# A command to follow curl redirection
function follow {
    curl -Lvs "$1" 2>&1 | grep -i 'Location: '
}
