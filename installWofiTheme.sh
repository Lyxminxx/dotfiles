#!/bin/bash
git clone https://github.com/dracula/wofi.git
mkdir .config/wofi/
mv wofi/style.css .config/wofi
rm -rf wofi
echo Finished installing wofi theme!