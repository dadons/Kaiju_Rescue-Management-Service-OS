# --- Pasang desktop XFCE dan lightdm (tampilan ringan) ---
echo "lightdm shared/default-x-display-manager select lightdm" | debconf-set-selections
apt-get install -y xfce4 xfce4-goodies xfce4-terminal xfce4-whiskermenu-plugin \
  thunar-archive-plugin lightdm lightdm-gtk-greeter xorg dbus-x11 \
  network-manager-gnome gvfs-backends plymouth plymouth-themes zenity language-pack-id

# --- Jadikan lightdm login screen utama dengan sesi XFCE ---
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
