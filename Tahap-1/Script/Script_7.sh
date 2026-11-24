# --- Pasang logo di tombol menu XFCE (Whisker) ---
cp /root/logo.png /usr/share/pixmaps/kaiju-logo.png
mkdir -p /etc/xdg/xfce4/panel
echo "button-icon=/usr/share/pixmaps/kaiju-logo.png" > /etc/xdg/xfce4/panel/whiskermenu-1.rc
