# --- Salin wallpaper ke semua lokasi yang dipakai XFCE ---
mkdir -p /usr/share/backgrounds/xfce /usr/share/xfce4/backdrops
for f in /usr/share/backgrounds/wallpaper.png \
         /usr/share/backgrounds/warty-final-ubuntu.png \
         /usr/share/backgrounds/xfce/xfce-verticals.png \
         /usr/share/xfce4/backdrops/xfce-verticals.png; do
  cp /root/wallpaper.png "$f" && chmod 644 "$f"
done
