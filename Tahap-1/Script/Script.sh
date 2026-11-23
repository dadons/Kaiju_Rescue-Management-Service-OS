# Matikan hook zsys (sumber pesan error zsys), aktifkan repo universe
rm -f /etc/apt/apt.conf.d/90_zsys_system_autosnapshot
apt-get update
apt-get install -y software-properties-common
add-apt-repository -y universe
apt-get update

# Hapus paket tidak perlu (tanpa autoremove agar installer aman)
apt purge -y 'libreoffice*' 'thunderbird*' 'rhythmbox*' 'transmission-*' \
  'remmina*' 'aisleriot' 'gnome-mahjongg' 'gnome-mines' 'gnome-sudoku' \
  'cheese*' 'shotwell*' 'totem*' 'simple-scan' || true

# Pasang paket dari packages.txt
echo "lightdm shared/default-x-display-manager select lightdm" | debconf-set-selections
apt install -y $(sed 's/#.*//' tahap1/packages.txt | xargs)
echo /usr/sbin/lightdm > /etc/X11/default-display-manager

# Display manager: lightdm + sesi XFCE
echo /usr/sbin/lightdm > /etc/X11/default-display-manager
systemctl disable gdm3 2>/dev/null || true
systemctl enable lightdm
rm -f /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.d/10-autologin.conf
mkdir -p /etc/lightdm/lightdm.conf.d
cat > /etc/lightdm/lightdm.conf.d/50-kaiju.conf << 'EOF'
[Seat:*]
greeter-session=lightdm-gtk-greeter
user-session=xfce
EOF
