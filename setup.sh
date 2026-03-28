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

echo Stow
stow cosmic
stow nvim
