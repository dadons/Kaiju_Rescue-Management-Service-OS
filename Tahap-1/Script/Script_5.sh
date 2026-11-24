# --- Atur wallpaper layar login ---
cat > /etc/lightdm/lightdm-gtk-greeter.conf << 'EOF'
[greeter]
background=/usr/share/backgrounds/wallpaper.png
EOF
