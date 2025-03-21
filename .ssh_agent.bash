#!/bin/bash

# 確保 SSH Agent 在運行
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

# 檢查 SSH Agent 是否已經有 Key，若無則添加
ssh-add -l >/dev/null 2>&1 || { 
    echo "Adding SSH keys to agent..."
    
    ssh-add --apple-use-keychain ~/.ssh/6chinwei_github

    # Add more keys here ...
}
