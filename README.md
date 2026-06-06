# 🎮 Secret Room Test

> Server FiveM Indonesia untuk testing dan bersenang-senang.

![FiveM](https://img.shields.io/badge/FiveM-Server-orange?style=for-the-badge)
![GTA V](https://img.shields.io/badge/GTA%20V-Build%202699-blue?style=for-the-badge)
![OneSync](https://img.shields.io/badge/OneSync-Enabled-green?style=for-the-badge)
![Players](https://img.shields.io/badge/Max%20Players-48-red?style=for-the-badge)

---

## 📋 Informasi Server

| Item | Detail |
|------|--------|
| Nama Server | Secret Room Test |
| Game Build | 2699 |
| vMenu | v3.5.0 |
| Max Players | 48 |
| OneSync | Aktif |
| Bahasa | Indonesia |
| Artifact | Latest (Daily Updated) |

---

## 🔥 Fitur Custom

### 🔫 Player Loadout
- Semua senjata GTA V otomatis diberikan saat spawn
- Unlimited ammo & unlimited clip (tidak pernah habis)
- Senjata kembali otomatis setelah mati dan respawn
- Efek visual & suara saat menerima senjata
- Command `/loadout` untuk ambil ulang manual

### 😈 Angry NPCs (Rage Mode)
- NPC langsung marah dan menyerang saat disenggol, dipukul, atau ditabrak
- NPC mengeluarkan senjata api secara random (pistol, SMG, rifle, RPG, minigun, dll)
- Sistem tier senjata: makin sial, makin ganas senjata NPC
- Chain reaction: NPC bisa memanggil NPC lain untuk ikut menyerang
- NPC react terhadap tembakan di sekitarnya
- Wanted level otomatis dihilangkan (murni NPC vs Player)
- Command `/rageall` untuk bikin semua NPC sekitar marah
- Command `/ragereset` untuk menenangkan semua NPC

---

## 📂 Struktur Resource

```
resources/
├── vMenu/                    → Admin menu & trainer (v3.5.0)
├── [local]/
│   ├── player-loadout/       → Semua senjata + unlimited ammo
│   └── angry-npcs/           → NPC marah bersenjata
├── [gamemodes]/
│   ├── basic-gamemode/       → Freeroam
│   └── [maps]/               → Spawn maps
├── [gameplay]/
│   ├── chat/                 → Sistem chat
│   ├── player-data/          → Database pemain
│   └── playernames/          → Nametag overhead
├── [managers]/
│   ├── mapmanager/           → Manajemen map
│   └── spawnmanager/         → Manajemen spawn
└── [system]/                 → System resources
```

---

## ⚡ Commands

| Command | Fungsi |
|---------|--------|
| `/loadout` | Ambil semua senjata + unlimited ammo |
| `/rageall` | Bikin semua NPC di sekitar marah |
| `/ragereset` | Reset semua NPC jadi normal |

---

## 🚀 Cara Install

1. Download atau clone repository ini
2. Masukkan license key di `server.cfg`
   ```
   sv_licenseKey "YOUR_KEY_HERE"
   ```
3. Jalankan server dengan artifact FiveM terbaru
4. Connect ke `localhost:30120`

---

## ⚙️ Konfigurasi

- **server.cfg** — Konfigurasi utama server
- **resources/vMenu/config/permissions.cfg** — Permission vMenu & admin setup
- **resources/vMenu/config/addons.json** — Addon vehicles/peds/weapons
- **resources/vMenu/config/locations.json** — Teleport locations

---

## 📝 Notes

- vMenu terbuka untuk semua player (permission mode off)
- ScriptHook dinonaktifkan untuk keamanan
- Server menggunakan mode LAN secara default
- Ubah `sv_lan 0` dan hapus `sv_master1 ""` untuk server publik

---

## 📜 License

Project ini untuk keperluan testing pribadi.
