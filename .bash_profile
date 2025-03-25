# Do not show zsh warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Check whether command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Add Homebrew to PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew bash completion
if command_exists brew; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

# Replace `ls` with `eza` if it exists
if command_exists eza; then
  alias ls='env EZA_COLORS="ur=35:uw=35:ux=35:ue=35:gr=35:gw=35:gx=35:tr=35:tw=35:tx=35" eza --header --group --time-style=long-iso --group-directories-first --sort=extension'
else 
  echo "'eza' is not installed. Recommend installing it via Homebrew" >&2
fi

# Replace `cat` with `bat` if it exists
if command_exists bat; then
  alias cat='bat'
else 
  echo "'bat' is not installed. Recommend installing it via Homebrew" >&2
fi

# Git auto completion
[[ -r "$HOME/.git_completion.bash" ]] && source "$HOME/.git_completion.bash"

# Prompt config
[[ -r "$HOME/.prompt_config.bash" ]] && source "$HOME/.prompt_config.bash"

# Custom functions
[[ -r "$HOME/.functions.bash" ]] && source "$HOME/.functions.bash"

# SSH Agent
[[ -f "$HOME/.ssh_agent.bash" ]] && source "$HOME/.ssh_agent.bash"

# Alias
[[ -r "$HOME/.alias.bash" ]] && source "$HOME/.alias.bash"

# NVM
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"  # Load nvm
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"  # Load nvm bash_completion

# History settings
# Use standard ISO 8601 timestamp: %Y-%m-%d %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '
# Ignore duplicates and remove older duplicates
export HISTCONTROL="ignoredups"
# Ignore commands that start with a space
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
# Extend history size
export HISTSIZE=100000 
export HISTFILESIZE=$HISTSIZE
# Sync history between multiple terminals
# Save and reload the history after each command finishes
# shopt -s histappend
# export PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"

# Composer global vendor
# export PATH="$PATH:$HOME/.composer/vendor/bin"

# 延長 AWS MFA TTL
# export AWS_ASSUME_ROLE_TTL=8h
# export AWS_SESSION_TOKEN_TTL=8h

# Bun
# export BUN_INSTALL="$HOME/.bun"
# export PATH=$BUN_INSTALL/bin:$PATH

# Crowdin
# export PATH="/opt/homebrew/opt/crowdin@3/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

