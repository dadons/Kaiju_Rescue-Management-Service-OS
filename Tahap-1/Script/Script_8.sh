# --- Cek hasil: sesi XFCE, wallpaper, dan file logo ada ---
grep user-session /etc/lightdm/lightdm.conf.d/50-kaiju.conf
grep wallpaper.png /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
ls -lh /usr/share/backgrounds/wallpaper.png /usr/share/plymouth/themes/spinner/watermark.png

# --- Bangun ulang initramfs agar logo boot ikut masuk (cukup sekali) ---
update-initramfs -u -k all
