<div align="center">
  <h1>Flutter Kicks & Chatbot Dashboard</h1>
  <p><strong>A Modern Mobile App UTS Project</strong></p>
</div>

---

## Tentang Projek
Aplikasi ini adalah project Ujian Tengah Semester (UTS) untuk mata kuliah **Advance Mobile Programming**. Proyek ini merupakan *mockup* dashboard e-commerce sepatu yang dilengkapi dengan fitur **Autentikasi (Login & Register) berbasis Local Database** menggunakan Hive, serta integrasi **Smart Chatbot** yang interaktif. 

Aplikasi ini menonjolkan desain UI/UX yang modern, bersih, serta menggunakan animasi transisi yang halus untuk meningkatkan interaktivitas dan kenyamanan pengguna.

## Fitur Utama
1. **Sistem Autentikasi Modern (Login & Register)**
   - Form pendaftaran yang interaktif dan responsif.
   - Menggunakan `hive_flutter` untuk penyimpanan data secara lokal tanpa perlu konfigurasi database eksternal. Mendukung web, Android, dan iOS.
   - Validasi login yang aman dan pengecekan duplikasi email saat mendaftar.
2. **Dashboard E-Commerce Keren**
   - Menampilkan katalog produk sepatu dengan desain *card* yang dinamis menggunakan *high-quality image assets* dari Unsplash.
   - Dilengkapi dengan animasi *FadeIn* elegan menggunakan library `animate_do`.
3. **Integrasi Smart Chatbot**
   - *Floating Action Button* pada dashboard untuk akses cepat ke layanan Chatbot.
   - UI Chatbot bergaya modern dengan *bubble chat* yang rapi untuk simulasi interaksi AI yang responsif.
4. **Halaman Profil Terpersonalisasi**
   - Desain layout profil bersih dan minimalis yang menampilkan informasi user yang sedang aktif.

## Teknologi yang Digunakan
- **[Flutter](https://flutter.dev/)** - Framework UI lintas platform (SDK >=3.1.3).
- **[Dart](https://dart.dev/)** - Bahasa pemrograman.
- **[Hive Flutter](https://pub.dev/packages/hive_flutter)** - NoSQL Database lokal super cepat, efisien, dan *cross-platform*.
- **[Animate Do](https://pub.dev/packages/animate_do)** - Library untuk mempermudah animasi *fade in, slide, bounce*, dll.
- **[Simple Icons](https://pub.dev/packages/simple_icons) & Cupertino Icons** - Icon pack modern dan elegan.


## Struktur Folder Utama
```text
lib/
 ├── chatbot_screen.dart   # UI & Logika Chatbot Interaktif
 ├── dashboard.dart        # Halaman Utama Katalog Produk (Home)
 ├── database_helper.dart  # Konfigurasi & CRUD Hive Database
 ├── main.dart             # Entry Point & Halaman Login Auth
 ├── profilears.dart       # Halaman Profil Pengguna
 └── register.dart         # Halaman Pendaftaran Akun Baru
```

## Cara Menjalankan Project (Getting Started)
1. **Clone repository ini**
   ```bash
   git clone <repo-url>
   ```
2. **Masuk ke folder project**
   ```bash
   cd flutter-chatbot-uts
   ```
3. **Install semua dependencies**
   ```bash
   flutter pub get
   ```
4. **Jalankan aplikasi (Emulator / Real Device / Web)**
   ```bash
   flutter run
   ```

## Akun Default (Testing)
Jika database *Hive* masih kosong pada saat pertama kali dijalankan, sistem secara otomatis akan me-*seed* akun admin berikut untuk keperluan testing:
- **Email:** `admin@sepatu.com`
- **Password:** `admin123`
## Manajemen Proyek dengan Scrum & ClickUp

Proyek ini mengadopsi metodologi **Scrum** untuk manajemen pengembangan secara *agile*, dan menggunakan **ClickUp** sebagai *tools* utama untuk melacak *progress* (kemajuan) tugas. Berikut adalah langkah-langkah implementasinya:

### 1. Setup Workspace & Space di ClickUp
- Buat akun atau login ke [ClickUp](https://clickup.com/).
- Buat **Workspace** baru (misal: `UTS Project Workspace`).
- Di dalam Workspace, buat **Space** khusus untuk proyek ini (misal: `Flutter Kicks & Chatbot`).

### 2. Menyusun Product Backlog (Daftar Tugas Utama)
- Buat *List* baru dengan nama **"Product Backlog"** di dalam Space.
- Pecah kebutuhan proyek menjadi tugas-tugas kecil (*Task* / *User Story*). Contoh Backlog:
  - Setup UI Login & Register
  - Implementasi Hive Database untuk Auth
  - Desain Dashboard & Katalog Sepatu
  - Integrasi UI Chatbot
  - Halaman Profil Pengguna
- Beri prioritas pada masing-masing tugas (*Urgent*, *High*, *Normal*, *Low*).

### 3. Sprint Planning (Perencanaan Sprint)
- Tentukan durasi Sprint (misal: 1 minggu atau 2 minggu).
- Buat *List* atau *Folder* Sprint baru (misal: **"Sprint 1"**).
- Pindahkan tugas-tugas prioritas tinggi dari *Product Backlog* ke *Sprint 1*.
- Assign anggota tim (jika bekerja dalam tim) atau diri sendiri untuk mengerjakan tugas tersebut.
- Tetapkan *Due Date* (tenggat waktu) dan *Time Estimate* (estimasi waktu pengerjaan) untuk setiap tugas.

### 4. Membuat Kanban Board (Sprint Backlog)
- Di dalam tampilan Sprint 1, gunakan *view* **Board** (Kanban).
- Sesuaikan kolom *Status* tugas, umumnya menggunakan:
  - **To Do** (Belum Dikerjakan)
  - **In Progress** (Sedang Dikerjakan)
  - **Review / Testing** (Sedang Diuji Coba)
  - **Done** (Selesai)

### 5. Daily Scrum (Pelaksanaan Harian)
- Setiap hari (jika dalam tim) atau secara mandiri, lakukan *update* pada Kanban Board.
- Pindahkan *card* tugas dari "To Do" ke "In Progress" saat mulai mengerjakan, lalu ke "Done" jika sudah rampung tanpa error.
- Gunakan fitur *comments* atau *subtasks* di ClickUp untuk mencatat kendala (misal: *bug* saat integrasi Hive) dan *to-do list* harian.

### 6. Sprint Review & Retrospective
- Di akhir Sprint, evaluasi apakah semua tugas di "Sprint 1" telah berada di status **Done**.
- Catat apa saja yang berjalan baik, kendala yang dihadapi, dan apa yang bisa diperbaiki untuk Sprint selanjutnya (*Sprint Retrospective*).

---
*Dibuat untuk keperluan Ujian Tengah Semester dengan dedikasi pada pengembangan UI/UX dan arsitektur data lokal (CRUD) yang solid.*
