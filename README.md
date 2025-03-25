# dotfiles

參考 [paulirish/dotfiles](https://github.com/paulirish/dotfiles)，建立我自己 macOS 開發環境常用的 Bash 環境與各種設定檔

## Usage
1. 安裝 [Homebrew](https://brew.sh/)
1. 把預設 Shell 改為 Bash（[Ref](https://stackoverflow.com/questions/77052638/changing-default-shell-from-zsh-to-bash-on-macos-catalina-and-beyond)）
   1. 安裝最新版 Bash
      ```sh
      $ brew install bash
      ```
   2. 把 `/opt/homebrew/bin/bash` 加到 `/etc/shells` 的最上方
      ```sh
      $ sudo vim /etc/shells
      ```
   3. 把預設 Shell 設定為剛安裝的 Bash
      ```sh   
      $ chsh -s /opt/homebrew/bin/bash
      ```
1. 安裝 [bat](https://github.com/sharkdp/bat) 和 [eza](https://github.com/eza-community/eza)
   ```sh
   $ brew install bat eza
   ```
1. 執行 `setup-symlink.sh`，會自動檢查與建立各檔案的 Symbolic Link 到家目錄
   ```sh
   $ ./setup-symlink.sh
   ```
1. 開啟新的 Terminal 視窗即可套用設定

## Customization
1. 複製 `~/.gitconfig.local`，並修改為為本機的 Git User 資訊
   ```sh
   $ cp .gitconfig.local.example ~/.gitconfig.local
   ```
   如果有多個 Git User 想根據資料夾分開設定，可參考註解使用 `[includeIf]`
1. 建立 SSH Key，並把 SSH Key 路徑寫入 `~/.ssh_agent.bash` 的
   ```sh
   $ ssh-add --apple-use-keychain ~/.ssh/6chinwei_github

   # Add more keys here ...
   ```
1. 複製 `~/.ssh/config`，並根據需求調整內容
   ```sh
   $ cp .ssh/config.example ~/.ssh/config
   ```
