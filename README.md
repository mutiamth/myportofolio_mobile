### Tugas 7

#### 1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter!

Widget tree adalah struktur hierarki yang menggambarkan susunan dan hubungan antar-widget dalam aplikasi Flutter. Dalam struktur ini, terdapat parent sebagai widget yang memiliki widget lain di dalamnya (child). Satu parent dapat memiliki satu atau beberapa child, bergantung pada jenis widget yang digunakan.

Pada proyek ini, `MaterialApp` menjadi root widget yang menampilkan `MyHomePage`. Selanjutnya, `MyHomePage` menggunakan `Scaffold` untuk menyusun tampilan halaman.

#### 2. Sebutkan semua widget yang digunakan dalam proyek ini dan jelaskan fungsinya!

Widget yang digunakan dalam proyek ini antara lain:

- `MaterialApp`: Mengatur konfigurasi utama aplikasi, seperti tema dan halaman utama.
- `Scaffold`: Menyediakan struktur dasar halaman aplikasi.
- `AppBar`: Menampilkan bilah judul di bagian atas aplikasi.
- `Text`: Menampilkan teks, seperti judul, informasi profil, dan nama tombol.
- `Padding`: Memberikan jarak di sekitar widget.
- `Column` dan `Row`: Menyusun widget secara vertikal dan horizontal.
- `Card`: Menampilkan informasi dalam bentuk kartu.
- `Container`: Mengatur tampilan, ukuran, warna, dan tata letak widget.
- `SizedBox`: Memberikan ruang atau jarak dengan ukuran tertentu.
- `Center`: Menempatkan widget di tengah area yang tersedia.
- `GridView.count`: Menampilkan beberapa widget dalam susunan grid dengan jumlah kolom tertentu.
- `Material`: Menyediakan permukaan dengan warna dan bentuk tertentu.
- `InkWell`: Menambahkan interaksi ketika widget ditekan.
- `Icon`: Menampilkan ikon pada tombol aksi.
- `SnackBar`: Menampilkan pesan sementara setelah tombol ditekan.

Selain widget bawaan Flutter, proyek ini juga menggunakan custom widget, yaitu `InfoCard` untuk menampilkan informasi profil dan `ItemCard` untuk menampilkan tombol aksi.

#### 3. Apa fungsi dari `MaterialApp`? Mengapa widget ini sering digunakan sebagai root widget?

`MaterialApp` merupakan widget yang menyediakan konfigurasi dasar aplikasi Flutter dengan desain Material Design, seperti tema, navigasi, dan halaman utama. Widget ini sering digunakan sebagai root widget karena menjadi titik awal struktur aplikasi, sehingga widget lain dapat menggunakan konfigurasi dan fitur yang disediakannya.

#### 4. Apa perbedaan antara `StatelessWidget` dan `StatefulWidget`? Kapan sebaiknya menggunakan masing-masing widget tersebut?

`StatelessWidget` adalah widget yang tidak memiliki state internal yang berubah selama penggunaannya, sehingga cocok untuk tampilan yang relatif tetap. Sementara itu, `StatefulWidget` memiliki state yang dapat berubah dan menyebabkan tampilan diperbarui, misalnya ketika pengguna melakukan suatu interaksi. Oleh karena itu, `StatelessWidget` digunakan untuk tampilan yang tidak membutuhkan perubahan state, sedangkan `StatefulWidget` digunakan ketika tampilan perlu merespons perubahan data atau interaksi pengguna.

Pada proyek ini, `MyHomePage`, `InfoCard`, dan `ItemCard` menggunakan `StatelessWidget` karena tidak memerlukan pengelolaan state internal.

#### 5. Apa yang dimaksud dengan `BuildContext` dan mengapa penting dalam metode `build`?

`BuildContext` adalah objek yang menyimpan informasi mengenai posisi suatu widget dalam widget tree. Objek ini penting karena memungkinkan widget mengakses informasi atau layanan dari widget lain yang berada di atasnya dalam hierarki. Pada proyek ini, `BuildContext` digunakan oleh `ItemCard` untuk mengakses `ScaffoldMessenger` dan menampilkan `SnackBar` ketika tombol ditekan.

#### 6. Apa perbedaan antara hot reload dan hot restart dalam Flutter? Kapan sebaiknya menggunakan masing-masing fitur tersebut?

**Hot reload** menerapkan perubahan kode ke aplikasi yang sedang berjalan tanpa menginisialisasi ulang seluruh aplikasi, sehingga state yang sedang aktif umumnya tetap dipertahankan. Fitur ini cocok untuk melihat perubahan tampilan atau kode selama pengembangan.

Sementara itu, **hot restart** memulai ulang aplikasi dari awal sehingga state aplikasi diinisialisasi kembali. Fitur ini digunakan ketika perubahan kode membutuhkan proses inisialisasi ulang, misalnya perubahan pada inisialisasi aplikasi atau variabel global.

Dengan demikian, hot reload digunakan untuk perubahan yang tidak memerlukan inisialisasi ulang, sedangkan hot restart digunakan ketika aplikasi perlu dimulai kembali.

### Tugas 8

#### 1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop()!

Ketiga method tersebut digunakan untuk mengatur navigasi antarhalaman dalam aplikasi Flutter.

Navigator.push() digunakan untuk membuka halaman baru di atas halaman sebelumnya. Halaman sebelumnya tetap berada di navigation stack sehingga pengguna dapat kembali menggunakan tombol Back.

Navigator.pushReplacement() digunakan untuk membuka halaman baru sekaligus menggantikan halaman yang sedang aktif. Halaman sebelumnya dihapus dari navigation stack sehingga tidak dapat dikembalikan melalui tombol Back.

Navigator.pop() digunakan untuk menutup halaman yang sedang aktif dan kembali ke halaman sebelumnya dalam navigation stack.

Pada proyek ini, Navigator.push() digunakan ketika pengguna membuka halaman Add Project atau Add Experience. Sementara itu, Navigator.pushReplacement() digunakan ketika pengguna memilih menu Home dari Drawer agar halaman sebelumnya digantikan oleh halaman Home.

#### 2. Jelaskan fungsi dari Scaffold, AppBar, dan Drawer dalam pengembangan aplikasi Flutter!

Scaffold menyediakan struktur dasar halaman aplikasi Material Design, seperti AppBar, Drawer, dan body.

AppBar merupakan bilah yang berada di bagian atas halaman dan biasanya digunakan untuk menampilkan judul serta aksi navigasi.

Drawer merupakan panel navigasi yang muncul dari sisi layar dan menyediakan pilihan menu untuk berpindah halaman.

Pada proyek ini, Scaffold digunakan sebagai struktur utama halaman Home, Add Project, dan Add Experience. AppBar menampilkan judul setiap halaman, sedangkan Drawer menyediakan navigasi menuju Home, Add Project, dan Add Experience.

#### 3. Jelaskan bagaimana cara memilih widget layout yang tepat untuk membuat tampilan aplikasi yang responsif! Apa fungsi dari widget seperti Padding, SingleChildScrollView, dan GridView?

Pemilihan widget layout perlu disesuaikan dengan susunan konten, ukuran layar, dan kebutuhan interaksi pengguna.

Padding digunakan untuk memberikan jarak antara konten dengan batas area atau widget lainnya agar tampilan lebih rapi.

SingleChildScrollView memungkinkan konten yang ukurannya melebihi ruang layar untuk digulir, sehingga dapat mengurangi masalah overflow.

GridView digunakan untuk menampilkan beberapa widget dalam bentuk grid atau susunan baris dan kolom.

Pada proyek ini, SingleChildScrollView digunakan pada halaman Home agar konten dapat digulir ketika ukuran layar tidak cukup untuk menampilkan seluruh konten. GridView.count digunakan untuk menyusun kartu menu, sedangkan Padding digunakan untuk mengatur jarak antarbagian tampilan.

#### 4. Jelaskan fungsi dari GlobalKey<FormState>, validator, dan validate() dalam proses validasi form di Flutter!

Ketiganya memiliki peran yang saling berkaitan dalam proses validasi form.

GlobalKey<FormState> digunakan untuk mengidentifikasi dan mengakses state dari sebuah widget Form, sehingga proses validasi dapat dijalankan melalui key tersebut.

validator merupakan fungsi yang digunakan untuk memeriksa nilai input pengguna. Jika input tidak memenuhi ketentuan, fungsi ini mengembalikan pesan kesalahan.

validate() digunakan untuk menjalankan seluruh fungsi validator pada field yang berada di dalam Form. Jika semua input valid, fungsi ini mengembalikan nilai true; jika terdapat input yang tidak valid, hasilnya false.

Pada proyek ini, GlobalKey<FormState> digunakan untuk mengakses form pada halaman Add Experience. Setiap field yang wajib diisi memiliki validator untuk memastikan pengguna tidak mengirimkan input kosong atau hanya berisi spasi. Ketika tombol Save ditekan, validate() dijalankan sebelum data ditampilkan melalui AlertDialog.

#### 5. Implementasi Form Experience

Saya menambahkan halaman Add Experience menggunakan StatefulWidget dan Form. Form ini memiliki input Title, Description, Category, Thumbnail URL (opsional), serta checkbox Currently Ongoing dan Ended At yang muncul jika pengalaman sudah selesai.

Setiap input memiliki validasi sesuai kebutuhannya. Title dan Description wajib diisi, Thumbnail URL harus valid jika diisi, dan Ended At wajib dipilih jika pengalaman sudah selesai.

Setelah validasi berhasil, data yang dimasukkan akan ditampilkan melalui AlertDialog. Halaman ini juga dapat diakses melalui kartu di Home dan menu pada Drawer.

#### 6. Penggunaan AI

Dalam pengerjaan tugas ini, saya menggunakan ChatGPT sebagai alat bantu untuk memahami materi Flutter, menyusun struktur halaman form, membantu proses debugging, serta memeriksa implementasi navigasi dan validasi form.

Saya tetap menjalankan dan menguji aplikasi secara mandiri untuk memastikan setiap fitur berjalan sesuai dengan kebutuhan tugas. Seluruh implementasi juga diperiksa kembali dan disesuaikan dengan struktur serta kebutuhan proyek MyPortfolio Mobile.

### Tugas 9

#### 1. Mengapa menggunakan `@JsonSerializable(fieldRename: FieldRename.snake)` dan `@JsonKey(includeToJson: false)` alih-alih mengirim objek `Map<String, dynamic>` mentah langsung dari widget? Jelaskan satu bug yang dicegah atau dapat dicegah oleh pendekatan ini pada model bagianmu.

Pada proyek ini, saya menggunakan `@JsonSerializable(fieldRename: FieldRename.snake)` untuk membantu proses serialisasi dan deserialisasi data antara Flutter dan Django REST Framework. Anotasi tersebut secara otomatis menyesuaikan penamaan field dari format camelCase yang digunakan Dart menjadi snake_case yang digunakan oleh serializer Django. Contohnya, field `startYear` pada model Dart akan dipetakan menjadi `start_year` pada JSON.

Sementara itu, `@JsonKey(includeToJson: false)` digunakan pada field `id` karena nilai tersebut ditentukan oleh server ketika data dibuat. Dengan demikian, `id` tidak ikut dikirim ketika Flutter mengirimkan data melalui POST.

Pendekatan ini membuat pengelolaan data lebih terstruktur dibandingkan menyusun `Map<String, dynamic>` secara manual di dalam widget. Selain mengurangi kode berulang, pendekatan ini juga membantu mencegah kesalahan penamaan key JSON dan pengiriman field yang seharusnya dikelola oleh server, seperti `id`.

#### 2. Mengapa Future yang diteruskan ke FutureBuilder harus diinisialisasi di dalam initState() alih-alih langsung di dalam build(), dan mengapa ApiClient sebaiknya melempar ApiException daripada mengembalikan null pada respons HTTP non-2xx?

Future diinisialisasi di dalam `initState()` agar permintaan HTTP hanya dijalankan ketika screen pertama kali dibuat. Jika Future dibuat langsung di dalam `build()`, setiap kali widget mengalami rebuild, permintaan HTTP dapat dijalankan kembali. Hal tersebut dapat menyebabkan request berulang yang tidak diperlukan.

Pada proyek ini, `EducationListScreen` menyimpan Future pada variabel `_educationsFuture` yang diinisialisasi melalui `initState()`. Ketika pengguna melakukan refresh atau retry, Future diperbarui secara eksplisit.

Selain itu, `ApiClient` menggunakan `ApiException` untuk menangani respons HTTP dengan status non-2xx. Dengan exception, informasi seperti status code dan pesan error dapat diteruskan ke screen untuk ditangani sesuai kondisinya. Contohnya, ketika server mengembalikan status 401, aplikasi dapat menghapus sesi pengguna dan meminta pengguna login kembali.

Jika `ApiClient` hanya mengembalikan `null`, pemanggil akan kesulitan membedakan antara data yang memang kosong dan kegagalan request. Oleh karena itu, penggunaan `ApiException` membuat penanganan error lebih jelas dan terstruktur.

#### 3. Bandingkan SessionAuthentication milik Django dengan TokenAuthentication milik DRF. Mengapa myportofolio_mobile menggunakan TokenAuthentication sementara SessionAuthentication tetap diaktifkan pada backend Django?

`SessionAuthentication` menggunakan session Django yang disimpan melalui cookie untuk mengenali pengguna yang sudah login. Mekanisme ini sesuai untuk aplikasi web Django yang menggunakan sistem login berbasis session dan cookie.

Sementara itu, `TokenAuthentication` menggunakan token yang dikirim melalui HTTP header `Authorization` dengan format `Token <key>`. Token tersebut digunakan untuk mengidentifikasi pengguna ketika melakukan request ke API.

Pada proyek ini, aplikasi `myportofolio_mobile` menggunakan `TokenAuthentication` karena komunikasi antara Flutter dan Django REST Framework dilakukan melalui HTTP request yang menyertakan token. Token diperoleh ketika pengguna login dan disimpan melalui `AuthState`.

`SessionAuthentication` tetap diaktifkan pada backend karena masih digunakan oleh website portofolio Django yang sudah ada. Dengan demikian, kedua mekanisme autentikasi dapat digunakan sesuai kebutuhan masing-masing klien tanpa menghilangkan sistem login website sebelumnya.

#### 4. Jelaskan peran job build (very_good_workflows) dan build_apk dalam pipeline GitHub Actions milikmu. Mengapa berkas *.g.dart dimasukkan ke .gitignore meskipun CI membutuhkannya?

Workflow CI/CD pada proyek ini memiliki dua job utama, yaitu `build` dan `build_apk`.

Job `build` menggunakan reusable workflow `VeryGoodOpenSource/very_good_workflows` untuk menjalankan pemeriksaan kualitas kode secara otomatis, seperti formatting, static analysis, dan pengujian menggunakan Flutter test. Proses code generation juga dilakukan agar model JSON dapat digunakan selama pemeriksaan dan build.

Job `build_apk` bertugas membangun aplikasi Flutter menjadi APK release setelah job `build` berhasil dijalankan. Job ini menggunakan `needs: build` agar proses build APK hanya dilakukan ketika pemeriksaan pada job sebelumnya berhasil. Setelah APK selesai dibuat, file tersebut diunggah menggunakan `actions/upload-artifact@v4` dengan nama `app-release-apk`, sehingga hasil build dapat diunduh dari GitHub Actions.

Berkas `*.g.dart` dimasukkan ke `.gitignore` karena merupakan hasil generate dari `build_runner`, bukan kode sumber yang perlu dikelola secara manual. Namun, CI tetap membutuhkannya untuk proses analysis dan build aplikasi. Oleh karena itu, workflow menjalankan `dart run build_runner build --delete-conflicting-outputs` terlebih dahulu agar berkas tersebut dihasilkan kembali secara otomatis di lingkungan CI.

#### 5. Implementasi Integrasi Education

Pada tugas ini, saya mengintegrasikan bagian Education dari backend Django REST Framework ke aplikasi MyPortfolio Mobile menggunakan Flutter.

Implementasi ini mencakup model Education dengan json_serializable, serta penambahan beberapa fitur pada ApiClient untuk mengambil, menambahkan, dan menghapus data Education melalui API.

Saya juga membuat halaman Education List menggunakan FutureBuilder dan RefreshIndicator untuk menampilkan data dari backend. Setiap item dapat dipilih untuk membuka halaman Education Detail yang menampilkan informasi lengkap. Selain itu, terdapat halaman Education Form untuk menambahkan data baru ke backend.

Untuk autentikasi, fitur penambahan data menggunakan token yang disimpan melalui AuthState dan memerlukan login melalui ensureLoggedIn(context). Aplikasi juga menangani error dari API, termasuk status 401 ketika sesi pengguna sudah tidak valid.

Halaman Education dapat diakses melalui kartu aksi di Home dan menu pada LeftDrawer. Saya juga menambahkan fitur Delete dengan mengikuti permission yang diterapkan pada backend Django.

Cara Menjalankan Proyek

Sebelum menjalankan aplikasi, pastikan dependency sudah diunduh dan model JSON sudah di-generate menggunakan perintah berikut:

flutter pub get
dart run build_runner build --delete-conflicting-outputs

Untuk menjalankan aplikasi menggunakan backend lokal pada Android Emulator:

flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000

Untuk menggunakan backend yang sudah di-deploy, gunakan URL berikut:

flutter run --dart-define=API_BASE_URL=https://mutia-muthmainnah-myportofolio.pws.cs.ui.ac.id

Repository backend Django: https://github.com/mutiamth/myportofolio

API backend: https://mutia-muthmainnah-myportofolio.pws.cs.ui.ac.id/api/v1/educations/

#### 6. Penggunaan AI

Dalam pengerjaan tugas ini, saya menggunakan ChatGPT sebagai alat bantu untuk memahami konsep integrasi Flutter dengan Django REST Framework, menyusun model JSON menggunakan `json_serializable`, mengimplementasikan pemanggilan API melalui `ApiClient`, serta memahami autentikasi token dan konfigurasi GitHub Actions.

Saya menggunakan AI secara bertahap dengan memberikan potongan kode, pesan error, dan hasil pengujian untuk memperoleh penjelasan maupun saran perbaikan yang sesuai dengan kondisi proyek. Bantuan AI juga digunakan untuk memeriksa implementasi Education List, Detail, Form, navigasi, dan penanganan error.

Namun, hasil yang diberikan AI tidak langsung diterapkan tanpa pemeriksaan. Saya menyesuaikan implementasi dengan struktur proyek dan konfigurasi backend yang sudah ada, kemudian menjalankan pengujian secara mandiri menggunakan emulator, `dart format`, `flutter analyze`, dan `flutter test`. Saya juga memeriksa kembali hasil implementasi agar sesuai dengan kebutuhan Tugas 9.