wget -O /tmp/aptos.zip https://download.microsoft.com/download/8/6/0/860a94fa-7feb-44ef-ac79-c072d9113d69/Microsoft%20Aptos%20Fonts.zip 
mdkir /tmp/aptos
unzip /tmp/aptos.zip -d /tmp/aptos
sudo cp /tmp/aptos/*.ttf /usr/local/share/fonts
fc-cache -vr