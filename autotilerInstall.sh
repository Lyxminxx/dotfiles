#!/bin/bash
curl -L -o ~/autotiling.py https://raw.githubusercontent.com/nwg-piotr/autotiling/refs/heads/master/autotiling/main.py 
mv ~/autotiling.py ~/autotiling
chmod +x ~/autotiling
sudo mv ~/autotiling /usr/local/bin/
