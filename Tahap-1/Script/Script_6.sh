# --- Pasang logo di layar boot (Plymouth) ---
for f in /usr/share/plymouth/ubuntu-logo.png \
         /usr/share/plymouth/themes/spinner/watermark.png \
         /usr/share/plymouth/themes/spinner/bgrt-fallback.png \
         /usr/share/plymouth/themes/bgrt/watermark.png; do
  cp /root/logo.png "$f" && chmod 644 "$f"
done
update-alternatives --set default.plymouth /usr/share/plymouth/themes/spinner/spinner.plymouth
