echo Setup script!

echo Getting nerd font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
unzip FiraCode.zip
rm FiraCode.zip
fc-cache -fv

echo Getting wallpaper
mkdir ~/Pictures
wget -O ~/Pictures/wall.png  https://gruvbox-wallpapers.pages.dev/thumbnails/anime/5m5kLI9.png 

echo Installing lsps
go install golang.org/x/tools/gopls@latest
sudo npm install -g vscode-langservers-extracted \
    typescript-language-server \
    typescript \
    bash-language-server \
    prettier
pipx install "python-lsp-server[all]"
pipx install django-template-lsp

go install mvdan.cc/sh/v3/cmd/shfmt@latest

fish_add_path ~/go/bin
fish_add_path ~/.local/bin

echo Stow
stow cosmic
stow nvim
stow fish
stow helix
