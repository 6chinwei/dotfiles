# Do not show zsh warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Check whether command exists
function command_exists {
  type $1 > /dev/null 2>&1
}

# Add Homebrew to PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew bash completion
if command_exists brew
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

# Alias
alias grep='grep --color=auto'
alias cl='clear'
alias brew='HOMEBREW_NO_AUTO_UPDATE=1 brew' # Don't update Homebrew before installing

# Replace `ls` with `eza` if it exists
if command_exists eza; then
  alias ls='env EZA_COLORS="ur=35:uw=35:ux=35:ue=35:gr=35:gw=35:gx=35:tr=35:tw=35:tx=35" eza --header --group --time-style=long-iso'
else 
  echo "'eza' is not installed. Recommend to install it by Homebrew"
fi

# Replace `cat` with `bat`  if it exists
if command_exists bat; then
  alias cat='bat'
else 
  echo "'bat' is not installed. Recommend to install it by Homebrew"
fi

# Git auto completion
[[ -f "$HOME/.git-completion.bash" ]] && source "$HOME/.git-completion.bash"

# Prompt config
[[ -f "$HOME/.prompt_config" ]] && source "$HOME/.prompt_config"

# Custom functions
[[ -f "$HOME/.functions" ]] && source "$HOME/.functions"

# SSH Agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

ssh-add -l | grep "The agent has no identities" && echo "Adding SSH Agent..." \
  && ssh-add --apple-use-keychain ~/.ssh/6chinwei_github

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# History settings
# Use standard ISO 8601 timestamp: %Y-%m-%d %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '
# Ignore duplicates
export HISTCONTROL="ignoredups"
# Ignore commands that start with a space
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
# Extend history size
export HISTSIZE=100000 
export HISTFILESIZE=$HISTSIZE
# Sync history between multiple terminals
# Save and reload the history after each command finishes
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

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
