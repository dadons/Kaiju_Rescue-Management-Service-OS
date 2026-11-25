# Kaiju Rescue & Management Service OS

Distro Linux kustom berbasis **Ubuntu 22.04** dengan desktop **XFCE** dan **LightDM**, bertema toolkit diagnostik dan pemulihan sistem (disk, data, dan jaringan).

> Proyek kelompok mata kuliah **Sistem Operasi (SO)**
> Dosen: **jeffry, S.Kom., M.T** · Kelompok Kaiju (10 anggota) · **Tahap 1 (minggu 1–2)**

---

##  Tentang Proyek

Kaiju disiapkan sebagai toolkit untuk:

- memeriksa kesehatan disk,
- memulihkan data,
- memantau sistem, dan
- menganalisis jaringan.

Pengguna sasarannya adalah teknisi, administrator sistem, dan mahasiswa yang mempelajari pemeliharaan sistem Linux.

Seluruh perubahan dilakukan lewat **skrip shell** dan **satu berkas daftar paket**, sehingga ISO dapat dibangun ulang dengan hasil yang konsisten.

##  Fitur Utama

| Fitur | Keterangan |
|-------|------------|
| Distro induk | Ubuntu 22.04 Desktop (jammy), amd64 |
| Alat pembangun | [Cubic](https://github.com/PJ-Singh-001/Cubic) (Custom Ubuntu ISO Creator) |
| Desktop | XFCE (ringan) dengan LightDM sebagai layar login |
| Branding | Wallpaper desktop & login, logo boot (Plymouth), logo menu Whisker |
| Paket dihapus | 13 entri paket yang tidak relevan |
| Paket dipasang | 24 entri (18 alat toolkit + 6 komponen desktop) |
| Bahasa | Bahasa Indonesia (`LANG=id_ID.UTF-8`) |
| Zona waktu | `Asia/Makassar` |
| First login | Skrip otomatis yang membuat laporan awal disk dan RAM |

##  Alat yang Disertakan

| Kategori | Paket |
|----------|-------|
| Disk dan penyimpanan | `smartmontools`, `hdparm`, `nvme-cli`, `gparted`, `ncdu` |
| Pemulihan data | `testdisk`, `gddrescue`, `fsarchiver` |
| Filesystem dan volume | `ntfs-3g`, `mdadm`, `lvm2`, `cryptsetup` |
| Diagnostik sistem | `htop`, `strace`, `lsof`, `memtester` |
| Jaringan | `tcpdump`, `nmap` |
| Desktop dan dukungan | `xfce4`, `xfce4-goodies`, `lightdm`, `lightdm-gtk-greeter`, `zenity`, `language-pack-id` |

##  Paket yang Dihapus

`libreoffice*`, `thunderbird*`, `rhythmbox*`, `transmission-*`, `remmina*`, `aisleriot`, `gnome-mahjongg`, `gnome-mines`, `gnome-sudoku`, `cheese*`, `shotwell*`, `totem*`, `simple-scan`

Alasannya: tidak relevan dengan tema toolkit pemulihan dan diagnostik, serta menghemat ukuran ISO.

##  Struktur Repositori

```
Kaiju_Rescue-Management-Service-OS/
├── README.md
└── Tahap-1/
    ├── packages.txt                  # daftar paket yang dipasang
    ├── assets/
    │   ├── wallpaper.png             # wallpaper desktop dan layar login
    │   └── logo.png                  # logo boot dan menu Whisker
    └── Script/
        ├── 01-persiapan-paket.sh     # hook zsys, repo universe, hapus & pasang paket
        ├── 02-desktop.sh             # XFCE dan LightDM sebagai login utama
        ├── 03-branding.sh            # wallpaper, logo boot, logo menu
        ├── 04-konfigurasi-bawaan.sh  # bahasa, zona waktu, pengguna awal, first login
        └── 05-verifikasi.sh          # pengecekan hasil dan update-initramfs
```

> Sesuaikan struktur di atas dengan isi folder sebenarnya di repositori.

##  Cara Membangun Ulang ISO

### Prasyarat

- Komputer/VM dengan Ubuntu dan [Cubic](https://github.com/PJ-Singh-001/Cubic) terpasang
- ISO **Ubuntu 22.04 Desktop (amd64)** asli
- Koneksi internet (untuk `apt` di dalam chroot Cubic)

### Langkah-langkah

1. **Clone repositori**
   ```bash
   git clone https://github.com/dadons/Kaiju_Rescue-Management-Service-OS.git
   cd Kaiju_Rescue-Management-Service-OS
   ```

2. **Buka Cubic**, pilih folder proyek baru, lalu pilih ISO Ubuntu 22.04 Desktop asli.

3. **Isi halaman Project:**
   - Custom Disk Name: `Kaiju 1.0`
   - Filename: `kaiju-1.0-amd64.iso`
   - Volume Label: `Kaiju 1.0`

4. **Salin folder `Tahap-1/` ke terminal Cubic** (tombol *Copy*), lalu salin aset ke `/root`:
   ```bash
   cp Tahap-1/assets/wallpaper.png /root/wallpaper.png
   cp Tahap-1/assets/logo.png /root/logo.png
   ```

5. **Jalankan skrip secara berurutan** di terminal Cubic:
   ```bash
   cd Tahap-1/Script
   chmod +x *.sh
   ./01-persiapan-paket.sh
   ./02-desktop.sh
   ./03-branding.sh
   ./04-konfigurasi-bawaan.sh
   ./05-verifikasi.sh
   ```
   `05-verifikasi.sh` menjalankan `update-initramfs -u -k all` satu kali di akhir agar logo boot ikut masuk ke image.

6. Klik **Next** sampai halaman *Packages*, biarkan centang bawaan Cubic.

7. Pilih kernel dan kompresi, lalu klik **Generate**. ISO tersimpan di folder proyek Cubic.

### Verifikasi hasil

```bash
ls -lh kaiju-1.0-amd64.iso
sha256sum kaiju-1.0-amd64.iso
```

##  Informasi ISO

| Item | Nilai |
|------|-------|
| Nama berkas | `kaiju-1.0-amd64.iso` |
| Ukuran | _isi dari `ls -lh`_ |
| Kompresi | _gzip / xz_ |
| Tanggal build | 20 November 2026 |
| SHA256 | _isi hasil `sha256sum`_ |

##  Pengujian di Mesin Virtual

ISO diuji di **VirtualBox** sampai berhasil boot live system, diinstal sampai selesai, dan boot dari disk.

| Parameter | Nilai |
|-----------|-------|
| Nama VM | KJL |
| RAM | 4096 MB |
| CPU | 2 prosesor |
| Disk virtual | 25 GB (`KJL.vdi`, format VDI) |
| Memori video | 128 MB (VMSVGA) |
| Jaringan | NAT |
| Akselerasi | Nested Paging, KVM Paravirtualization |

##  Kendala dan Solusi

| Kendala | Solusi |
|---------|--------|
| Paket tidak ditemukan saat `apt install` karena repositori universe belum aktif | Aktifkan repositori `universe` di awal skrip |
| Pesan galat `zsys` akibat hook snapshot tidak berjalan di chroot Cubic | Nonaktifkan hook zsys (`rm -f /etc/apt/apt.conf.d/90_zsys_system_autosnapshot`) |
| Berkas aset tidak terbaca karena path pada skrip build salah | Perbaiki path relatif pada skrip |

##  Anggota Kelompok

| No | Nama | NIM | Paket Kerja |
|----|------|-----|-------------|
| 1 | Reva Nurul Syahlita Kamal Miftah | 251011088 | Pemilihan distro induk dan alat pembangun |
| 2 | Siti Nurzas Lina | 251011142 | Penghapusan paket dan pencatatan alasan |
| 3 | Farel Dava Prasetya | 251011111 | Pemilihan dan pemasangan paket toolkit |
| 4 | Rieva Tri Putra Adi Rangga | 251011112 | Desktop XFCE dan LightDM |
| 5 | Andi Munajat | 251011137 | Wallpaper desktop dan layar login |
| 6 | Dirham Dwi Yulianto Fereira | 251011081 | Logo layar boot (Plymouth) |
| 7 | Vidia Fatimah | 251011056 | Logo menu Whisker dan verifikasi hasil |
| 8 | Achmad Jayadi | 251011003 | Konfigurasi bahasa, zona waktu, dan pengguna awal |
| 9 | A Astri Cindy Manchetti | 251011101 | Skrip first login |
| 10 | Muhammad Idris | 251011091 | Build ISO, pengujian VM, dan pengelolaan repositori |

##  Status Tahap 1

- [x] Pilih distro induk (Ubuntu) dan alat pembangun (Cubic)
- [x] Hapus paket tidak perlu dan pasang minimal 10 paket relevan
- [x] Desktop ringan, wallpaper, logo, dan nama distro (branding)
- [x] Konfigurasi bawaan: bahasa, zona waktu, pengguna awal, skrip first login
- [x] Hasilkan ISO dan uji di VM (instalasi dan boot dari disk)
- [x] Simpan konfigurasi dan skrip di repositori

##  Lisensi

Proyek ini dibuat untuk keperluan pembelajaran mata kuliah Sistem Operasi. Paket-paket yang disertakan mengikuti lisensi masing-masing.
