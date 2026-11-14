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