# --- Hapus paket tidak perlu (tanpa autoremove agar installer aman) ---
apt purge -y 'libreoffice*' 'thunderbird*' 'rhythmbox*' 'transmission-*' \
  'remmina*' 'aisleriot' 'gnome-mahjongg' 'gnome-mines' 'gnome-sudoku' \
  'cheese*' 'shotwell*' 'totem*' 'simple-scan' || true

# --- Pasang paket dari packages.txt ---
echo "lightdm shared/default-x-display-manager select lightdm" | debconf-set-selections
apt install -y $(sed 's/#.*//' tahap1/packages.txt | xargs)
echo /usr/sbin/lightdm > /etc/X11/default-display-manager
