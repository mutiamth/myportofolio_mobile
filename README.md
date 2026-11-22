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